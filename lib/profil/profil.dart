import 'dart:ui';

import 'package:ritual_cafe/models/json/responseUpdateUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ritual_cafe/clients/auth/decoration.dart';
import 'package:ritual_cafe/collections/colors.dart';
import 'package:ritual_cafe/loadding.dart';
import 'package:ritual_cafe/services/services.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Profil extends StatelessWidget {
 final  Services serv;
   Profil(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value:this.serv,
      child:ProfilFull(serv) ,
    );
  }
}
class ProfilFull extends StatefulWidget {
  final Services serv;
   ProfilFull(this.serv);

  @override
  _ProfilFullState createState() => _ProfilFullState();
}

class _ProfilFullState extends State<ProfilFull> {
   void snack(String a, Widget b) {
    SnackBar snackbar =  SnackBar(
      content:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(a, textAlign: TextAlign.center,
            style: new TextStyle(color: principalTextColor),
          ),
          SizedBox(width: 20),
          b

        ],
      ),
      backgroundColor: containerPrixProduitPanierColor,);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
   void update(Services serv,ResponseUpdateUser user)async{
    setState(() {
      send = true;
    });
    ResponseUpdateUser result =await serv.updateUser(user);
   
   
    if (result.id!=null) {
      setState(() {
        edit =false;
      });
      
                        snack("Updated",
                            Icon(Icons.check, color: validerColor,));
      
    } 
    else {
      
                        snack("Echec connexion",
                            Icon(Icons.details, color: errorTextColor,));
    }
    

     setState(() {
      
      send = false;
    });


  }
  
 final rechercheController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
  final sexeController = TextEditingController();
  final birthDateController = TextEditingController();
  RegExp regExp =    new RegExp(r"^[a-zA-Z0-9._\-*ù^&éè#!§]+@[a-z0-9._-]+\.[a-z]{2,6}");//verification du mail
  
  PhoneNumber number = PhoneNumber(isoCode: 'CM');
 bool edit = false;
 bool send = false;
   @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    telController.dispose();
    sexeController.dispose();
    birthDateController.dispose();
    super.dispose();
  }
  @override
    Widget build(BuildContext context) {
      ResponseUpdateUser user = widget.serv.registerUser;
      
    return  send? Loadding():  Consumer<Services>(
        builder: (context,servs,_)=>
          Scaffold(

              /*
              appBar: AppBar(
                title: Text(widget.serv.selectedIndex.toString()+"/"+servs.selectedIndex.toString()),
              ),
              */
              
                  backgroundColor: Colors.black,
              body:edit?
              ListView(
                children: [
                  Container(
                decoration: BoxDecoration(
                  gradient: gard,
                  borderRadius: BorderRadius.circular(14),
                ),
              child: Padding(
                  padding: const EdgeInsets.all(50), child: Form(
                  key:formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children :[
                        
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text("Prénom",textAlign: TextAlign.start,
                                  style: TextStyle(color: principalTextColor,fontSize: 15,
                                  ),),
                              ),
                             Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
                                child:
                                TextFormField(
                                  cursorColor: principalTextColor,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: prenomController,
                                  style:TextStyle(
                                      color: principalTextColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                  decoration:textInputDecoration.copyWith(hintText: 'Prénom'),
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
                                  keyboardType: TextInputType.emailAddress,
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
                                child: Text("Email",textAlign: TextAlign.start,
                                  style: TextStyle(color: principalTextColor,fontSize: 15,
                                  ),),
                              ),
                             Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
                                child:
                                TextFormField(
                                  cursorColor: principalTextColor,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  style:TextStyle(
                                      color: principalTextColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                  decoration:textInputDecoration.copyWith(hintText: 'Mail'),
                                  validator: (value) {
                                    if (!regExp.hasMatch(value.toString())) {
                                      
                                    setState(() {
                                      emailController.text = user.email;
                                    });
                                    }
                                    return null;
                                  },
                                ),
                              ),
                             Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text("Tel",textAlign: TextAlign.start,
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
          textFieldController: telController,
          textStyle: TextStyle(color: principalTextColor,fontWeight: FontWeight.bold),
          formatInput: true,
          keyboardType:TextInputType.numberWithOptions(signed: true, decimal: true),
          inputBorder: OutlineInputBorder(

              borderSide: BorderSide(color: secondaryTextColor,width: 1),
              borderRadius:BorderRadius.all(Radius.circular(10.0))),
          inputDecoration: textInputDecoration.copyWith(hintText: 'Phone',),
         
          onSaved: (PhoneNumber number) {
            telController.text = number.toString();
          },
        ),
      ),

                             Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text("Sexe",textAlign: TextAlign.start,
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
                                controller: sexeController,
                                maxLength: 1,
                                style:TextStyle(
                                    color: principalTextColor,
                                    fontWeight: FontWeight.bold
                                ),
                                decoration:textInputDecoration.copyWith(hintText: 'Sexe ( m / f )'),
                                validator: (value) {
                                  if (value!="m" && value!="f" ) {
                                    return 'choisir entre m et f"  ';
                                  }
                                  return null;
                                },
                              ),
                            ),
                             Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(padding: EdgeInsets.all(15),
                                  child: GestureDetector(
                    onTap: (){
                      if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      ResponseUpdateUser use = ResponseUpdateUser(
                        firstName:   prenomController.text,
                        lastName: nomController.text,
                        email: emailController.text,
                        phone: telController.text,
                        sex: sexeController.text =="f"? 'Female':'Male'
                      
                      
                      );
                      
                        formKey.currentState.reset();
                     update(servs,use);
                      }
                    },
                    child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: gard,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(padding: EdgeInsets.all(15),
                      child: Text("Modifier",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
              
                      )      )
                  ),
                  )),
                    
                             Padding(padding: EdgeInsets.all(15),
                                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        edit = false;
                      });
                    },
                    child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: gard,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(padding: EdgeInsets.all(15),
                      child: Text("Annuler",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
              
                      )      )
                  ),
                  )),
                                ],
                              ),
                      ]
                  ))),
            )
                ],
              )

              :
               ListView(
                
                children: [
                  Column(
                    children: [
                      Center(
                        child: ClipRRect(
                              borderRadius: BorderRadius.circular(150.0),
                              child: 
                               CachedNetworkImage(
                                   imageUrl: servs.registerUser.profilePicture!=null?servs.registerUser.profilePicture:'https://ssscompagnie.com/images/le_systeme/1.jpg',//
                                   placeholder: (context, url) =>
                                       Center(child: CircularProgressIndicator()),
                                   errorWidget: (context, url, error) => Icon(Icons.error),
                                   height: 150,
                                   width: 150,
                                   fit: BoxFit.cover,

                                 )
                              
                            ),
                      ),
                      Padding(padding: EdgeInsets.all(15),
                      child: Text(user.id!=null?user.id.toString():" . . . ",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),),
                    ],
                  ),

                      Padding(padding: EdgeInsets.all(15),
                  child: Row(
                      children: [
                        Text("Prénom : ",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                        Text(user.firstName!=null?user.firstName:" . . . ",style: TextStyle(color: principalTextColor60 ),),
                      ],
                  )),

                  
                   Padding(padding: EdgeInsets.all(15),
                  child: Row(
                      children: [
                        Text("Nom : ",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                        Text(user.lastName!=null?user.lastName:" . . . ",style: TextStyle(color: principalTextColor60),),
                      ],
                  )),
                  
                   Padding(padding: EdgeInsets.all(15),
                  child: Row(
                      children: [
                        Text("Email : ",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                        Text(user.email!=null?user.email:" . . . ",style: TextStyle(color: principalTextColor60),),
                      ],
                  )),

                   Padding(padding: EdgeInsets.all(15),
                  child: Row(
                      children: [
                        Text("Tel : ",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                        Text(user.phone!=null?user.phone:" . . . ",style: TextStyle(color: principalTextColor60),),
                      ],
                  )),

                   Padding(padding: EdgeInsets.all(15),
                  child: Row(
                      children: [
                        Text("Sexe : ",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                        Text(user.sex!=null?user.sex:" . . . ",style: TextStyle(color: principalTextColor60),),
                      ],
                  )),


                  Padding(padding: EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        edit = true;
                      });
                    },
                    child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.edit,color: principalTextColor60,size: 20,),
                        Text("Edit",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                        
                      ],
                    )
                  ),
                  )),
                ],
              )
          
               ));

                    

  }

}
