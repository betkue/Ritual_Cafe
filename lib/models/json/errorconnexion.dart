import 'dart:convert';
ErrorConnexion ErrorConnexionFromJson(String str) => ErrorConnexion.fromJson(json.decode(str));

String ErrorConnexionToJson(ErrorConnexion data) => json.encode(data.toJson());
class ErrorConnexion {
  String code;
  String status;
  String special;
  String message;

  ErrorConnexion({this.code, this.status, this.special, this.message});

  ErrorConnexion.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    special = json['special'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['special'] = this.special;
    data['message'] = this.message;
    return data;
  }
}
