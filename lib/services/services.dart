import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:template1_genuka_mobile/models/commande.dart';
import 'package:template1_genuka_mobile/models/json/collectionjson.dart';
import 'package:template1_genuka_mobile/models/json/company.dart';
import 'package:template1_genuka_mobile/models/json/errorconnexion.dart';
import 'package:template1_genuka_mobile/models/json/errorlogin.dart';
import 'package:template1_genuka_mobile/models/json/jsonlistecommande.dart';
import 'package:template1_genuka_mobile/models/json/jsonuser.dart';
import 'package:template1_genuka_mobile/models/json/reponsepostcommande.dart';
import 'package:template1_genuka_mobile/models/json/responseUpdateUser.dart';
import 'package:template1_genuka_mobile/models/response.dart';
import 'package:template1_genuka_mobile/models/user.dart';
import 'dart:async';
import 'package:template1_genuka_mobile/bdd/bdd.dart';

//import 'package:sqflite/sqflite.dart';

class Services with ChangeNotifier {
  UserBdd user;
  void genererCommande()async{
    _commandes = await DataBase.instance.commandes();
    for (var i = 0; i < _commandes.length; i++) {
      _total =   _total + _commandes[i].prixTotal;
      _total2 = _total;
    }
  }
  String _commandeId = "";
  get commandeid =>_commandeId;
  //final  url = Uri.http('192.168.43.253','freeing/index.php');
  Services(this.user){genererCommande();}

  void _searchUser(UserBdd use) async {
    DataBase.instance.updateUser(use, user.code);
  }
  JsonListeCommandes _listeCommandes =JsonListeCommandes();
    get listeCommandes => _listeCommandes;
  set listeCommandes(JsonListeCommandes a) {
    _listeCommandes = a;
    notifyListeners();
  }
  String _paiementMode ="Cash";
  get paiementMode =>_paiementMode;
  set paiementMode(String a){
    _paiementMode=a;
    notifyListeners();
  }
  String _companyId = "430";
  get companyId => _companyId;
  //user register
  ResponseUpdateUser _registerUser = ResponseUpdateUser(profilePicture:"https://betkuetankoua.hostme.space/assets/img/profile.jpg "); //user initial
  get registerUser => _registerUser;
  set registerUser(ResponseUpdateUser a) {
    _registerUser = a;
    notifyListeners();
  }

  //company
  Company _company = Company(); //user initial
  get company => _company;
  set company(Company a) {
    _company = a;
    notifyListeners();
  }
//log determine si nous sommes en connexion ou inscripetion

  bool _login = false;
  get login => _login;
  set login(bool a) {
    _login = a;
    notifyListeners();
  }

  bool _onCollection = false;
  get onCollection => _onCollection;
  set onCollection(bool a) {
    _onCollection = a;
    notifyListeners();
  }

  //determine si une requete future a ete appele pour pouvoir creer le loadding
  bool _send = false;
  get send => _send;
  set send(bool a) {
    _send = a;
    notifyListeners();
  }

  int _selectedIndex = 0;
  get selectedIndex => _selectedIndex;
  set selectedIndex(int a) {
    _selectedIndex = a;
    notifyListeners();
  }
    int _idHistory = 0;
  get idHistory => _idHistory;
  set idHistory(int a) {
    _idHistory = a;
    notifyListeners();
  }

//indexproduit
  int _indexProduit = 0;
  get indexProduit => _indexProduit;
  set indexProduit(int a) {
    _indexProduit = a;
    notifyListeners();
  }

//idcollection
  int _indexCollection = 0;
  get indexCollection => _indexCollection;
  set indexCollection(int a) {
    _indexCollection = a;
    notifyListeners();
  }

  //idcommande
  int _indexCommande = 0;
  get indexCommande => _indexCommande;
  set indexCommande(int a) {
    _indexCommande = a;
    notifyListeners();
  }

//collection
  CollectionsJson _collection;
  get collections => _collection;
  set collections(CollectionsJson a) {
    _collection = a;
    notifyListeners();
  }

  //Total
  int _total = 0;

  get total => _total;
  set total(int a) {
    _total = a;
    _total2 = a;
    notifyListeners();
  }
    //Total2
  int _total2 = 0;

  get total2 => _total2;


//Commandes
  List<Commande> _commandes ;
  get commande => _commandes;
  set commande(Commande a) {
    DataBase.instance.insertCommande(UserBdd(CommandeToJson(a)));
    _commandes.add(a);
    
    //notifyListeners();
  }

  //delete commande
  deleteCommande(int i) {
    _total = _total - _commandes[i].prixTotal;
    DataBase.instance.deleteCommande(CommandeToJson(_commandes[i]));
    _commandes.removeAt(i);
    notifyListeners();
  }

  //update
  updateCommande(int i, Commande a) {
    DataBase.instance.updateCommande(UserBdd(CommandeToJson(a)), CommandeToJson(_commandes[i]));
    _commandes[i] = a;
    notifyListeners();
  }

  //connexion
  Future<ResponseSend> connexion(String pass, String mail) async {
    this.send = true;
    final url = Uri.https('dashboard.genuka.com', 'api/2021-05/clients/login');
    try {
      var response = await http.post(url, body: {
        "email": mail,
        "password": pass,
        "company_id": _companyId
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final String responsestring = response.body;
       //   JsonUser result = jsonUserFromJson(responsestring);
          //_registerUser = User(result.user.firstname,result.user.surname,result.user.email,result.user.email,result.user.tel);

        //  _searchUser(UserBdd(result.accessToken));
          return ResponseSend(true, 'connected');
          break;
        case 403:
          final String responsestring = response.body;
          ErrorConnexion result = ErrorConnexionFromJson(responsestring);
          return ResponseSend(false, result.message + " \n " + result.special);
          break;
        default:
          return ResponseSend(false, 'Error connexion');
      }
    } catch (e) {

      print(e);
      return ResponseSend(false, 'Error connexion');
    }
  }

  //inscription
  Future<ResponseSend> inscription(User user) async {
    final url =
        Uri.https('dashboard.genuka.com', 'api/2021-05/clients/register');

//final  url = Uri.http('192.168.43.253','cafe/index.php');
    try {
      var response = await http.post(url, body: {
        "email": user.email,
        "tel": user.tel,
        "firstname": user.firstname,
        "surname": user.surname,
        "password": user.password,
        "company_id": _companyId,
        "fromApi": true.toString()
      });
      switch (response.statusCode) {
        case 201:
          final String responsestring = response.body;
          JsonUser result = jsonUserFromJson(responsestring);
          //List<UserBdd> users = await DataBase.instance.user();

          _searchUser(UserBdd(result.accessToken));
          return ResponseSend(true, 'connected');
          break;
        case 403:
          final String responsestring = response.body;
          ErrorLogin result = ErrorLoginFromJson(responsestring);
          return ResponseSend(false, "Echec Connexion");
          break;
        default:
          return ResponseSend(false, 'Error connexion');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //get collections
  Future<CollectionsJson> collection() async {
    final url = Uri.https('dashboard.genuka.com', 'api/2021-05/companies/'+_companyId+'/collections');
   try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        String responsestring = response.body;
        CollectionsJson collections = CollectionsJsonFromJson(responsestring);
        _collection = collections;
        _onCollection = true;
        return collections;
      }
     } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ResponseUpdateUser> getUser(String token) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            "https://dashboard.genuka.com/api/2021-05/user?company_id="+_companyId),
        headers: {
          "Authorization": "Bearer " + token,
          "Accept": "application/json"
        },
      );

      switch (response.statusCode) {
        case 200:
          final String responsestring = response.body;
          ResponseUpdateUser result =
              jsonResponseUpdeteFromJson(responsestring);
          _registerUser = result;
          
          return _registerUser;
          break;
        case 403:
          return ResponseUpdateUser();
          break;
        default:
          return ResponseUpdateUser();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ResponseUpdateUser> updateUser(ResponseUpdateUser user) async {
    try {
      http.Response response = await http.put(
          Uri.parse(
              "https://dashboard.genuka.com/api/2021-05/clients/account/update"),
          headers: {
            "Authorization": "Bearer " + this.user.code,
            "Accept": "application/json"
          },
          body: {
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email": user.email,
            "phone": user.phone,
            "sex": user.sex,
            "fromApi": true.toString()
          });
      switch (response.statusCode) {
        case 200:
          final String responsestring = response.body;
          ResponseUpdateUser result =
              jsonResponseUpdeteFromJson(responsestring);
          _registerUser = result;
          notifyListeners();

          return result;
          break;
        case 403:
          return ResponseUpdateUser();
          break;
        default:
          return ResponseUpdateUser();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ResponseUpdateUser> updatePhoto(String photo) async {
    try {
      http.Response response = await http.put(
          Uri.parse(
              "https://dashboard.genuka.com/api/2021-05/clients/account/update"),
          headers: {
            "Authorization": "Bearer " + this.user.code,
            "Accept": "application/json",
            //'content-type': 'multipart/form-data'
          },
          body: {
            "profile_picture": photo,
            "fromApi": true.toString()
          });
      switch (response.statusCode) {
        case 200:
          final String responsestring = response.body;
          ResponseUpdateUser result =
              jsonResponseUpdeteFromJson(responsestring);
          _registerUser = result;
          notifyListeners();

          return result;
          break;
        case 403:
          return ResponseUpdateUser();
          break;
        default:
          return ResponseUpdateUser();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Company> getCompany(String token) async {
    //List<UserBdd> users = await DataBase.instance.user();

    try {
      http.Response response = await http.get(
        Uri.parse(
            "https://dashboard.genuka.com/api/2021-05/companies/details/"+_companyId),
        headers: {
          "Authorization": "Bearer " + token,
          "Accept": "application/json"
        },
      );
        print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final String responsestring = response.body;
          Company result = jsonCompanyFromJson(responsestring);
          _company = result;
          notifyListeners();
          return _company;
          break;
        case 403:
          return Company();
          break;
        default:
          return Company();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> commander(String nom, String prenom, String mail, String tel,
      String adresse, String note) async {
    final url = Uri.https('dashboard.genuka.com', 'api/2021-05/commands');

    //final  url = Uri.http('192.168.43.253','cafe/index.php');
    Map data = {
      "client_email": mail,
      "restaurant_id": _companyId,
      //"reduction":null.toString(),
      "total": (_total + double.parse(_company.tarifLivraison))
          .toString(), // Frais de livraison
      "subtotal": _total.toString(),
      "livraison": _company.tarifLivraison.toString(), // Frais de livraison
      "shipping": {
        "state": 0.toString(),
        "date": DateTime.now().millisecondsSinceEpoch, //DateTime.now()
        "human_date": DateTime.now().millisecondsSinceEpoch,
        "address_type": 1.toString(),
        "address": adresse,
        "mode": "home delivery"
      },
      "payment": {"mode": _paiementMode, "state": 0},
      "note": note,
      "source": "Mobile App",
      "produits": _commandes.map((Commande produit) {
        return {
          "id": produit.id.toString(),
          "quantity": produit.nombre.toString(),
          "price": (produit.price + produit.priceadd).toString(),
          "add_to_cart_date": produit.date,
          "properties": {"complement": produit.complement, "note": produit.note}
        };
      }).toList()
    };
    try {
      var response = await http.post(url,
          headers: {
            "Authorization": "Bearer " + this.user.code,
            "Accept": "application/json",
            "Content-type": "application/json"
          },
          body: jsonEncode(data));
      switch (response.statusCode) {
        case 201:
          final String responsestring = response.body;
          ReponsePostCommande result = ReponsePostCommandeFromJson(responsestring);
          
          for (var i = 0; i < _commandes.length; i++) {
            
             DataBase.instance.deleteCommande(CommandeToJson(_commandes[i]));
          }
          _commandes= [];
          _total = 0;
          _commandeId = result.id.toString();
          notifyListeners();


          return _commandeId;
          break;
        case 403:
          return "";
          break;
        default:
          return "";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<JsonListeCommandes> getDetailClient() async {
    //List<UserBdd> users = await DataBase.instance.user();

    try {
      http.Response response = await http.get(
        Uri.parse(
            "https://dashboard.genuka.com/api/2021-05/clients/commands"),
        headers: {
          "Authorization": "Bearer " + this.user.code,
          "Accept": "application/json",
          "Content-type": "application/json"
        },
      );
      switch (response.statusCode) {
        case 200:
          final String responsestring = response.body;
          JsonListeCommandes result = JsonListeCommandesFromJson(responsestring);
          _listeCommandes =result;
          return _listeCommandes;
          break;
        case 403:
          return JsonListeCommandes();
          break;
        default:
          return JsonListeCommandes();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
    Future<ResponseSend> buyMobile(String number, String service) async {
    //List<UserBdd> users = await DataBase.instance.user();
    try {
      http.Response response = await http.post(
        Uri.parse(
           "https://dashboard.genuka.com/api/2021-05/payments/mobilemoney/charge"),
        headers: {
          "Authorization": "Bearer " + this.user.code,
          "Accept": "application/json"
          //"Content-type": "application/json"
        },
        body: {
          "phoneService":service,
          "amount":_total2.toString(),
          "phone":number,
          "command_id":_commandeId,
          "fees":true.toString()
        }
      );
          ResponseSend result = ResponseSendFromJson(response.body);
      switch (response.statusCode) {
        case 200:
          //final String responsestring = response.body;
          _total2 = 0;
          notifyListeners();
          return ResponseSend(true,result.message);
          break;
        case 403:
          return ResponseSend(false,result.message);
        case 400:
          return ResponseSend(false,result.message);
          break;
        default:
          return ResponseSend(false,result.message);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
