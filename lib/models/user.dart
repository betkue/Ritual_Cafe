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
  String password;
  String email;
  UserBdd(this.password,this.email);
  Map<String, dynamic> toMap() {
    return {
      'password':password,
      'email':email

    };
  }

  factory  UserBdd.fromMap(Map<String, dynamic> map) => new  UserBdd(

      map['password'],
      map['email']

  );
}
