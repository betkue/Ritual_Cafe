import 'dart:convert';
ErrorLogin ErrorLoginFromJson(String str) => ErrorLogin.fromJson(json.decode(str));

String ErrorLoginToJson(ErrorLogin data) => json.encode(data.toJson());
class ErrorLogin {
  String status;
  Message message;

  ErrorLogin({this.status, this.message});

  ErrorLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    return data;
  }
}

class Message {
  Email email;
  Email tel;

  Message({this.email, this.tel});

  Message.fromJson(Map<String, dynamic> json) {
    email = json['email'] != null ? new Email.fromJson(json['email']) : null;
    tel = json['tel'] != null ? new Email.fromJson(json['tel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.email != null) {
      data['email'] = this.email.toJson();
    }
    if (this.tel != null) {
      data['tel'] = this.tel.toJson();
    }
    return data;
  }
}

class Email {
  List<String> unique;

  Email({this.unique});

  Email.fromJson(Map<String, dynamic> json) {
    unique = json['Unique'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Unique'] = this.unique;
    return data;
  }
}
