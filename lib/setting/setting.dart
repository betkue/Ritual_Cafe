import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template1_genuka_mobile/clients/auth/decoration.dart';
import 'package:template1_genuka_mobile/collections/colors.dart';
import 'package:template1_genuka_mobile/loadding.dart';
import 'package:template1_genuka_mobile/models/json/jsonlistecommande.dart';
import 'package:template1_genuka_mobile/services/services.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
 final  Services serv;
   Settings(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value:this.serv,
      child:SettingsFull(serv) ,
    );
  }
}
class SettingsFull extends StatefulWidget {
  final Services serv;
   SettingsFull(this.serv);

  @override
  _SettingsFullState createState() => _SettingsFullState();
}

class _SettingsFullState extends State<SettingsFull> {
  
  final rechercheController = TextEditingController();
  @override
  void dispose() {
    rechercheController.dispose();
    super.dispose();
  }
  @override
    Widget build(BuildContext context) {
     return  Consumer<Services>(
        builder: (context,serv,_)=>
           FutureBuilder<JsonListeCommandes>(
                        future: serv.getDetailClient(),
                        builder: (BuildContext context,
                            AsyncSnapshot<JsonListeCommandes> snapshot){
                              if (snapshot.hasData) {

                                if (snapshot.data.data != null) {
                                  return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Center(
                                      child: Container(
                                        child: ListView(
                                          children: commandes(snapshot.data,serv),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Container(
                                      child: Text("Aucune commande dans l'historique",style: TextStyle(color: Colors.red),),
                                    ),
                                  );
                                }
                              }
                              else{
                                  return Loadding();
                              }


                            }));

                    

  }
  List<Widget> commandes(JsonListeCommandes listeCommandes,Services servs){
    List <Widget>l=[];
    
   double width = MediaQuery .of(context).size.width;
    for (var i = 0; i < listeCommandes.data.length; i++) {
      if (listeCommandes.data[i].entrepriseId.toString() == servs.companyId) {
        Widget card = GestureDetector(
          onTap: (){
            servs.idHistory = i;
            
             Navigator.pushNamed(context,
               '/commandehistory',
                 arguments: servs
             );
          },
          child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      
                     // height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        gradient: gard),
                      child: Padding(padding: EdgeInsets.all(10),
                            child: Row(
                            children: [
                              Hero(
                            tag: "I00"+i.toString(),

                            child:Container(
                              
                              height:100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(servs.registerUser.profilePicture),
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
                            child: Text(listeCommandes.data[i].subtotal.toString(),style: TextStyle(color: principalTextColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                            
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
                                      child: Text(listeCommandes.data[i].subtotal.toString(),style: TextStyle(color: containerTagProduitPanierColor,fontWeight: FontWeight.normal,fontSize: 14),),
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
                          children: [         Row(
                              children: [
                                  Text("Commande : ",style: TextStyle(color: principalTextColor60,fontStyle: FontStyle.italic),),
                                  Text(listeCommandes.data[i].id.toString() ,style: TextStyle(color: primaryColor,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 15),),
                           
                              ],
                            ),
                            Row(
                              children: [
                                  Text("Total : ",style: TextStyle(color: primaryColor,fontStyle: FontStyle.italic),),
                                  Text(listeCommandes.data[i].montant.toString(),style: TextStyle(color: principalTextColor60,fontStyle: FontStyle.italic),),
                            
                              ],
                            ),
                            Row(
                              children: [
                                Text("nom : ",style: TextStyle(color: primaryColor ,fontStyle: FontStyle.italic),),
                                Text(listeCommandes.data[i].client.firstname.toString(),style: TextStyle(color: principalTextColor60 ,fontStyle: FontStyle.italic),),
                            
                                
                              ],
                            ),Row(
                              children: [
                                 Text("date : ",style: TextStyle(color: primaryColor,fontStyle: FontStyle.italic),),
                                 Text(listeCommandes.data[i].createdAt.toString(),style: TextStyle(color: principalTextColor60,fontStyle: FontStyle.italic),),
                           
                              ],
                            ),
                            
                          ],
                        ),
                        ),
                      )
                            ],
                        ),
                     )
                    )),

      
        );
        l.add(card);
        l.add(SizedBox(height: 10,));
      }
    }


    return l;

  }

}
