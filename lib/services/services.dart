import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ritual_cafe/models/commande.dart';
import 'package:ritual_cafe/models/json/collectionjson.dart';
import 'package:ritual_cafe/models/json/company.dart';
import 'package:ritual_cafe/models/json/errorconnexion.dart';
import 'package:ritual_cafe/models/json/errorlogin.dart';
import 'package:ritual_cafe/models/json/jsonuser.dart';
import 'package:ritual_cafe/models/json/responseUpdateUser.dart';
import 'package:ritual_cafe/models/response.dart';
import 'package:ritual_cafe/models/user.dart';
import 'dart:async';
import 'package:ritual_cafe/bdd/bdd.dart';

//import 'package:sqflite/sqflite.dart';

class Services with ChangeNotifier {
   UserBdd user;
  //final  url = Uri.http('192.168.43.253','freeing/index.php');
  Services(this.user);
  
  void _searchUser(UserBdd use)async{
      DataBase.instance.updateUser(use,user.code);
    
  }
  String _companyId = "403";

  //user register
  ResponseUpdateUser _registerUser = ResponseUpdateUser();//user initial
  get registerUser =>_registerUser;
  set registerUser(ResponseUpdateUser a)
  {
    _registerUser = a;
    notifyListeners();
  }

    //company
  Company _company = Company();//user initial
  get company  =>_registerUser;
  set company (Company a)
  {
    _company = a;
    notifyListeners();
  }
//log determine si nous sommes en connexion ou inscripetion

  bool _login = false ;
  get login => _login;
  set login (bool a){
    _login = a;
    notifyListeners();
  }
    bool _onCollection = false ;
  get onCollection => _onCollection;
  set onCollection (bool a){
    _onCollection = a;
    notifyListeners();
  }
  //determine si une requete future a ete appele pour pouvoir creer le loadding
  bool _send = false ;
  get send => _send;
  set send (bool a){
    _send = a;
    notifyListeners();
  }
  int _selectedIndex = 0;
    get selectedIndex => _selectedIndex;
  set selectedIndex (int a){
    _selectedIndex = a;
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
  //idcommande
  int _indexCommande = 0 ;
  get indexCommande => _indexCommande;
  set indexCommande (int a){
    _indexCommande = a;
    notifyListeners();
  }
//collection
  CollectionsJson _collection;
  get collections => _collection;
  set collections (CollectionsJson a){
    _collection = a;
    notifyListeners();
  }
  //Total
  int _total = 0;
  
  get total => _total;
  set total (int a){
    _total = a;
    notifyListeners();
  }
  
 
//Commandes
List<Commande> _commandes = [];

  get commande => _commandes;
  set commande (Commande a){
    _commandes.add(a);
    notifyListeners();
  }
  //delete commande
  deleteCommande(int i){
    _total = _total - _commandes[i].prixTotal;
    _commandes.removeAt(i);
    notifyListeners();
  }
  //update
  updateCommande(int i,Commande a){
   _commandes[i] = a ;
   notifyListeners();
  }
  //connexion
  Future<ResponseSend> connexion(String pass,String mail)async{

    this.send = true ;
   // final  url = Uri.https('dashboard.mystore.lamater.net','api/2021-05/clients/login');
    final  url = Uri.https('dashboard.genuka.com','api/2021-05/clients/login');
    var response = await http.post(
        url,
        body:{
          "email": mail,
          "password": pass,
          "Company_id": 403.toString()
        } );
    switch (response.statusCode) {
      case 200 :
        final String responsestring  = response.body;
         JsonUser result = jsonUserFromJson(responsestring);
        //_registerUser = User(result.user.firstname,result.user.surname,result.user.email,result.user.email,result.user.tel);
        
           _searchUser(UserBdd(result.accessToken));
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
    final  url = Uri.https('dashboard.genuka.com','api/2021-05/clients/register');

//final  url = Uri.http('192.168.43.253','cafe/index.php');
    var response =  await http.post(
        url,
        body:{
          "email": user.email,
          "tel": user.tel,
          "firstname": user.firstname,
          "surname" : user.surname,
          "password": user.password,
          "Company_id": 403.toString(),
          "fromApi": true.toString()
        } );
    switch (response.statusCode) {
      case 201 :
        final String responsestring  = response.body;
         JsonUser result = jsonUserFromJson(responsestring);
        //List<UserBdd> users = await DataBase.instance.user();
        
        _searchUser(UserBdd(result.accessToken));
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

    final  url = Uri.https('dashboard.genuka.com','api/2021-05/companies/430/collections');
    var response =  await http.get(url);
    if(response.statusCode == 200){
      String responsestring = response.body;
      CollectionsJson collections = CollectionsJsonFromJson(responsestring);
      _collection = collections ;
      _onCollection = true;
      return collections;
    }
  }

  Future<ResponseUpdateUser> getUser(String token)async{
      //List<UserBdd> users = await DataBase.instance.user();
        
      http.Response response = await http.get(
    //Uri.parse("https://dashboard.mystore.lamater.net/api/2021-05/user?company_id=430"),
    //              https://dashboard.genuka.com/api/2021-05/user?company_id=430
        Uri.parse("https://dashboard.genuka.com/api/2021-05/user?company_id=430"),
        headers: {
          "Authorization": "Bearer " + token,
          "Accept": "application/json"
        },
    );
    
    /*
    final response = await http.get(
       //Uri.parse("https://dashboard.mystore.lamater.net/api/2021-05/user?company_id=430"),
  
    Uri.parse('https://dashboard.genuka.com/api/2021-05/user?company_id=430'),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader:   "Bearer " + token,
      HttpHeaders.acceptHeader:"application/json"
    },
  );
  */

 

   switch (response.statusCode) {
      case 200 :
        final String responsestring  = response.body;
        ResponseUpdateUser result = jsonResponseUpdeteFromJson(responsestring);
        _registerUser = result;
        return  _registerUser;
        break;
      case 403 :
        return ResponseUpdateUser();
        break;
      default:
        return  ResponseUpdateUser();

    }

  }
   Future<ResponseUpdateUser> updateUser(ResponseUpdateUser user)async{
     
     http.Response response = await http.put(
       Uri.parse("https://dashboard.genuka.com/api/2021-05/clients/account/update"),
           headers: {
             "Authorization": "Bearer " + this.user.code,
          "Accept": "application/json"
        },
           body: {
            
             "firstname":user.firstName,
              "lastname" :user.lastName,
              "surame" :user.lastName,
              "email": user.email,
              "tel": user.phone, 
              "sex": user.sex,
              "fromApi": true.toString()
              

           }
           
           );
              switch (response.statusCode) {
      case 200 :
      
        final String responsestring  = response.body;
        ResponseUpdateUser  result= jsonResponseUpdeteFromJson(responsestring)  ;
        _registerUser = result;
        notifyListeners();

        return   result;
        break;
      case 403 :
        return ResponseUpdateUser();
        break;
      default:
        return ResponseUpdateUser();

    }

 

  }

   Future<Company> getCompany(String token)async{
      //List<UserBdd> users = await DataBase.instance.user();
        
      http.Response response = await http.get(
    //Uri.parse("https://dashboard.mystore.lamater.net/api/2021-05/user?company_id=430"),
    //              https://dashboard.genuka.com/api/2021-05/user?company_id=430
        Uri.parse("https://dashboard.mystore.lamater.net/api/2021-05/companies/details/403"),
        headers: {
          "Authorization": "Bearer " + token,
          "Accept": "application/json"
        },
    );


 

   switch (response.statusCode) {
      case 200 :
        final String responsestring  = response.body;
        Company result = jsonCompanyFromJson(responsestring);
        _company = result;
        notifyListeners();
        return  _company;
        break;
      case 403 :
        return Company();
        break;
      default:
        return  Company();

    }

  }
  Future<String>  commander(String nom, String prenom,String mail, String tel, String adresse,String note)async
    {
            final  url = Uri.https('dashboard.genuka.com','api/2021-05/commands');

          //final  url = Uri.http('192.168.43.253','cafe/index.php');
    var data = {
                "client_email": mail,
                "restaurant_id": _companyId,
                "reduction":null.toString(),
                "total": (_total + double.parse(_company.tarifLivraison)).toString(), // Frais de livraison
                "subtotal": _total.toString(),
                "livraison": _company.tarifLivraison.toString(),// Frais de livraison
                "shipping": {
                    "address_type": 2.toString(),
                    "address_id":adresse,
                    "address": adresse,
                    "date":DateTime.now().toString(),
                    "state": 0.toString(),
                    // "mode" : provider.cart.shippingDateMode,
                    "mode":'Home delivery',
                    "human_date": DateTime.now().toString(),
                },
                "payment": {
                    "address_type": 2.toString(),
                    "address_id": null.toString(),
                    "address": null.toString(),
                    "mode": "cash",
                    "state": 0.toString(),
                },
                "note": note,
                "source": "Express/App",
                "produits": _commandes
                    .map((Commande produit) {
                        return {
                            "id": produit.id.toString(),
                            "quantity": produit.nombre.toString(),
                            "price": (produit.price+produit.priceadd).toString(),
                            "add_to_cart_date": DateTime.now().toString(),
                            "properties": {
                                "complement": "test",
                                "note": note
                            }
                        };
                    }).toList()
            };
            print(data);
        
    var response =  await http.post(
        url,
        body:json.encode(data)
        
        );
         print(response.statusCode);
      //   print(response.body);
         
         return response.body;


    }


}

/*    Future<String>  commander(String nom, String prenom,String mail, String tel, String adresse,String note)async
    {
            final  url = Uri.https('dashboard.genuka.com','api/2021-05/commands');

          //final  url = Uri.http('192.168.43.253','cafe/index.php');
    var data = {
                "client_email": mail,
                "restaurant_id": _companyId,
                "reduction":null.toString(),
                "total": (_total + double.parse(_company.tarifLivraison)).toString(), // Frais de livraison
                "subtotal": _total.toString(),
                "livraison": _company.tarifLivraison.toString(),// Frais de livraison
                "shipping": {
                    "address_type": 2.toString(),
                    "address_id":adresse,
                    "address": adresse,
                    "date":DateTime.now().toString(),
                    "state": 0.toString(),
                    // "mode" : provider.cart.shippingDateMode,
                    "mode":'Home delivery',
                    "human_date": DateTime.now().toString(),
                },
                "payment": {
                    "address_type": 2.toString(),
                    "address_id": null.toString(),
                    "address": null.toString(),
                    "mode": "cash",
                    "state": 0.toString(),
                },
                "note": note,
                "source": "Express/App",
                "produits": _commandes
                    .map((Commande produit) {
                        return {
                            "id": produit.id.toString(),
                            "quantity": produit.nombre.toString(),
                            "price": (produit.price+produit.priceadd).toString(),
                            "add_to_cart_date": DateTime.now().toString(),
                            "properties": {
                                "complement": "test",
                                "note": note
                            }
                        };
                    }).toList()
            };
        
    var response =  await http.post(
        url,
        body:json.encode(data)
        
        );
         print(response.statusCode);
         print(response.body);
         
         return response.body;


    } */


    /**
     *     Future<String>  commander(String nom, String prenom,String mail, String tel, String adresse,String note)async
    {
            final  url = Uri.https('dashboard.genuka.com','api/2020-04/commands');

          //final  url = Uri.http('192.168.43.253','cafe/index.php');
    var data = {
                "client_email": mail,
                 "client_details": {
                      "nom": nom,
                      "prenom":prenom,
                      "email": mail,
                      "tel": tel
                  },
                "restaurant_id": _companyId,
                "reduction":null.toString(),
                "total": (_total + double.parse(_company.tarifLivraison)).toString(), // Frais de livraison
                "subtotal": _total.toString(),
                "livraison": _company.tarifLivraison.toString(),// Frais de livraison
                "shipping": {
                    "state": 0,
                    "date": "",
                    "human_date": "",
                    "address_type" : 1,
                    "address": "",
                    "mode": "home delivery"
                },
                "payment": {
                    "mode": "cash",
                    "state": 0
                },
                "note": note,
                "source": "Express/App",
                "produits": _commandes
                    .map((Commande produit) {
                        return {
                            "id": produit.id.toString(),
                            "quantity": produit.nombre.toString(),
                            "price": (produit.price+produit.priceadd).toString(),
                            "add_to_cart_date": DateTime.now().toString(),
                            "properties": {
                                "complement": "test",
                                "note": note
                            }
                        };
                    }).toList()
            };
        
    var response =  await http.post(
        url,
        body:json.encode(data)
        
        );
         print(response.statusCode);
         print(response.body);
         
         return response.body;


    }


     */