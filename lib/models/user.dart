//user inscription
class User{
  String firstname;
  String email;
  String surname;
  String password;
  String tel;
  User(this.firstname,this.surname,this.email,this.password,this.tel);
}
//user de la bdd mais aussi utilise en connexion
class UserBdd{
  String code;
  UserBdd(this.code);
  Map<String, dynamic> toMap() {
    return {
      'code':code,

    };
  }

  factory  UserBdd.fromMap(Map<String, dynamic> map) => new  UserBdd(

      map['code'],

  );
}
