import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ritual_cafe/models/response.dart';
import 'package:ritual_cafe/models/user.dart';
import 'package:ritual_cafe/services/services.dart';
import 'package:provider/provider.dart';

import '../../loadding.dart';
import 'decoration.dart';

class Auth extends StatelessWidget {
  const Auth();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (create)=>Services(UserBdd("","")),
    child: AuthFull(),
    );
  }
}
class AuthFull extends StatefulWidget {
  const AuthFull();

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
            style: new TextStyle(color: Colors.white),
          ),
          SizedBox(width: 20),
          b

        ],
      ),
      backgroundColor: Colors.black54,);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  final formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();//mail
  final phoneController = TextEditingController();//mail
  final nomController = TextEditingController();//prenom nom
  final passController = TextEditingController();//password
  bool noView = true;//afficher mot de passe
  String error = "";//en cas d'erreur
  RegExp regExp =    new RegExp(r"^[a-zA-Z0-9._\-*ù^&éè#!§]+@[a-z0-9._-]+\.[a-z]{2,6}");//verification du mail
  RegExp re = new RegExp(r"^[a-zA-Z]+\s[a-zA-Z]+$");//regex nom prenom
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
        backgroundColor: Colors.black,
        body: servs.send ? Loadding(): ListView(
          children: [
            SizedBox(height: 15,),
            Text( "Ritual Café",//"Ritual Café"
              textAlign: TextAlign.center,
              style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 38
            ),),
            Text(servs.login?"Connexion":"Inscription",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
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
            Padding(padding: EdgeInsets.only(left: 30,right: 30,top: 10),
            child:
            GestureDetector(
              onTap: (){change(servs); },
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),

                ),
                child: Padding(
                  padding: EdgeInsets.all(10) ,
                  child: Text( servs.login? "Creer un compte" : "Connexion",textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)
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
          style: TextStyle(color: Colors.white,fontSize: 20,
          ),),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child:
        TextFormField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          controller: nomController,
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
          style: TextStyle(color: Colors.white,fontSize: 20,
          ),),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: TextFormField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.emailAddress,
          controller: mailController,
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
          style: TextStyle(color: Colors.white,fontSize: 20,
          ),),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: TextFormField(
          maxLength: 9,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                RegExp('[0-9]+'))
          ],

          cursorColor: Colors.black,
          keyboardType: TextInputType.phone,
          controller: phoneController,
          decoration:textInputDecoration.copyWith(hintText: 'Numero de télephone'),
          validator: (value) {
            if (value.length!=9) {
              return 'Le numero doit avoir 9 chiffres';
            }
            return null;
          },
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text("Mot de passe",textAlign: TextAlign.start,
          style: TextStyle(color: Colors.white,fontSize: 20,
          ),),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: TextFormField(
          cursorColor: Colors.black,
          controller: passController,
          obscureText: noView,
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
          style: TextStyle(color: Colors.red,
          ),),
      ),
      SizedBox(height: 10,),
      GestureDetector(
        onTap:() async{
          if (formKey.currentState.validate()) {
            servs.send  = true;
            List<String> nomprenom = nomController.text.split(' ');
            User user = User(nomprenom[1], nomprenom[0], mailController.text, passController.text,phoneController.text);
            Services serv = Services(UserBdd("",""));
            //serv.send=true;

            ResponseSend result = await serv.inscription(user);

            if(result.etat)
            {
              snack(result.message,
                  Icon(Icons.check, color: Colors.green,));
              Navigator.of(context).pushNamedAndRemoveUntil('/',(Route<dynamic> route) => false);

            }
            else
            {
              setState(() {
                error =result.message;
              });
              snack(result.message,
                  Icon(Icons.details, color: Colors.red,));
            }

            servs.send  = false;
          }
        },
        child:Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(15),

          ),
          child: Padding(
            padding: EdgeInsets.all(10) ,
            child: Text("Créer un compte",textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)
              ,),
          ),
        ) ,
      ),
      SizedBox(height: 15,),

    ];
  }
  //formulaire d'inscription
  List<Widget>  Login(Services servs){
    double width = MediaQuery .of(context).size.width;
    return [

      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text("Email",textAlign: TextAlign.start,
          style: TextStyle(color: Colors.white,fontSize: 20,
          ),),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: TextFormField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.emailAddress,
          controller: mailController,
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
          style: TextStyle(color: Colors.white,fontSize: 20,
          ),),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: TextFormField(
          cursorColor: Colors.black,
          controller: passController,
          obscureText: noView,
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
          style: TextStyle(color: Colors.red,
          ),),
      ),
      SizedBox(height:30 ,),
      GestureDetector(
        onTap:() async {
          if (formKey.currentState.validate()) {

            servs.send  = true;
            UserBdd user = UserBdd(  passController.text,mailController.text);
            Services serv = Services(UserBdd("",""));
            ResponseSend result = await serv.connexion(user);
            print(result.message);print(result.etat);

            if(result.etat)
            {

                              snack(result.message,
                                  Icon(Icons.check, color: Colors.green,));
                              Navigator.of(context).pushNamedAndRemoveUntil('/',
                                      (Route<dynamic> route) => false);

            }
            else
            {

              setState(() {
                error =result.message;
              });

                snack(result.message, Icon(Icons.details, color: Colors.red,));

            }



            servs.send  = false;
          }
        },
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(15),

          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text("Connexion",textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
          ),
        ) ,
      ),
    ];
  }
}

