import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ritual_cafe/models/json/collectionjson.dart';
import 'package:ritual_cafe/models/optionParameter.dart';
import 'package:ritual_cafe/services/services.dart';
import 'ExpandedListAnimationWidget.dart';
import 'Scrollbar.dart';

class ViewProduit extends StatelessWidget {
  Services serv;
 ViewProduit(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (create)=>serv,
    child:ViewProduitFull(serv) ,
    );
  }
}
class ViewProduitFull extends StatefulWidget {
  Services serv;
   ViewProduitFull(this.serv);

  @override
  _ViewProduitFullState createState() => _ViewProduitFullState();
}

class _ViewProduitFullState extends State<ViewProduitFull> {
  int priceadd = 0;
  int price = 0;
  bool lirePlus = false;
  List<bool> viewVariant = [];
  List<bool> requiredVarriant = [];
  List<OptionParameter> optionsParameters = [];
  @override
  Widget build(BuildContext context) {
   var produit = widget.serv.collections.data[widget.serv.indexCollection].produits[widget.serv.indexProduit] ;
    price = produit.price;

   double width = MediaQuery .of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Container(
              height:width,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(produit.medias[0].link),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20.0)
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.all(Radius.circular(10.0),
                        ),
                      ),
                      width: 30,
                      height: 30,
                      child: IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.arrow_back_ios, color: Colors.grey,size: 15,),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                    ),
                    ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: width,
                        decoration: BoxDecoration(
                          color: Colors.brown.withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(20.0),),
                        ),
                  //    ),
                      child: Padding(padding: EdgeInsets.all(10),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(produit.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                          SizedBox(height: 15,),
                          Text(produit.tags[0].name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Icon(Icons.star,color: Colors.orange,),
                              SizedBox(width: 15,),
                              Text("4,5",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                              SizedBox(width: 15,),
                              Text("("+produit.avis.length.toString()+")",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                            ],
                          ),
                        ],
                      ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Text('Description',
              style: TextStyle(color: Colors.grey,fontSize: 15),),
            SizedBox(height: 15,),
            produit.description !=null?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: lirePlus? grandeDescription(produit.description.split('<p>')[1].split(';')):
              petiteDescription(produit.description.split('<p>')[1].split(';')),
            )
                :
            Container(width: 0,height: 0,),
            Padding(padding: EdgeInsets.all(16),
            child: Column(
              children: chowVarriantes(produit.variants),
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Prix",
                      style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text((price+priceadd).toString(),
                            style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        Text(" F.CFA",
                          style: TextStyle(color: Colors.orangeAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: width-140,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text("Acheter Maintenant",textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
List<Widget>grandeDescription(List<String> a){

  double width = MediaQuery .of(context).size.width;
    List<Widget> l = [];

    for(int i = 0;i<a.length;i++){
      if(a.length == i+1)
        {
          Widget text =   Row(
            children: [
              Container(
                child: Text(a[i].split('</p')[0],
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),),
                width: width-150,
              ),
              Container( width:70,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        lirePlus = false;
                      });
                    },
                    child: Text('... moins',style: TextStyle(color: Colors.orange),),
                  ))
              ,
            ],
          );
          Text(a[i],
          maxLines: 2,
          style: TextStyle(color: Colors.white),);
          l.add(text);

        }
      else{
        Widget text = Text(a[i],
          maxLines: 2,
          style: TextStyle(color: Colors.white),);
        l.add(text);
      }


    }

    return l;
  }
  List<Widget> petiteDescription(List<String> a){

    double width = MediaQuery .of(context).size.width;
    List<Widget> l = [];

    for(int i = 0;i<2;i++){
      if(i+1 == 2)
      {
        Widget text =   Row(
          children: [
            Container(
              child: Text(a[i].split('</p>')[0],
                maxLines: 1,
                style: TextStyle(color: Colors.white),),
              width: width-150,
            ),
            Container( width:70,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      lirePlus = true;
                    });
                  },
                  child: Text('...lire plus',style: TextStyle(color: Colors.orange),),
                ))
            ,
          ],
        );
        Text(a[i],
          maxLines: 2,
          style: TextStyle(color: Colors.white),);
        l.add(text);

      }
      else{
        Widget text = Text(a[i],
          maxLines: 2,
          style: TextStyle(color: Colors.white),);
        l.add(text);
      }


    }

    return l;
  }
  List<Widget> chowVarriantes(List<Variants> varriantes){
    for(int i = 0; i <varriantes.length;i++){
      viewVariant.add(false);
      optionsParameters.add(OptionParameter(varriantes[i].maxChoices, []));
      varriantes[i].required ? requiredVarriant.add(false):requiredVarriant.add(true);
      for(int y = 0; y<varriantes[i].options.length;y++){
        optionsParameters[i].optionValue.add(false);
      }
    }
    List<Widget> l = [];
    int indexFirst = 2;
    for(int i = 0; i <varriantes.length;i++){
      if(indexFirst != i   ){

        Widget a = SafeArea(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffbbbbbb)),
                            borderRadius: BorderRadius.all(Radius.circular(27))),
                        child: Column(
                          children: [
                            Container(
                              // height: 45,
                                width: double.infinity,
                                padding: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffbbbbbb),
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                                constraints: BoxConstraints(
                                  minHeight: 45,
                                  minWidth: double.infinity,
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              varriantes[i].name ,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            varriantes[i].required? Text(
                                              "*",
                                              style: TextStyle(color: Colors.red),
                                            ):
                                            Text(
                                              "",
                                              style: TextStyle(color: Colors.white38),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            viewVariant[i] = !viewVariant[i];
                                            print(viewVariant[i]);
                                          });
                                        },
                                        child: Icon(viewVariant[i]
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,color: Colors.white,))
                                  ],
                                )),
                            ExpandedSection(
                              expand: viewVariant[i],

                              height: 100,
                              child: MyScrollbar(
                                builder: (context, scrollController2) =>
                                    ListView.builder(
                                        padding: EdgeInsets.all(0),
                                        controller: scrollController2,
                                        shrinkWrap: true,
                                        itemCount: varriantes[i].options.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: (){
                                            },
                                            child: ListTile(
                                                leading:  Checkbox(
                                                    checkColor:Colors.black,
                                                    fillColor:MaterialStateProperty.resolveWith(getColor),
                                                    value: optionsParameters[i].optionValue[index],
                                                    onChanged: null) ,
                                                title:  Text(varriantes[i].options[index].name,style: TextStyle(color: Colors.white),),
                                                trailing:
                                                varriantes[i].options[index].additionnalFee >0? Text("+ "+varriantes[i].options[index].additionnalFee.toString()+" Fcfa",
                                                  style: TextStyle(color: Color.fromRGBO(202, 115, 64, 1),),):
                                                Container(width: 0,height: 0,)

                                            ),
                                          );
                                        }),
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
        );
        l.add(a);
      }
    }
    return l;
  }
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

}
