import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ritual_cafe/clients/auth/decoration.dart';
import 'package:ritual_cafe/collections/colors.dart';
import 'package:ritual_cafe/models/json/jsonlistecommande.dart';
import 'package:ritual_cafe/services/services.dart';
import 'package:provider/provider.dart';

class CommandeHistory extends StatelessWidget {
 final  Services serv;
   CommandeHistory(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value:this.serv,
      child:CommandeHistoryFull(serv) ,
    );
  }
}
class CommandeHistoryFull extends StatefulWidget {
  final Services serv;
   CommandeHistoryFull(this.serv);

  @override
  _CommandeHistoryFullState createState() => _CommandeHistoryFullState();
}

class _CommandeHistoryFullState extends State<CommandeHistoryFull> {
  
  final rechercheController = TextEditingController();
  @override
  void dispose() {
    rechercheController.dispose();
    super.dispose();
  }
  @override
    Widget build(BuildContext context) {
       Data data = widget.serv.listeCommandes.data[widget.serv.idHistory];
    
    return  Consumer<Services>(
        builder: (context,serv,_)=>
           Scaffold(
             backgroundColor: Colors.black,
             appBar: AppBar(
                    backgroundColor: Colors.black,
                    centerTitle: true,
               title: Row(
                 children: [
                    Text("Commande : ",style: TextStyle(color: principalTextColor60,fontStyle: FontStyle.italic),),
                    Text(data.id.toString() ,style: TextStyle(color: primaryColor,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 15),),
                           
                 ],
               ),
             ),
             body:  Padding(
                     padding: const EdgeInsets.all(15),
                        child: Center(
                             child: Container(
                                child: ListView(
                                   children: create(data),
                                 ),
                            )
                        ),
                    )
             ),
           );
                    

  }
  List<Widget>create(Data data){
    Widget addresse = Column(
      children: [
        
         Row(
              children: [
                   Text("Total : ",style: TextStyle(color: primaryColor,fontStyle: FontStyle.italic),),
                   Text(data.montant.toString(),style: TextStyle(color: principalTextColor60,fontStyle: FontStyle.italic),),
                            
                ],
            ),
            Row(
               children: [
                  Text("prenom : ",style: TextStyle(color: primaryColor ,fontStyle: FontStyle.italic),),
                  Text(data.client.firstname.toString(),style: TextStyle(color: principalTextColor60 ,fontStyle: FontStyle.italic),),
                            
                                
                ],
            ),
         Row(
               children: [
                  Text("nom : ",style: TextStyle(color: primaryColor ,fontStyle: FontStyle.italic),),
                  Text(data.client.surname.toString(),style: TextStyle(color: principalTextColor60 ,fontStyle: FontStyle.italic),),
                            
                                
                ],
            ),Row(
                 children: [
                     Text("date : ",style: TextStyle(color: primaryColor,fontStyle: FontStyle.italic),),
                    Text(data.createdAt.toString(),style: TextStyle(color: principalTextColor60,fontStyle: FontStyle.italic),),
                           
                ],
             ),
                            

      ],
    );
    
   double width = MediaQuery .of(context).size.width;
    List<Widget>  l = [];
    l.add(addresse);
    l.add(SizedBox(height: 15,));
    for (var i = 0; i < data.produits.length; i++) {
      Widget a = SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        gradient: gard),
                      child: Padding(padding: EdgeInsets.all(10),
                            child: Row(
                            children: [
                        Container(
                        width: width-120,
                        color:  secondaryColornull,
                        child:Padding(padding: EdgeInsets.all(5),
                          child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.produits[i].name ,style: TextStyle(color: principalTextColor,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 15),),
                            Text(data.produits[i].price.toInt().toString() + " FCFA",style: TextStyle(color: primaryColor,fontStyle: FontStyle.italic),),
                             Text("Nombre : "+data.produits[i].pivot.quantite.toString(),style: TextStyle(color: principalTextColor60,fontStyle: FontStyle.italic),),
                            Text(data.produits[i].pivot.properties.toString(),style: TextStyle(color:principalTextColor60,fontSize: 10,fontStyle: FontStyle.italic),),
                             ],
                        ),
                        ),
                      )
                            ],
                        ),
                     )
                    ));

      

     l.add(a); 
     l.add(SizedBox(height: 15,));
    }
    return l;
  }


}
