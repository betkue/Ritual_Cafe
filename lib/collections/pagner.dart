import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:ritual_cafe/collections/colors.dart';
import 'package:ritual_cafe/models/commande.dart';
import 'package:ritual_cafe/services/services.dart';
import 'package:ritual_cafe/clients/auth/decoration.dart';
class Pagner extends StatelessWidget {
  Services serv;
 Pagner(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value:this.serv,
    child:PagnerFull(serv) ,
    );
  }
}
class PagnerFull extends StatefulWidget {
  Services serv;
   PagnerFull(this.serv);

  @override
  _PagnerFullState createState() => _PagnerFullState();
}

class _PagnerFullState extends State<PagnerFull> {
    Future<void> _dialogDelete(Services servs,int i) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Voulez vous supprimer cette commande du Panier?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Supprimer'),
              onPressed: () {
                Navigator.pop(context);
                servs.deleteCommande(i);

              },
            ),
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void snack(String a,double width) {
    SnackBar snackbar =  SnackBar(
      content:
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: width,
            child: Text(a, textAlign: TextAlign.start,
              style: new TextStyle(color: principalTextColor),
              maxLines: 3,
            ),
          ),
          Container(
            width: 20,
            child: Icon(Icons.cancel,color: errorTextColor,size: 20,),
          )

        ],
      ),
      backgroundColor: Colors.black54,);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  } @override
  Widget build(BuildContext context) {
   var produit = widget.serv.collections.data[widget.serv.indexCollection].produits[widget.serv.indexProduit] ;
    //price = produit.price;

   double width = MediaQuery .of(context).size.width;
    return  Consumer<Services>(
        builder: (contextConsumer,servs,_)=> 
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
                    backgroundColor: Colors.black,
                    centerTitle: true,
                    leading: GestureDetector(
                      onTap: (){
                                              
                          Navigator.of(context).pushNamedAndRemoveUntil('/home',
                          (Route<dynamic> route) => false,arguments: widget.serv);
                      },
                      child: Icon(Icons.arrow_back,color: principalTextColor,),
                    ),
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8.0), child:
                            Text( "Panier",
                          style: TextStyle(
                              color: primaryColor,
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
          body: Padding(
            padding: const EdgeInsets.all(15),
            child:  Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: createList(servs).isEmpty?
                    [
                      SizedBox(
                        height:  MediaQuery .of(context).size.height/4,
                      ),
                      Text("Votre Panier est actuellement vide",
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontStyle: FontStyle.italic
                      ),)
                    ]:
                    createList(servs)
                  ,
                ),
              ),
            ),
            Column(
             children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Prix",
                              style: TextStyle(color: secondaryTextColor),),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(servs.total.toString(),
                                  style: TextStyle(color: principalTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
                                Text(" F.CFA",
                                  style: TextStyle(color:  primaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                        GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            color:  primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text("Commander",textAlign: TextAlign.center,
                              style: TextStyle(color: principalTextColor,fontSize: 20),
                            ),
                          ),
                        ),
                        )
                  ],),
          ],
        ),
      ),
   ),
    ));
  }
  List<Widget> createList(Services servs){
    
   double width = MediaQuery .of(context).size.width;
    List<Widget> l = [];
    for (var i = 0; i < servs.commande.length; i++) {
      Commande com = servs.commande[i];
      Widget a =  GestureDetector(
                      onTap: (){
                        
                            servs.indexCommande =i;
                            
                             Navigator.of(context).pushNamed('/update',arguments: widget.serv);
                      },
                      onLongPress: (){
                        _dialogDelete(servs, i);
                      },
                   child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        gradient: gard),
                      child: Padding(padding: EdgeInsets.all(10),
                            child: Row(
                            children: [
                              Hero(
                            tag: "I00"+i.toString()+ com.id.toString(),

                            child:Container(
                              
                              height:100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(com.image),
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
                              color: containerPrixProduitPanierColor,
                              borderRadius:BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                     ),

                            ),
                          child: Padding(padding: EdgeInsets.only(top: 2,bottom: 2,left: 15,right: 15),
                            child: Text(com.prixTotal.toString(),style: TextStyle(color: principalTextColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                            
                          ),
                          )
                      ),
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0),),
                                    ),
                                    //    ),
                                    child: Padding(padding: EdgeInsets.all(10),
                                      child: Text(com.tag,style: TextStyle(color: containerTagProduitPanierColor,fontWeight: FontWeight.normal,fontSize: 14),),
                                         ),
                                  ),
                                ),
                             
                             ],
                            ),
                            )

                      ),
                      Container(
                        width: width-120,
                        color:  secondaryColornull,
                        child:Padding(padding: EdgeInsets.all(5),
                          child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(com.nom ,style: TextStyle(color: principalTextColor,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 15),),
                            Text("Nombre : "+com.nombre.toString(),style: TextStyle(color: principalTextColor,fontStyle: FontStyle.italic),),
                            Text(com.tag.toString(),style: TextStyle(color:principalTextColor,fontSize: 10,fontStyle: FontStyle.italic),),
                            Text("Voir Plus",style: TextStyle(color: primaryColor,fontStyle: FontStyle.italic),),
                          ],
                        ),
                        ),
                      )
                            ],
                        ),
                     )
                    )),

      ) ;
      l.add(a);
      l.add(SizedBox(height:10));
    }
    return l;
  }

  Widget createTitle(Commande com){
    return ListTile(
      title: Text(com.nom),
    );
  }
  String createListTag(Commande com){
    return "";
  }

}
