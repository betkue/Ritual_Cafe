import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template1_genuka_mobile/collections/colors.dart';
import 'package:template1_genuka_mobile/models/response.dart';
import 'package:template1_genuka_mobile/models/user.dart';
import 'package:template1_genuka_mobile/services/services.dart';
import 'package:provider/provider.dart';
import '../../loadding.dart';
import 'decoration.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
class Auth extends StatelessWidget {
  Services servs;
  Auth(this.servs);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value:this.servs,
    child: AuthFull(this.servs),
    );
  }
}
class AuthFull extends StatefulWidget {
  Services servs;
 AuthFull(this.servs);

  @override
  _AuthFullState createState() => _AuthFullState();
}

class _AuthFullState extends State<AuthFull> {

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
  final formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();//mail
  final phoneController = TextEditingController();//mail
  final nomController = TextEditingController();//prenom nom
  final passController = TextEditingController();//password
  bool noView = true;//afficher mot de passe
  String error = "";//en cas d'erreur
 // String code = "+237";
  RegExp regExp =    new RegExp(r"^[a-zA-Z0-9._\-*ù^&éè#!§]+@[a-z0-9._-]+\.[a-z]{2,6}");//verification du mail
  RegExp re = new RegExp(r"^[a-zA-Z]+\s[a-zA-Z]+$");//regex nom prenom
  String initialCountry = 'CM';
  PhoneNumber number = PhoneNumber(isoCode: 'CM');
  void change(Services serv)
  {
    setState(() {
      error = '';
      formKey.currentState.reset();
    });

    serv.login  = !serv.login;
  }

  showPass()
  {
    setState(() {
      noView = !noView;
    });
  }
  @override
  void dispose() {
    mailController.dispose();
    passController.dispose();
    phoneController.dispose();
    nomController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery .of(context).size.width;
    return Consumer<Services>(
        builder: (context,servs,_)=>
      Scaffold(
        backgroundColor: arrowBackColor,
        body: servs.send ? Loadding(): ListView(
          children: [
            SizedBox(height: 15,),
            Text( "Ritual Café",//"Ritual Café"
              textAlign: TextAlign.center,
              style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 38
            ),),
            Text(servs.login?"Connexion":"Inscription",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: principalTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                )),
            SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.all(30),
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
                      children :servs.login? Login(servs): Register(servs)
                  ))),
            ),
          ),
            Padding(
                padding: EdgeInsets.only(left: 30,right: 30,top: 10),
              child:
              !servs.login? GestureDetector(
                  onTap:() async{
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      servs.send  = true;
                      List<String> nomprenom = nomController.text.split(' ');
                      User user = User(nomprenom[1], nomprenom[0], mailController.text, passController.text,phoneController.text);
                     
                      //serv.send=true;

                      ResponseSend result = await servs.inscription(user);

                      if(result.etat)
                      {
                        snack(result.message,
                            Icon(Icons.check, color: validerColor,));
                       Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

                      }
                      else
                      {
                        setState(() {
                          error =result.message;
                        });
                        snack(result.message,
                            Icon(Icons.details, color: errorTextColor,));
                      }

                      servs.send  = false;
                    }
                  },
                  child:Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15),

                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10) ,
                      child: Text("Créer un compte",textAlign: TextAlign.center,
                        style: TextStyle(color:principalTextColor)
                        ,),
                    ),
                  ) ,
                )
                  :
              GestureDetector(
                onTap:() async {
                  if (formKey.currentState.validate()) {

                    servs.send  = true;
                    ResponseSend result = await servs.connexion(passController.text,mailController.text);
                    
                    if(result.etat)
                    {

                      snack(result.message,
                          Icon(Icons.check, color: validerColor,));
                     Navigator.of(context).pushNamedAndRemoveUntil('/',(Route<dynamic> route) => false);

                    }
                    else
                    {

                      setState(() {
                        error =result.message;
                      });

                      snack(result.message, Icon(Icons.details, color: errorTextColor,));
                            
                    }



                    servs.send  = false;
                  }
                },
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Connexion",textAlign: TextAlign.center,
                        style: TextStyle(color: principalTextColor)),
                  ),
                ) ,
              )
              ,
            ),
            Padding(padding: EdgeInsets.only(left: 30,right: 30,top: 30),
            child:
             GestureDetector(
              onTap: (){change(servs); },
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: choiceColor,
                  borderRadius: BorderRadius.circular(15),

                ),
                child: Padding(
                  padding: EdgeInsets.all(10) ,
                  child: Text( servs.login? "Creer un compte" : "Connexion",textAlign: TextAlign.center,
                    style: TextStyle(color: principalTextColor)
                    ,),
                ),
              ) ,
            ),
            ),
            //si login se connecter sinon s'enregistre
          ],
        ) ,
      )
    ) ;
  }
  //formulaire de connexion
  List<Widget>  Register(Services servs){
    double width = MediaQuery .of(context).size.width;
    return [
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text("Prénom & Nom",textAlign: TextAlign.start,
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
          decoration:textInputDecoration.copyWith(hintText: 'Nom Prenom'),
          validator: (value) {
            if (!re.hasMatch(value)) {
              return 'Entrez sus la forme "Nom Prenom"  ';
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
              return 'Entrez un mail';
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
        child: Text("Mot de passe",textAlign: TextAlign.start,
          style: TextStyle(color: principalTextColor,fontSize: 15,
          ),),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 5.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: TextFormField(
          cursorColor: principalTextColor,
          controller: passController,
          obscureText: noView,
          style:TextStyle(
              color: principalTextColor,
              fontWeight: FontWeight.bold
          ),
          decoration:textInputDecoration.copyWith(hintText: 'Mot de passe'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Entrez un mot de passe';
            }
            return null;
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
  }
  //formulaire d'inscription
  List<Widget>  Login(Services servs){
    double width = MediaQuery .of(context).size.width;
    return [

      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text("Email",textAlign: TextAlign.start,
          style: TextStyle(color: principalTextColor,fontSize: 15,
          ),),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
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
            if (value.isEmpty) {
              return 'Entrez un mail';
            }
            return null;
          },
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text("Mot de passe",textAlign: TextAlign.start,
          style: TextStyle(color: principalTextColor,fontSize: 15,
          ),),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: TextFormField(
          cursorColor: principalTextColor,
          controller: passController,
          obscureText: noView,
          style:TextStyle(
              color: principalTextColor,
              fontWeight: FontWeight.bold
          ),
          decoration:textInputDecoration.copyWith(hintText: 'Mot de passe'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Entrez un mot de passe';
            }
            return null;
          },
        ),
      ),
      SizedBox(height: 10,),
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(error,textAlign: TextAlign.center,
          style: TextStyle(color: errorTextColor,
          ),),
      ),
    ];
  }

}

/*CountryCodePicker(
                  textStyle: TextStyle(color: principalTextColor),
                  onChanged: _telChange,
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'CM',
                  favorite: ['+237','CM'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed:false,
                  // optional. aligns the flag and the Text left
                  alignLeft: true,
                  hideMainText: false,
                  showFlag:false ,
                )*/