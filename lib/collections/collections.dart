import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ritual_cafe/clients/auth/decoration.dart';
import 'package:ritual_cafe/models/json/collectionjson.dart';
import 'package:ritual_cafe/services/services.dart';
import 'package:provider/provider.dart';
import '../loadding.dart';

class Collections extends StatelessWidget {
 final  Services serv;
   Collections(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (create)=>Services(serv.user),
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
  void recherche(){

  }
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
      builder: (context,servs,_)=> FutureBuilder<CollectionsJson>(
          future: servs.collection(),
          builder: (BuildContext context,
              AsyncSnapshot<CollectionsJson> snapshot) {
            if (snapshot.hasData) {
              CollectionsJson collections = snapshot.data;
            return   Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    centerTitle: true,
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.grid_view,color: Colors.grey,),
                        Container(
                            padding: const EdgeInsets.all(8.0), child:
                            Text( "Ritual Café",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 36
                          ),)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/img.jpg',
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        )
                      ],

                    ) ,

                  ),
                  body: ListView(
                children: [
                  Padding(padding: EdgeInsets.only(right: 31,left: 31,top: 5),
                    child: Text('Consommer le meilleur ',
                      style:TextStyle(color: Colors.white,
                      fontSize: 25,
                      ) ,),
                  ),
                  Padding(padding: EdgeInsets.only(right: 30,left: 30,top: 5,bottom: 5),
                    child: Text('Café du Cameroun',
                      style:TextStyle(color: Colors.white,
                        fontSize: 25,
                      ) ,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                    top: 16.0, left: 30.0, right: 30.0, bottom: 8.0),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 11.0),
                      cursorColor: Colors.white,
                      controller: rechercheController,
                      decoration: InputDecoration(
                          fillColor: Colors.white12,
                          filled: true,
                          border: OutlineInputBorder(borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                          contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child:GestureDetector(
                              onTap: (){recherche();},
                              child:  Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ), // icon is 48px widget.
                          ),
                          labelText: 'Trouver votre plaisir',
                          labelStyle: TextStyle(fontSize: 20.0,color: Colors.grey)),
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
                      style:TextStyle(color: Colors.white,
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
                                 style: TextStyle(fontSize: 16,color: Colors.white),
                                 ),
                                 SizedBox(height: 55,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text('En savoir plus',
                                     style: TextStyle(color: Colors.white),
                                     ),
                                     Icon(Icons.trending_flat,color: Colors.orange,size: 20,)
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
                    bottomNavigationBar: navyBottomBar(),
                  );//si non ouvrir page de login et singin

            }
            else
            {
              return Loadding();
            }
          }
      ),
    );
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
                color: etats[i] ? Colors.orange:Colors.grey
              ),),
              SizedBox(height: 5,),
              etats[i] ? Icon(Icons.circle,color: Colors.orange,size: 6,): Container(width: 0,height: 0,)
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
                              color: Colors.grey.withOpacity(0.8),
                              borderRadius:BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                     ),

                            ),
                          child: Padding(padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Icon(Icons.star,color: Colors.orange,size: 10,),
                                SizedBox(width: 15,),
                                Text("4,5",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 8),),

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
                          style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5,),
                        Text(data[i].tags[0].name,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(data[i].price.toString(),
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                ),
                                Text("F.CFA".toString(),
                                  style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold),
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
                                   color: Colors.orange,
                                   borderRadius: BorderRadius.circular(4),
                                 ),
                                 child: Icon(Icons.add,color: Colors.white,size: 20,),),
                             )
                             //Icon(Icons.add,color: Colors.white,size: 20,)
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
  }
  Widget navyBottomBar() {
    return   BottomNavigationBar(
         showSelectedLabels: false,
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: '',
        backgroundColor: Colors.white10,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag),
        label: '',
        backgroundColor: Colors.white10,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: '',
        backgroundColor: Colors.white10,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        label: '',
        backgroundColor:Colors.white10,
        ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor:  Colors.grey,
        onTap: _onItemTapped,
    );
  }

}
