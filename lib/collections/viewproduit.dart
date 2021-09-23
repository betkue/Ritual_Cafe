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
  void snack(String a,double width) {
    SnackBar snackbar =  SnackBar(
      content:
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: width,
            child: Text(a, textAlign: TextAlign.start,
              style: new TextStyle(color: Colors.white),
              maxLines: 3,
            ),
          ),
          Container(
            width: 20,
            child: Icon(Icons.cancel,color: Colors.red,size: 20,),
          )

        ],
      ),
      backgroundColor: Colors.black54,);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  int priceadd = 0;
  int price = 0;
  bool lirePlus = false;
  List<bool> viewVariant = [];
  List<bool> requiredVarriant = [];
  List<OptionParameter> optionsParameters = [];
  @override
  Widget build(BuildContext context) {
   var produit = widget.serv.collections.data[widget.serv.indexCollection].produits[widget.serv.indexProduit] ;
    //price = produit.price;

   double width = MediaQuery .of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text(produit.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),),
                                    SizedBox(height: 8,),
                                    Text(produit.tags[0].name,style: TextStyle(color: Colors.white60,fontWeight: FontWeight.normal,fontSize: 14),),
                                    SizedBox(height: 8,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Icon(Icons.star,color:  Color.fromRGBO(202, 115, 64, 1),size: 22,),
                                        SizedBox(width: 8,),
                                        Text(createNote(produit.avis),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                                        SizedBox(width: 8,),
                                        Text("("+produit.avis.length.toString()+")",style: TextStyle(color: Colors.white60,fontWeight: FontWeight.normal,fontSize: 12),),
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
                    Padding(padding: EdgeInsets.only(top: 10,bottom: 10),
                      child: Column(
                        children: chowVarriantes(produit.variants,width-100,produit.price),
                      ),
                    ),

                  ],
                ),
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
                        Text((price !=0?price+priceadd:produit.price+priceadd).toString(),
                          style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        Text(" F.CFA",
                          style: TextStyle(color:  Color.fromRGBO(202, 115, 64, 1),fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: width-140,
                  decoration: BoxDecoration(
                    color:  Color.fromRGBO(202, 115, 64, 1),
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
            ),
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
                    child: Text('... moins',style: TextStyle(color:   Color.fromRGBO(202, 115, 64, 1)),),
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
  List<Widget> chowVarriantes(List<Variants> varriantes,double width,int prixInitial){

    int indexFirst  ;
    bool priceChange = false;
    List<Widget> l = [];
    for(int i = 0; i <varriantes.length;i++)
    {
      viewVariant.add(false);
      optionsParameters.add(OptionParameter(varriantes[i].maxChoices, [],0));
      varriantes[i].required ? requiredVarriant.add(false):requiredVarriant.add(true);
      for(int y = 0; y<varriantes[i].options.length;y++){
        optionsParameters[i].optionValue.add(false);
        if(varriantes[i].options[y].price >0)priceChange = true;
        if(priceChange) indexFirst = y;
      }

    }
    if(indexFirst!= null)
      {
        Widget first = SafeArea(
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
                                              varriantes[indexFirst].name ,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            varriantes[indexFirst].required? Text(
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
                                            viewVariant[indexFirst] = !viewVariant[indexFirst];
                                            print(viewVariant[indexFirst]);
                                          });
                                        },
                                        child: Icon(viewVariant[indexFirst]
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,color: Colors.white,))
                                  ],
                                )),
                            ExpandedSection(
                              expand: viewVariant[indexFirst],

                              height: 100,
                              child: MyScrollbar(
                                builder: (context, scrollController2) =>
                                    ListView.builder(
                                        padding: EdgeInsets.all(0),
                                        controller: scrollController2,
                                        shrinkWrap: true,
                                        itemCount: varriantes[indexFirst].options.length,
                                        itemBuilder: (context, index) {
                                          return varriantes[indexFirst].options[index].price>0?
                                          GestureDetector(
                                            onTap: (){},
                                            child: ListTile(
                                               leading: Checkbox(
                                                    checkColor:Colors.black,
                                                    fillColor:MaterialStateProperty.resolveWith(getColor),
                                                    value: optionsParameters[indexFirst].optionValue[index],
                                                    onChanged: (bool value){
                                                      if(optionsParameters[indexFirst].actualChoice<optionsParameters[indexFirst].maxChoice)
                                                      {
                                                        print(varriantes[indexFirst].options[index].price);

                                                        setState(() {
                                                          optionsParameters[indexFirst].optionValue[index]? optionsParameters[indexFirst].actualChoice--
                                                              :
                                                          optionsParameters[indexFirst].actualChoice++;
                                                          optionsParameters[indexFirst].optionValue[index] = value;
                                                        });

                                                        print(price);
                                                        print(priceadd);
                                                      }
                                                      else{
                                                        setState(() {
                                                          optionsParameters[indexFirst].optionValue[index]?optionsParameters[indexFirst].actualChoice--
                                                              :
                                                          optionsParameters[indexFirst].actualChoice=optionsParameters[indexFirst].actualChoice;
                                                          optionsParameters[indexFirst].optionValue[index]?optionsParameters[indexFirst].optionValue[index]=value
                                                              :
                                                          snack("Le nombre de choix maximum de "+ varriantes[indexFirst].name+ " est de : "+varriantes[indexFirst].maxChoices.toString(),
                                                              width
                                                          );
                                                        });
                                                      }
                                                      setState(() {

                                                        optionsParameters[indexFirst].optionValue[index]?
                                                        price =prixInitial
                                                            :
                                                        price =varriantes[indexFirst].options[index].price;
                                                      });

                                                      print(optionsParameters[indexFirst].actualChoice.toString()+"??????"+optionsParameters[indexFirst].maxChoice.toString());
                                                    }
                                                ),
                                                title:  Text(varriantes[indexFirst].options[index].name,style: TextStyle(color: Colors.white),),
                                                trailing:
                                                varriantes[indexFirst].options[index].price ==0? Text(varriantes[indexFirst].options[index].price.toString()+" Fcfa",
                                                  style: TextStyle(color: Color.fromRGBO(202, 115, 64, 1),),):
                                                Container(width: 0,height: 0,)

                                            ),
                                          )
                                          :
                                          Container(width: 0,height: 0,);
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
        l.add(first);
      }
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
                                                    onChanged: (bool value){
                                                      if(optionsParameters[i].actualChoice<optionsParameters[i].maxChoice)
                                                      {

                                                        setState(() {
                                                          optionsParameters[i].optionValue[index]?priceadd =priceadd-varriantes[i].options[index].additionnalFee
                                                              :
                                                          priceadd =priceadd+varriantes[i].options[index].additionnalFee;
                                                          optionsParameters[i].optionValue[index]? optionsParameters[i].actualChoice--
                                                              :
                                                          optionsParameters[i].actualChoice++;
                                                          optionsParameters[i].optionValue[index] = value;
                                                        });
                                                      }
                                                      else{
                                                          setState(() {
                                                            optionsParameters[i].optionValue[index]?priceadd =priceadd-varriantes[i].options[index].additionnalFee
                                                                :
                                                            priceadd =priceadd+varriantes[i].options[index].additionnalFee;
                                                            optionsParameters[i].optionValue[index]?optionsParameters[i].actualChoice--
                                                                :
                                                            optionsParameters[i].actualChoice=optionsParameters[i].actualChoice;
                                                            optionsParameters[i].optionValue[index]?optionsParameters[i].optionValue[index]=value
                                                                :
                                                            snack("Le nombre de choix maximum de "+ varriantes[i].name+ " est de : "+varriantes[i].maxChoices.toString(),
                                                              width
                                                            );
                                                          });
                                                      }

                                                      print(optionsParameters[i].actualChoice.toString()+"??????"+optionsParameters[i].maxChoice.toString());
                                                    }
                                                ) ,
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
      return Color.fromRGBO(202, 115, 64, 1);
    }
    return Colors.white;
  }

  String createNote(List<Avis >avis){
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
