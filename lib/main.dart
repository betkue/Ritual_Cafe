import 'package:flutter/material.dart';
import 'package:ritual_cafe/collections/commander.dart';
import 'package:ritual_cafe/collections/home.dart';
import 'package:ritual_cafe/collections/pagner.dart';
import 'package:ritual_cafe/collections/updateProduit.dart';
import 'package:ritual_cafe/collections/viewproduit.dart';
import 'package:ritual_cafe/models/user.dart';
import 'package:ritual_cafe/services/services.dart';
import 'bdd/bdd.dart';
import 'clients/auth/auth.dart';
import 'loadding.dart';

import 'package:ritual_cafe/models/json/responseUpdateUser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Color.fromRGBO(202, 115, 64, 1),
        secondaryHeaderColor: Color.fromRGBO(44, 51,61, 1),
        backgroundColor:Color.fromRGBO(12, 15, 20, 1),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<UserBdd>>(
          future: DataBase.instance.user(),//initialisation de la bdd
          builder:(BuildContext context, AsyncSnapshot<List<UserBdd>> snapshot){

            if (snapshot.hasData)
            {
              


              List<UserBdd>  users = snapshot.data;
              UserBdd user = users[0];
               Services serv  = Services(user);
              if(user.code=="NULL")//si pas d'utilisateur enregistré
                  {//aller a l'authentificatiion
                return Auth(serv);
              }
              else//sinon
                  {
                //pour toujours avoir le mail d'utilisateur en cas de besoin
               
                return   FutureBuilder<ResponseUpdateUser>(
                        future: serv.getUser(serv.user.code),
                        builder: (BuildContext context,
                            AsyncSnapshot<ResponseUpdateUser> snapshot){
                              if (snapshot.hasData) {

                                
                               
                                
                                  if ( snapshot.data.id != null) {
                                    return Home(serv);
                                  } else {
                                    return Auth(serv);
                                  }
                              }
                              else{
                                  return Loadding();
                              }


                            }); //Home(serv);
              }

            }
            else
            {
              return Loadding();
            }
            //return Container(height: 0.0,width: 0.0,);
          }
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
//generation des routes
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case '/' :
        return MaterialPageRoute(builder: (context) => MyApp());
      case '/produits' :
        return MaterialPageRoute(builder: (context) => ViewProduit(settings.arguments));
      case '/pagner' :
        return MaterialPageRoute(builder: (context) => Pagner(settings.arguments));
        
      case '/home' :
        return MaterialPageRoute(builder: (context) => Home(settings.arguments));
      case '/update' :
        return MaterialPageRoute(builder: (context) => UpdateProduit(settings.arguments));
      case '/commander' :
        return MaterialPageRoute(builder: (context) => Commander(settings.arguments));

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                appBar: AppBar(title:Text("Error"), centerTitle: true),
                body: Center(
                  child: Text("Page not found"),
                )
            )
        );
    }
  }
}


