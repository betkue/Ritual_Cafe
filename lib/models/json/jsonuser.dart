import 'dart:convert';
JsonUser jsonUserFromJson(String str) => JsonUser.fromJson(json.decode(str));
String jsonUserToJson(JsonUser data) => json.encode(data.toJson());
class JsonUser {
  Use user;
  String accessToken;

  JsonUser({this.user, this.accessToken});

  JsonUser.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new Use.fromJson(json['user']) : null;
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['access_token'] = this.accessToken;
    return data;
  }
}

class Use {
  String firstname;
  String surname;
  String email;
  String tel;
  Null sex;
  Null birthDate;
  Null other;
  String updatedAt;
  String createdAt;
  int id;

  Use(
      {this.firstname,
        this.surname,
        this.email,
        this.tel,
        this.sex,
        this.birthDate,
        this.other,
        this.updatedAt,
        this.createdAt,
        this.id});

  Use.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    surname = json['surname'];
    email = json['email'];
    tel = json['tel'];
    sex = json['sex'];
    birthDate = json['birth_date'];
    other = json['other'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['tel'] = this.tel;
    data['sex'] = this.sex;
    data['birth_date'] = this.birthDate;
    data['other'] = this.other;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
