import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:ritual_cafe/collections/colors.dart';
import 'package:ritual_cafe/loadding.dart';
import 'package:ritual_cafe/models/json/company.dart';
import 'package:ritual_cafe/models/json/responseUpdateUser.dart';
import 'package:ritual_cafe/models/response.dart';
import 'package:ritual_cafe/services/services.dart';
import 'package:ritual_cafe/clients/auth/decoration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
class Commander extends StatelessWidget {
  
  Services serv;
 Commander(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value:this.serv,
    child:CommanderFull(serv) ,
    );
  }
}
class CommanderFull extends StatefulWidget {
  Services serv;
   CommanderFull(this.serv);

  @override
  _CommanderFullState createState() => _CommanderFullState();
}

class _CommanderFullState extends State<CommanderFull> {
  
  RegExp regExp =    new RegExp(r"^[a-zA-Z0-9._\-*ù^&éè#!§]+@[a-z0-9._-]+\.[a-z]{2,6}");//verification du mail
  RegExp re = new RegExp(r"^[a-zA-Z]+\s[a-zA-Z]+$");//regex nom prenom
  bool send =false;
  bool suiv =false;
  String initialCountry = 'CM';
  String error = "";//en cas d'erreur
  PhoneNumber number = PhoneNumber(isoCode: 'CM');
  PhoneNumber number2 = PhoneNumber(isoCode: 'CM');
  final formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();//mail
  final phoneController = TextEditingController();//mail
  final nomController = TextEditingController();//prenom nom
  final prenomController = TextEditingController();//prenom nom
  final adresseController = TextEditingController();//prenom nom
  final noteController = TextEditingController();//prenom nom
  final serviceController = TextEditingController();//orange ou mtn
  final buyphoneController = TextEditingController();//orange ou mtn
    @override
  void dispose() {
    mailController.dispose();
    prenomController.dispose();
    phoneController.dispose();
    nomController.dispose();
    adresseController.dispose();
    noteController.dispose();
    serviceController.dispose();
    buyphoneController .dispose();
    super.dispose();
  }
  bool noView = true;//afficher mot de passe
  
  void snack(String a,double width) {
    SnackBar snackbar =  SnackBar(
      content:
      
          Container(
            width: width,
            child: Text(a, textAlign: TextAlign.start,
              style: new TextStyle(color: principalTextColor),
              maxLines: 6,
            ),
          ) ,
      backgroundColor: Colors.black54,);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  } @override
  Widget build(BuildContext context) {
    //price = produit.price;
   double width = MediaQuery .of(context).size.width;
    return send? Loadding() : Consumer<Services>(
        builder: (contextConsumer,servs,_)=> 
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
                    backgroundColor: Colors.black,
                    centerTitle: true,
                   /* leading: GestureDetector(
                      onTap: (){
                                              
                          Navigator.of(context).pushNamedAndRemoveUntil('/home',
                          (Route<dynamic> route) => false,arguments: widget.serv);
                      },
                      child: Icon(Icons.arrow_back,color: principalTextColor,),
                    ),*/
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8.0), child:
                            Text( "Commander",
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 36
                          ),)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: servs.registerUser.profilePicture !='null'?
                           CachedNetworkImage(
                               imageUrl: servs.registerUser.profilePicture,//
                               placeholder: (context, url) =>
                                   Center(child: CircularProgressIndicator()),
                               errorWidget: (context, url, error) => Icon(Icons.error),
                               height: 40,
                               width: 40,
                               fit: BoxFit.cover,

                             )
                            :
                           Icon(Icons.person,color: principalTextColor,),
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
                child:  Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                decoration: BoxDecoration(
                  gradient: gard,
                  borderRadius: BorderRadius.circular(14),
                ),
              child: Padding(
                  padding: const EdgeInsets.all(10), child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children :suiv? plus(servs,servs.registerUser):info(servs,servs.registerUser)
                  ))),
            ),
          ),
              ),
            ),
           !suiv? GestureDetector(
             onTap: (){
               if(formKey.currentState.validate())
               {
                      formKey.currentState.save();
                 setState(() {
                   suiv = true;
                 });

               }

             },
             child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            color:  primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text("Suivant",textAlign: TextAlign.center,
                              style: TextStyle(color: principalTextColor,fontSize: 20),
                            ),
                          ),
                        ),
           )  : Column(
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
                          onTap: ()async{
                            if (formKey.currentState.validate()) {
                              
                               formKey.currentState.save();
                               if (serviceController.text.toUpperCase() == "O" ) {
                                  setState(() {
                              serviceController.text = "ORANGE";
                            });
                               }
                               if (serviceController.text.toUpperCase() == "M" ) {
                                  setState(() {
                              serviceController.text = "MTN";
                            });
                               }
                                  setState(() {
                              send = true;
                            }); 
                            
                            String result = await servs.commander(nomController.text,
                             prenomController.text, mailController.text, phoneController.text, adresseController.text, 
                             noteController.text);
                            if (result.isNotEmpty) {
                              
                              snack("Commandé", 100);
                              
                                
                                switch (servs.paiementMode) {
                                case "Cash": Navigator.of(context).pushNamedAndRemoveUntil('/home',
                                  (Route<dynamic> route) => false,arguments: widget.serv);
                                  setState(() {
                                  send = false;
                                });
                                  break;
                                case "Paypal":  
                                
                                    String url =  servs.company.datas.payments.paypal.link;
                                if (await canLaunch(url)) {
                                    await launch(
                                      url,
                                      forceSafariVC: true,
                                      forceWebView: true,
                                      enableJavaScript: true,
                                      enableDomStorage: true,
                                      headers: <String, String>{'my_header_key': 'my_header_value'},
                                    );
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                  setState(() {
                                  send = false;
                                });
                                 Navigator.of(context).pushNamedAndRemoveUntil('/home',
                                  (Route<dynamic> route) => false,arguments: widget.serv);
                                  break;
                                case "Mobile Money":
                                ResponseSend result = await servs.buyMobile(buyphoneController.text, serviceController.text);
                                    if (result.etat) {
                                      
                                     snack(result.message, 100);
                                     
                                 Navigator.of(context).pushNamedAndRemoveUntil('/home',
                                  (Route<dynamic> route) => false,arguments: widget.serv);
                                      
                                    } else {
                                      
                                    snack(result.message, 100);
                                    
                                 Navigator.of(context).pushNamedAndRemoveUntil('/home',
                                  (Route<dynamic> route) => false,arguments: widget.serv);
                                    }
                                    setState(() {
                                  send = false;
                                });

                                  break;
                                case "Credit Card":
                                
                                    setState(() {
                                  send = false;
                                });
                                 Navigator.of(context).pushNamedAndRemoveUntil('/home',
                                  (Route<dynamic> route) => false,arguments: widget.serv);
                                  break;
                                default: Navigator.of(context).pushNamedAndRemoveUntil('/home',
                                  (Route<dynamic> route) => false,arguments: widget.serv);
                              }
                              
                            } else {
                              snack("Echec Connexion",100);
                              Navigator.of(context).pushNamedAndRemoveUntil('/home',
                                  (Route<dynamic> route) => false,arguments: widget.serv);
                              
                            setState(() {
                              send = false;
                            });
                            }
                            
                            
                              
                            }


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
 
  
  List<Widget> info(Services servs,ResponseUpdateUser user){
    List<Widget> l =[
                        
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text("Nom",textAlign: TextAlign.start,
                                        style: TextStyle(color: principalTextColor,fontSize: 15,
                                        ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
                                      child:
                                      TextFormField(
                                        cursorColor: principalTextColor,
                                        keyboardType: TextInputType.text,
                                        controller: nomController,
                                        style:TextStyle(
                                            color: principalTextColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                        decoration:textInputDecoration.copyWith(hintText: 'Nom'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            setState(() {
                                              nomController.text = user.lastName;
                                            });
                                           }
                                          return null;
                                        },
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text("Prénom ",textAlign: TextAlign.start,
                                        style: TextStyle(color: principalTextColor,fontSize: 15,
                                        ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
                                      child:
                                      TextFormField(
                                        cursorColor: principalTextColor,
                                        keyboardType: TextInputType.text,
                                        controller: prenomController,
                                        style:TextStyle(
                                            color: principalTextColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                        decoration:textInputDecoration.copyWith(hintText: 'Prenom'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            setState(() {
                                              prenomController.text = user.firstName;
                                            });
                                           }
                                          return null;
                                        },
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text("Email",textAlign: TextAlign.start,
                                        style: TextStyle(color: principalTextColor,fontSize: 15,
                                        ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
                                      child: TextFormField(
                                        cursorColor: principalTextColor,
                                        keyboardType: TextInputType.emailAddress,
                                        controller: mailController,
                                        style:TextStyle(
                                            color: principalTextColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                        decoration:textInputDecoration.copyWith(hintText: 'Adresse mail'),
                                        validator: (value) {
                                          if (!regExp.hasMatch(value.toString())) {
                                            setState(() {
                                              mailController.text = user.email;
                                            });
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text("Numéro de tel",textAlign: TextAlign.start,
                                        style: TextStyle(color: principalTextColor,fontSize: 15,
                                        ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
                                      child:  InternationalPhoneNumberInput(
                                        onInputChanged: (PhoneNumber number) {
                                        },
                                        onInputValidated: (bool value) {
                                          
                                        },
                                        selectorConfig: SelectorConfig(
                                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                        ),
                                        ignoreBlank: false,
                                        autoValidateMode: AutovalidateMode.disabled,
                                        selectorTextStyle: TextStyle(color: principalTextColor,fontWeight: FontWeight.bold),
                                        initialValue: number,
                                        cursorColor: principalTextColor,
                                        textFieldController: phoneController,
                                        textStyle: TextStyle(color: principalTextColor,fontWeight: FontWeight.bold),
                                        formatInput: true,
                                        keyboardType:TextInputType.numberWithOptions(signed: true, decimal: true),
                                        inputBorder: OutlineInputBorder(

                                            borderSide: BorderSide(color: secondaryTextColor,width: 1),
                                            borderRadius:BorderRadius.all(Radius.circular(10.0))),
                                        inputDecoration: textInputDecoration.copyWith(hintText: 'Phone',),
                                        onSaved: (PhoneNumber number) {
                                          phoneController.text = number.toString();
                                        },
                                      ),
                                    ),
                                  
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(error,textAlign: TextAlign.center,
                                        style: TextStyle(color: errorTextColor,
                                        ),),
                                    ),

                               ];
    return l;
  }

  List<Widget> plus(Services servs,ResponseUpdateUser user){
    List<Widget> l =[
                              
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text("Adresse",textAlign: TextAlign.start,
                                        style: TextStyle(color: principalTextColor,fontSize: 15,
                                        ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
                                      child:
                                      TextFormField(
                                        cursorColor: principalTextColor,
                                        keyboardType: TextInputType.text,
                                        controller: adresseController,
                                        minLines: 3,
                                        maxLines: 10,
                                        style:TextStyle(
                                            color: principalTextColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                        decoration:textInputDecoration.copyWith(hintText: 'Adresse'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Entrez une adresse valide";
                                            /*setState(() {
                                              nomController.text = user.lastName;
                                            }); */
                                           }
                                          return null;
                                        },
                                      ),
                                    ),
                        
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text("Note pour la livraison",textAlign: TextAlign.start,
                                        style: TextStyle(color: principalTextColor,fontSize: 15,
                                        ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
                                      child:
                                      TextFormField(
                                        cursorColor: principalTextColor,
                                        keyboardType: TextInputType.text,
                                        controller: noteController,
                                        minLines: 5,
                                        maxLines: 10,
                                        style:TextStyle(
                                            color: principalTextColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                        decoration:textInputDecoration.copyWith(hintText: 'Note pour la livraison'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            setState(() {
                                              noteController.text = "null";
                                            });
                                           }
                                          return null;
                                        },
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(left: 16,bottom: 10),
                                          child: Text("Payement : ",textAlign: TextAlign.start,
                                            style: TextStyle(color: principalTextColor,fontSize: 15,
                                            ),),
                                        ), 
                                      Padding(
                                          padding: const EdgeInsets.only(left: 16,bottom: 10),
                                          child: Text(servs.paiementMode,textAlign: TextAlign.start,
                                            style: TextStyle(color: primaryColor,fontSize: 15,fontStyle: FontStyle.italic
                                            ),),
                                        ),
                                    ],
                                  ), 
                                  Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child:  Row(
                                                  children: createmode(servs),
                                                )
                                                ),
                                        ),
                                        
      //mobile money
      
                              
                                  servs.paiementMode == "Mobile Money"? 
                                  Padding(
                                      padding: const EdgeInsets.only(left: 16,top: 16),
                                      child: Text("Service :",textAlign: TextAlign.start,
                                        style: TextStyle(color: principalTextColor,fontSize: 15,
                                        ),),
                                    ): 
                                    Container(width: 0,height: 0,),
                                  servs.paiementMode == "Mobile Money"?  
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
                                      child:
                                      TextFormField(
                                        cursorColor: principalTextColor,
                                        keyboardType: TextInputType.text,
                                        controller: serviceController,
                                        style:TextStyle(
                                            color: principalTextColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                        decoration:textInputDecoration.copyWith(hintText: 'O/M'),
                                        validator: (value) {
                                          if (value.toUpperCase() != "O"  && value.toUpperCase() != "M" ) {
                                            return "Entrez un service valide";
                                            /*setState(() {
                                              nomController.text = user.lastName;
                                            }); */
                                           }
                                          return null;
                                        },
                                      ),
                                    ):
                                    Container(width: 0,height: 0,),
                                    servs.paiementMode == " Mobile Money"? 
                                  Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text("Phone :",textAlign: TextAlign.start,
                                        style: TextStyle(color: principalTextColor,fontSize: 15,
                                        ),),
                                    ): 
                                    Container(width: 0,height: 0,),
                                  servs.paiementMode == "Mobile Money"?  
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
                                      child:  InternationalPhoneNumberInput(
                                        onInputChanged: (PhoneNumber number) {
                                        },
                                        onInputValidated: (bool value) {
                                        },
                                        selectorConfig: SelectorConfig(
                                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                        ),
                                        ignoreBlank: true,
                                        countrySelectorScrollControlled: false,
                                        autoValidateMode: AutovalidateMode.disabled,
                                        selectorTextStyle: TextStyle(color: principalTextColor,fontWeight: FontWeight.bold),
                                        initialValue: number2,
                                        cursorColor: principalTextColor,
                                        textFieldController: buyphoneController,
                                        textStyle: TextStyle(color: principalTextColor,fontWeight: FontWeight.bold),
                                        formatInput: true,
                                        countries: [initialCountry],
                                        keyboardType:TextInputType.numberWithOptions(signed: true, decimal: true),
                                        inputBorder: OutlineInputBorder(

                                            borderSide: BorderSide(color: secondaryTextColor,width: 1),
                                            borderRadius:BorderRadius.all(Radius.circular(10.0))),
                                        inputDecoration: textInputDecoration.copyWith(hintText: '6*******5',),
                                        onSaved: (PhoneNumber number) {
                                         buyphoneController.text = number.toString().split("+")[1] ;
                                        },
                                      ),
                                    )
                                  
                                   
                                :  Container(width: 0,height: 0,),

                                    

    ];
    return l;
  }

  List<Widget>createmode(Services serv){
    Company company = serv.company;
   double width = 70;
  double heigth = 40;
  final double radius = 10;
    List<Widget> l = [];
      if (company.datas.payments.cash != null) {
          Widget a =  GestureDetector(
            onTap: (){
              serv.paiementMode =company.datas.payments.cash.fullName;
            },
            child: Container(
                  height:heigth,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/cash"+".jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(radius)
                    ),
                  ))
          ) ;

          l.add(a);
          l.add(SizedBox(width: 10,));
        
      }
       if (company.datas.payments.mobilemoney != null) {
         Widget a =  GestureDetector(
            onTap: (){
              serv.paiementMode =company.datas.payments.mobilemoney.fullName;
            },
            child: Container(
                  height:heigth,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/mobilemoney"+".jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(radius)
                    ),
                  )),
          ) ;

         l.add(a);
          l.add(SizedBox(width: 10,));
      }
       if (company.datas.payments.paypal != null) {
         Widget a =  GestureDetector(
            onTap: (){
              serv.paiementMode =company.datas.payments.paypal.fullName;
            },
            child: Container(
                  height:heigth,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/paypal"+".jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(radius)
                    ),
                  ))
          ) ;

         l.add(a);
          l.add(SizedBox(width: 10,));
      }
       if (company.datas.payments.card != null) {
         Widget a =  GestureDetector(
            onTap: (){
              serv.paiementMode =company.datas.payments.card.fullName;
            },
            child: Container(
                  height:heigth,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/card"+".jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(radius)
                    ),
                  ))
          ) ;

          l.add(a);
         // l.add(SizedBox(width: 5,));
      }
      
    
    return l;
  }

}
