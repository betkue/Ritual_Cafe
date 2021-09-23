import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ritual_cafe/bdd/bdd.dart';
import 'package:ritual_cafe/models/json/collectionjson.dart';
import 'package:ritual_cafe/models/json/errorconnexion.dart';
import 'package:ritual_cafe/models/json/errorlogin.dart';
import 'package:ritual_cafe/models/response.dart';

import 'package:ritual_cafe/models/user.dart';

class Services with ChangeNotifier {
  final UserBdd user;
  final  url = Uri.http('192.168.43.253','freeing/index.php');
  Services(this.user);
  void _searchUser(List<UserBdd>  users, UserBdd user){
    bool present = false;
    for (var i = 0; i < users.length; i++) {
      if (users[i].password == user.password && users[i].email == user.email) {
        present = true;
      }

    }
    if (!present) {
      DataBase.instance.updateUser(user, '');
    }
  }
//user register
  User _registerUser =User('', '', '','','');//user initial
  get registerUser =>_registerUser;
  set registerUser(User a)
  {
    _registerUser = a;
    notifyListeners();
  }
//log determine si nous sommes en connexion ou inscripetion

  bool _login = false ;
  get login => _login;
  set login (bool a){
    _login = a;
    notifyListeners();
  }
  //determine si une requete future a ete appele pour pouvoir creer le loadding
  bool _send = false ;
  get send => _send;
  set send (bool a){
    _send = a;
    notifyListeners();
  }
//indexproduit
  int _indexProduit = 0 ;
  get indexProduit => _indexProduit;
  set indexProduit (int a){
    _indexProduit = a;
    notifyListeners();
  }

//idcollection
  int _indexCollection = 0 ;
  get indexCollection => _indexCollection;
  set indexCollection (int a){
    _indexCollection = a;
    notifyListeners();
  }
//collection
  CollectionsJson _collection;
  get collections => _collection;
  set collections (CollectionsJson a){
    _collection = a;
    notifyListeners();
  }
  //connexion
  Future<ResponseSend> connexion(UserBdd user)async{

    this.send = true ;
    final  url = Uri.https('dashboard.mystore.lamater.net','api/2021-05/clients/login');
    print(url);
    var response = await http.post(
        url,
        body:{
          "email": user.email,
          "password": user.password
        } );
    print(response.statusCode);print(response.body);
    switch (response.statusCode) {
      case 200 :
        final String responsestring  = response.body;
        // JsonUser result = jsonUserFromJson(responsestring);
        //_registerUser = User(result.user.firstname,result.user.surname,result.user.email,result.user.email,result.user.tel);
        List<UserBdd> users = await DataBase.instance.user();
        _searchUser(users,user);
        return ResponseSend(true, 'connected');
        break;
      case 403 :
        final String responsestring  = response.body;
        ErrorConnexion result = ErrorConnexionFromJson(responsestring);
        return ResponseSend(false, result.message +" \n "+ result.special);
        break;
      default:
        return ResponseSend(false, 'Error connexion');
    }
  }
  //inscription
  Future<ResponseSend> inscription(User user)async{
    final  url = Uri.https('dashboard.mystore.lamater.net','api/2021-05/clients/register');

//final  url = Uri.http('192.168.43.253','cafe/index.php');
    var response =  await http.post(
        url,
        body:{
          "email": user.email,
          "tel": user.tel,
          "firstname": user.firstname,
          "surname" : user.surname,
          "password": user.password,
          "fromApi": true.toString()
        } );
    print(response.statusCode);print(response.body);
    switch (response.statusCode) {
      case 201 :
        final String responsestring  = response.body;
        _registerUser = user;
        //  JsonUser result = jsonUserFromJson(responsestring);
        List<UserBdd> users = await DataBase.instance.user();
        _searchUser(users,UserBdd(user.password, user.email));
        return ResponseSend(true, 'connected');
        break;
      case 403 :
        final String responsestring  = response.body;
        ErrorLogin result = ErrorLoginFromJson(responsestring);
        return ResponseSend(false, "Echec Connexion");
        break;
      default:
        return ResponseSend(false, 'Error connexion');

    }

  }
  //get collections
  Future<CollectionsJson> collection()async{

    final  url = Uri.https('dashboard.mystore.lamater.net','api/2021-05/companies/430/collections');
    var response =  await http.get(url);
    if(response.statusCode == 200){
      String responsestring = response.body;
      CollectionsJson collections = CollectionsJsonFromJson(responsestring);
      _collection = collections ;
      return collections;
    }
  }
}