import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:ritual_cafe/clients/auth/decoration.dart';
import 'package:ritual_cafe/collections/colors.dart';
import 'package:ritual_cafe/models/json/collectionjson.dart';
import 'package:ritual_cafe/services/services.dart';
import 'package:provider/provider.dart';
import '../loadding.dart';
import 'ExpandedListAnimationWidget.dart';
import 'Scrollbar.dart';

class Collections extends StatelessWidget {
 final  Services serv;
   Collections(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value:this.serv,
      child:CollectionFull(serv) ,
    );
  }
}
class CollectionFull extends StatefulWidget {
  final Services serv;
   CollectionFull(this.serv);

  @override
  _CollectionFullState createState() => _CollectionFullState();
}

class _CollectionFullState extends State<CollectionFull> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  List<bool> etats =[];
  List<String> foodList =[];
  List<String> stableList =[];
  bool inSeach = false;
  final rechercheController = TextEditingController();
  @override
  void dispose() {
    rechercheController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery .of(context).size.width;
    return Consumer<Services>(
      builder: (context,servs,_)=>
      !servs.onCollection?
       FutureBuilder<CollectionsJson>(
          future: servs.collection(),
          builder: (BuildContext context,
              AsyncSnapshot<CollectionsJson> snapshot) {
            if (snapshot.hasData) {
              CollectionsJson collections = snapshot.data;
              stableList = grnaratelist(collections) ;
              return   Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                    centerTitle: true,
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/logo.jpg',
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(8.0), child:
                            Text( "Ritual Café",
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 36
                          ),)),
                       
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: 
                           CachedNetworkImage(
                               imageUrl: servs.registerUser.profilePicture!=null?servs.registerUser.profilePicture:'https://ssscompagnie.com/images/le_systeme/1.jpg',//
                               placeholder: (context, url) =>
                                   Center(child: CircularProgressIndicator()),
                               errorWidget: (context, url, error) => Icon(Icons.error),
                               height: 40,
                               width: 40,
                               fit: BoxFit.cover,

                             )
                          
                        )
                      ],

                    ) ,

                  ),
                  body: ListView(
                children: [
                  Padding(padding: EdgeInsets.only(right: 31,left: 31,top: 5),
                    child: Text('Consommer le meilleur \nCafé du Cameroun ',
                      style:TextStyle(color: principalTextColor,
                      fontSize: 26,
                        fontWeight: FontWeight.bold
                      ) ,),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 5),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Container(
                                    //decoration: BoxDecoration(border: Border.all(color: secondaryTextColor),borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 11.0,color: principalTextColor,fontStyle: FontStyle.italic),
                                            cursorColor: principalTextColor,
                                            controller: rechercheController,
                                            decoration: InputDecoration(
                                                fillColor: secondaryColor,
                                                filled: true,
                                                border: OutlineInputBorder(borderRadius:
                                                BorderRadius.all(Radius.circular(10.0))),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  borderSide: BorderSide(color: secondaryTextColor,width: 0),
                                                ),
                                                contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.all(0.0),
                                                  child:GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        foodList = [];
                                                        for(int i=0; i<stableList.length; i++)
                                                        {

                                                          if(stableList[i].toLowerCase().contains(rechercheController.text.toLowerCase()))
                                                          {
                                                            setState(() {
                                                              foodList.add(stableList[i]);
                                                            });
                                                          }

                                                        }
                                                      });
                                                    },
                                                    child:  Icon(
                                                      Icons.search,
                                                      color: secondaryTextColor,
                                                    ),
                                                  ), // icon is 48px widget.
                                                ),
                                                suffixIcon: inSeach? Padding(
                                                  padding: EdgeInsets.all(0.0),
                                                  child:GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        inSeach = false;
                                                        rechercheController.text = '';
                                                      });
                                                    },
                                                    child:  Icon(
                                                      Icons.cancel_outlined,
                                                      color: secondaryTextColor,
                                                    ),
                                                  ), // icon is 48px widget.
                                                ):
                                                Container(width: 0,height: 0,),
                                                labelText: 'Trouver votre plaisir',
                                                labelStyle: TextStyle(fontSize: 20.0,color: secondaryTextColor)),
                                            onTap: (){
                                              setState(() {
                                                inSeach = true;
                                              });
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                    foodList = [];
                                                    for(int i=0; i<stableList.length; i++)
                                                    {

                                                      if(stableList[i].toLowerCase().contains(rechercheController.text.toLowerCase()))
                                                      {
                                                        setState(() {
                                                          foodList.add(stableList[i]);
                                                        });
                                                      }

                                                    }
                                              });
                                            }
                                        ),
                                        Container(
                                          //decoration: BoxDecoration(border: Border.all(color: secondaryTextColor),borderRadius: BorderRadius.all(Radius.circular(10))),
                                          child: ExpandedSection(
                                            expand: inSeach,
                                            height: 100,
                                            child: MyScrollbar(

                                              builder: (context, scrollController2) =>
                                                  ListView.builder(
                                                      padding: EdgeInsets.all(0),
                                                      controller: scrollController2,
                                                      shrinkWrap: true,
                                                      itemCount: foodList.length,
                                                      itemBuilder: (context, index) {
                                                        return foodList.length>0?
                                                        GestureDetector(
                                                          onTap: (){

                                                            setState(() {
                                                              etats[servs.indexCollection] = false;
                                                              servs.indexCollection= stableList.indexOf(foodList[index]);
                                                              etats[servs.indexCollection] = true;
                                                              inSeach = !inSeach;
                                                              rechercheController.text = foodList[index];

                                                            });
                                                          },
                                                          child: ListTile(
                                                              leading:  Container(
                                                                  height:30,
                                                                  width: 30,
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: NetworkImage(collections.data[stableList.indexOf(foodList[index])].produits[0].medias[0].link),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)
                                                                    ),
                                                                  )) ,
                                                              title:  Text(foodList[index],style: TextStyle(color: principalTextColor),maxLines: 2,),

                                                          ),
                                                        )
                                                        :Text(
                                                          'Aucune collections ne correspond a cette recherche',
                                                          style: TextStyle(
                                                              fontSize: 10,fontStyle: FontStyle.italic,color: secondaryTextColor ,fontWeight: FontWeight.w600),
                                                        );
                                                      }),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 5),
                      child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                       child:  Row(
                        children: createlistcollection(collections,servs),
                      )
                      ),
                    ),

                  Padding(padding: EdgeInsets.only(left: 30,right: 30,bottom: 8,top: 5),
                    child: Container(

                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:  Row(
                            children: createlistcard(collections,width/2.6,servs),
                          )
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 30,left: 30,top: 20,bottom: 15),
                    child: Text('Spécialement pour vous',
                      style:TextStyle(color: principalTextColor,
                        fontSize: 16,
                      ) ,)
                  ),

                   Padding(padding: EdgeInsets.only(left: 30,right: 30,),
                     child: Container(
                       decoration: BoxDecoration(
                         gradient: gard,
                         borderRadius: BorderRadius.circular(14),
                       ),
                       child:  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 5,top: 8,bottom: 8),
                           child:ClipRRect(
                             borderRadius: BorderRadius.circular(20),
                             child: CachedNetworkImage(
                               imageUrl: collections.data[servs.indexCollection].produits[0].medias[0].link,
                               placeholder: (context, url) =>
                                   Center(child: CircularProgressIndicator()),
                               errorWidget: (context, url, error) => Icon(Icons.error),
                               height: 100,
                               width: 100,
                               fit: BoxFit.cover,

                             )
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 5),
                           child: Container(
                             width: width-180,
                             child: Column(
                               children: [
                                 Text("3 recettes de cafe que vous devez essayer",maxLines: 2,
                                 style: TextStyle(fontSize: 16,color: principalTextColor),
                                 ),
                                 SizedBox(height: 55,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text('En savoir plus',
                                     style: TextStyle(color: principalTextColor),
                                     ),
                                     GestureDetector(
                                       onTap:(){
                                         servs.indexProduit = 0;
                                         Navigator.pushNamed(context,
                                             '/produits',
                                             arguments: servs
                                         );
                                       },
                                      child: Icon(Icons.trending_flat,color: primaryColor,size: 20,),
                                     )
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         )
                       ],
                     ),

                   ),
                   )



                  ],
                    ),
                  );//si non ouvrir page de login et singin

            }
            else
            {
              return Loadding();
            }
          }
      ):
       Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                    centerTitle: true,
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/logo.jpg',
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(8.0), child:
                            Text( "Ritual Café",
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 36
                          ),)),
                          
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child:
                             CachedNetworkImage(
                               imageUrl: servs.registerUser.profilePicture!=null?servs.registerUser.profilePicture:'https://ssscompagnie.com/images/le_systeme/1.jpg',//
                               placeholder: (context, url) =>
                                   Center(child: CircularProgressIndicator()),
                               errorWidget: (context, url, error) => Icon(Icons.error),
                               height: 40,
                               width: 40,
                               fit: BoxFit.cover,

                             )
                            
                          
                        ) 
                      ],

                    ) ,

                  ),
                  body: ListView(
                children: [
                  Padding(padding: EdgeInsets.only(right: 31,left: 31,top: 5),
                    child: Text('Consommer le meilleur \nCafé du Cameroun ',
                      style:TextStyle(color: principalTextColor,
                      fontSize: 26,
                        fontWeight: FontWeight.bold
                      ) ,),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 5),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Container(
                                    //decoration: BoxDecoration(border: Border.all(color: secondaryTextColor),borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 11.0,color: principalTextColor,fontStyle: FontStyle.italic),
                                            cursorColor: principalTextColor,
                                            controller: rechercheController,
                                            decoration: InputDecoration(
                                                fillColor: secondaryColor,
                                                filled: true,
                                                border: OutlineInputBorder(borderRadius:
                                                BorderRadius.all(Radius.circular(10.0))),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  borderSide: BorderSide(color: secondaryTextColor,width: 0),
                                                ),
                                                contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.all(0.0),
                                                  child:GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        foodList = [];
                                                        for(int i=0; i<stableList.length; i++)
                                                        {

                                                          if(stableList[i].toLowerCase().contains(rechercheController.text.toLowerCase()))
                                                          {
                                                            setState(() {
                                                              foodList.add(stableList[i]);
                                                            });
                                                          }

                                                        }
                                                      });
                                                    },
                                                    child:  Icon(
                                                      Icons.search,
                                                      color: secondaryTextColor,
                                                    ),
                                                  ), // icon is 48px widget.
                                                ),
                                                suffixIcon: inSeach? Padding(
                                                  padding: EdgeInsets.all(0.0),
                                                  child:GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        inSeach = false;
                                                        rechercheController.text = '';
                                                      });
                                                    },
                                                    child:  Icon(
                                                      Icons.cancel_outlined,
                                                      color: secondaryTextColor,
                                                    ),
                                                  ), // icon is 48px widget.
                                                ):
                                                Container(width: 0,height: 0,),
                                                labelText: 'Trouver votre plaisir',
                                                labelStyle: TextStyle(fontSize: 20.0,color: secondaryTextColor)),
                                            onTap: (){
                                              setState(() {
                                                inSeach = true;
                                              });
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                    foodList = [];
                                                    for(int i=0; i<stableList.length; i++)
                                                    {

                                                      if(stableList[i].toLowerCase().contains(rechercheController.text.toLowerCase()))
                                                      {
                                                        setState(() {
                                                          foodList.add(stableList[i]);
                                                        });
                                                      }

                                                    }
                                              });
                                            }
                                        ),
                                        Container(
                                          //decoration: BoxDecoration(border: Border.all(color: secondaryTextColor),borderRadius: BorderRadius.all(Radius.circular(10))),
                                          child: ExpandedSection(
                                            expand: inSeach,
                                            height: 100,
                                            child: MyScrollbar(

                                              builder: (context, scrollController2) =>
                                                  ListView.builder(
                                                      padding: EdgeInsets.all(0),
                                                      controller: scrollController2,
                                                      shrinkWrap: true,
                                                      itemCount: foodList.length,
                                                      itemBuilder: (context, index) {
                                                        return foodList.length>0?
                                                        GestureDetector(
                                                          onTap: (){

                                                            setState(() {
                                                              etats[servs.indexCollection] = false;
                                                              servs.indexCollection= stableList.indexOf(foodList[index]);
                                                              etats[servs.indexCollection] = true;
                                                              inSeach = !inSeach;
                                                              rechercheController.text = foodList[index];

                                                            });
                                                          },
                                                          child: ListTile(
                                                              leading:  Container(
                                                                  height:30,
                                                                  width: 30,
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: NetworkImage(servs.collections.data[stableList.indexOf(foodList[index])].produits[0].medias[0].link),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)
                                                                    ),
                                                                  )) ,
                                                              title:  Text(foodList[index],style: TextStyle(color: principalTextColor),maxLines: 2,),

                                                          ),
                                                        )
                                                        :Text(
                                                          'Aucune collections ne correspond a cette recherche',
                                                          style: TextStyle(
                                                              fontSize: 10,fontStyle: FontStyle.italic,color: secondaryTextColor ,fontWeight: FontWeight.w600),
                                                        );
                                                      }),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 5),
                      child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                       child:  Row(
                        children: createlistcollection(servs.collections,servs),
                      )
                      ),
                    ),

                  Padding(padding: EdgeInsets.only(left: 30,right: 30,bottom: 8,top: 5),
                    child: Container(

                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:  Row(
                            children: createlistcard(servs.collections,width/2.6,servs),
                          )
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 30,left: 30,top: 20,bottom: 15),
                    child: Text('Spécialement pour vous',
                      style:TextStyle(color: principalTextColor,
                        fontSize: 16,
                      ) ,)
                  ),

                   Padding(padding: EdgeInsets.only(left: 30,right: 30,),
                     child: Container(
                       decoration: BoxDecoration(
                         gradient: gard,
                         borderRadius: BorderRadius.circular(14),
                       ),
                       child:  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 5,top: 8,bottom: 8),
                           child:ClipRRect(
                             borderRadius: BorderRadius.circular(20),
                             child: CachedNetworkImage(
                               imageUrl: servs.collections.data[servs.indexCollection].produits[0].medias[0].link,
                               placeholder: (context, url) =>
                                   Center(child: CircularProgressIndicator()),
                               errorWidget: (context, url, error) => Icon(Icons.error),
                               height: 100,
                               width: 100,
                               fit: BoxFit.cover,

                             )
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 5),
                           child: Container(
                             width: width-180,
                             child: Column(
                               children: [
                                 Text("3 recettes de cafe que vous devez essayer",maxLines: 2,
                                 style: TextStyle(fontSize: 16,color: principalTextColor),
                                 ),
                                 SizedBox(height: 55,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text('En savoir plus',
                                     style: TextStyle(color: principalTextColor),
                                     ),
                                     GestureDetector(
                                       onTap:(){
                                         servs.indexProduit = 0;
                                         Navigator.pushNamed(context,
                                             '/produits',
                                             arguments: servs
                                         );
                                       },
                                      child: Icon(Icons.trending_flat,color: primaryColor,size: 20,),
                                     )
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         )
                       ],
                     ),

                   ),
                   )



                  ],
       
       ))//si non ouvrir page de login et singin

           
    );
  }
  List<String>grnaratelist(CollectionsJson collectionsJson){
    List<String> l =[];
    var data =collectionsJson.data;
    for(var i =0;i<data.length;i++){
      l.add(data[i].name);
    }
    return l;
  }
  List<Widget>createlistcollection(CollectionsJson collectionsJson,Services servs){
    List<Widget> l =[];
    var data =collectionsJson.data;
    for(var i =0;i<data.length;i++){
      i == 0? etats.add(true):etats.add(false);
      Widget cols = GestureDetector(
          child: Column(
            children: [
              Text(data[i].name,style: TextStyle(
                fontSize: 15,
                color: etats[i] ? primaryColor:secondaryColorSombre
              ),),
              SizedBox(height: 5,),
              etats[i] ? Icon(Icons.circle,color: primaryColor,size: 6,): Container(width: 0,height: 0,)
            ]
          ),
        onTap:(){
            setState(() {
              etats[servs.indexCollection] = false;
              servs.indexCollection= i;
              etats[servs.indexCollection] = true;
            });
        },
      
      );
      
      l.add(cols);
      l.add(SizedBox(width: 15,));
    }
    return l;
  }
  List<Widget>createlistcard(CollectionsJson collectionsJson,double width,Services servs){
    List<Widget> l =[];
    var data =collectionsJson.data[servs.indexCollection].produits;
    for(var i =0;i<data.length;i++){
      Widget cols = Container(
          width: width ,
        decoration: BoxDecoration(

          gradient: gard,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(14),
            ),
            child:  Column(
              children: [
                Container(
                  height:width-20,
                  width: width-20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage( data[i].medias[0].link),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                          right: 0,
                          child:Container(
                            decoration: BoxDecoration(
                            //  color: Color.fromRGBO(15, 18, 25, 1),// Color.fromRGBO(82, 92, 113, 1),
                              //gradient: gard,
                              color: Colors.black54,
                              borderRadius:BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                     ),

                            ),
                          child: Padding(padding: EdgeInsets.only(top: 2,bottom: 2,left: 15,right: 15),
                            child: Row(
                              children: [
                                Icon(Icons.star,color: primaryColor,size: 13,),
                                SizedBox(width: 2,),
                                Text(createNote(data[i].avis),style: TextStyle(fontWeight: FontWeight.bold,color: principalTextColor,fontSize: 13),),

                              ],
                            ),
                          ),
                          )
                      )
                    ],
                  ),
                ),
                Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5,),
                        Text(data[i].name,
                          style: TextStyle(fontSize: 16,color: principalTextColor,fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 5,),
                        Text(data[i].tags[0].name,
                          style: TextStyle(
                              fontSize: 10,
                              color: secondaryTextColor),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(data[i].price.toString(),
                                  style: TextStyle(color: principalTextColor,fontWeight: FontWeight.bold),
                                ),
                                Text("F.CFA".toString(),
                                  style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                             GestureDetector(
                               onTap:(){
                                 servs.indexProduit = i;
                                 Navigator.pushNamed(context,
                                     '/produits',
                                   arguments: servs
                                 );
                               },
                               child:
                               Container(
                                 decoration: BoxDecoration(
                                  color: primaryColor,
                                   borderRadius: BorderRadius.circular(4),
                                 ),
                                 child: Icon(Icons.add,color: principalTextColor,size: 20,),),
                             )
                             //Icon(Icons.add,color: principalTextColor,size: 20,)
                          ],
                        ),
                      ],
                    ),
                )
              ],
            ),

          )

        )

      );
      l.add(cols);
      l.add(SizedBox(width: 15,));
    }
    return l;
  }createNote(List<Avis >avis){
      String note = '';
      double notes = 0;
      for(int i = 0;i<avis.length;i++){
        notes = notes + avis[i].note;
      }
      if(avis.length>0) notes = notes/avis.length;
      note = notes.toStringAsPrecision(1);
      note = note.split('.').length >1? note.split('.')[0]  + ','+note.split('.')[1] : note;
      return note;
    }
}