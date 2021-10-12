import 'package:flutter/widgets.dart';
import 'package:ritual_cafe/models/commande.dart';
import 'package:ritual_cafe/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  //initialisation de la bdd
  DataBase._();

  static final DataBase instance = DataBase._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }
//fonction d'initialisation
  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'cafe.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE  user(code TEXT)",
         
        ).then((value) => db.execute( "CREATE TABLE  commande(id TEXT)",));
      },

      version: 1,
    );
  }
  //insertion de l'utilisateur
  void insertUser(UserBdd user) async {
    final Database db = await database;
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
    //insertion de commende
  void insertCommande(UserBdd commande) async {
    final Database db = await database;
    await db.insert(
      'commande',
      commande.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  //suppression de l'utilisateur
  void deleteUser(String title) async {
    final Database db = await database;
    db.delete("user", where: "code = ?", whereArgs: [title]);
  }
    //suppression de la commende
  void deleteCommande(String title) async {
    final Database db = await database;
    db.delete("commande", where: "commande = ?", whereArgs: [title]);
  }
  //modification de l'utilisateur
  void updateUser(UserBdd user,String nom) async {
    final Database db = await database;
    await db.update("user", user.toMap(),
        where: "code = ?", whereArgs: [nom]);
        
  }
   //modification de la commande
  void updateCommande(UserBdd commande,String nom) async {
    final Database db = await database;
    await db.update("commande", commande.toMap(),
        where: "commande = ?", whereArgs: [nom]);
        
  }


  // get UserBdd

  Future<List<UserBdd>> user() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    List<UserBdd> users = List.generate(maps.length, (i) {
      return UserBdd.fromMap(maps[i]);
    });
    List<UserBdd> defaultUser = [UserBdd("NULL")];
    if (users.isEmpty) {
      for (UserBdd user in defaultUser) {
        insertUser(user);
      }
      users = defaultUser;
    }

    return users;
  }

    // get Commande

  Future<List<UserBdd>> commandes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('commande');
    List<UserBdd> users = List.generate(maps.length, (i) {
      return UserBdd.fromMap(maps[i]);
    });
    List<UserBdd> defaultUser = [UserBdd("NULL")];
    if (users.isEmpty) {
      for (UserBdd commande in defaultUser) {
        insertCommande(commande);
      }
      users = defaultUser;
    }

    return users;
  }
}