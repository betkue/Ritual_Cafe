import 'dart:convert';
ResponseUpdateUser jsonResponseUpdeteFromJson(String str) => ResponseUpdateUser.fromJson(json.decode(str));
String jsonResponseUpdeteToJson(ResponseUpdateUser data) => json.encode(data.toJson());
class ResponseUpdateUser {
  int id;
  String email;
  String sex;
  String profilePicture;
  Other other;
  String lastName;
  String firstName;
  String phone;

  ResponseUpdateUser(
      {this.id,
      this.email,
      this.sex,
      this.profilePicture,
      this.other,
      this.lastName,
      this.firstName,
      this.phone});

  ResponseUpdateUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    sex = json['sex'];
    profilePicture = json['profile_picture']!= null ?json['profile_picture']:'https://ssscompagnie.com/images/le_systeme/1.jpg';
    other = json['other'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['sex'] = this.sex;
    data['profile_picture'] = this.profilePicture;
    data['other'] = this.other;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    data['phone'] = this.phone;
    return data;
  }
}


class Other {
  Payments payments;

  Other({this.payments});

  Other.fromJson(Map<String, dynamic> json) {
    payments = json['payments'] != null
        ? new Payments.fromJson(json['payments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payments != null) {
      data['payments'] = this.payments.toJson();
    }
    return data;
  }
}

class Payments {
  Command742 command742;

  Payments({this.command742});

  Payments.fromJson(Map<String, dynamic> json) {
    command742 = json['command_742'] != null
        ? new Command742.fromJson(json['command_742'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.command742 != null) {
      data['command_742'] = this.command742.toJson();
    }
    return data;
  }
}

class Command742 {
  String processedAt;
  PaymentInfos paymentInfos;
  String paymentMode;
  String aPIProvider;

  Command742(
      {this.processedAt,
      this.paymentInfos,
      this.paymentMode,
      this.aPIProvider});

  Command742.fromJson(Map<String, dynamic> json) {
    processedAt = json['processed_at'];
    paymentInfos = json['payment_infos'] != null
        ? new PaymentInfos.fromJson(json['payment_infos'])
        : null;
    paymentMode = json['payment_mode'];
    aPIProvider = json['API Provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['processed_at'] = this.processedAt;
    if (this.paymentInfos != null) {
      data['payment_infos'] = this.paymentInfos.toJson();
    }
    data['payment_mode'] = this.paymentMode;
    data['API Provider'] = this.aPIProvider;
    return data;
  }
}

class PaymentInfos {
  Payments2 payments2;
  String paymentStatus;
  String lastPaymentDate;

  PaymentInfos({this.payments2, this.paymentStatus, this.lastPaymentDate});

  PaymentInfos.fromJson(Map<String, dynamic> json) {
    payments2 = json['payments'] != null
        ? new Payments2.fromJson(json['payments'])
        : null;
    paymentStatus = json['payment_status'];
    lastPaymentDate = json['last_payment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payments2 != null) {
      data['payments'] = this.payments2.toJson();
    }
    data['payment_status'] = this.paymentStatus;
    data['last_payment_date'] = this.lastPaymentDate;
    return data;
  }
}

class Payments2 {
  D0baca54B56b4961B306Be3a11b3491e d0baca54B56b4961B306Be3a11b3491e;

  Payments2({this.d0baca54B56b4961B306Be3a11b3491e});

  Payments2.fromJson(Map<String, dynamic> json) {
    d0baca54B56b4961B306Be3a11b3491e =
        json['d0baca54-b56b-4961-b306-be3a11b3491e'] != null
            ? new D0baca54B56b4961B306Be3a11b3491e.fromJson(
                json['d0baca54-b56b-4961-b306-be3a11b3491e'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.d0baca54B56b4961B306Be3a11b3491e != null) {
      data['d0baca54-b56b-4961-b306-be3a11b3491e'] =
          this.d0baca54B56b4961B306Be3a11b3491e.toJson();
    }
    return data;
  }
}

class D0baca54B56b4961B306Be3a11b3491e {
  bool success;
  String message;
  String redirect;
  Transaction transaction;
  String reference;
  String status;
  ProcessedAt processedAt;

  D0baca54B56b4961B306Be3a11b3491e(
      {this.success,
      this.message,
      this.redirect,
      this.transaction,
      this.reference,
      this.status,
      this.processedAt});

  D0baca54B56b4961B306Be3a11b3491e.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
    reference = json['reference'];
    status = json['status'];
    processedAt = json['processed_at'] != null
        ? new ProcessedAt.fromJson(json['processed_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['redirect'] = this.redirect;
    if (this.transaction != null) {
      data['transaction'] = this.transaction.toJson();
    }
    data['reference'] = this.reference;
    data['status'] = this.status;
    if (this.processedAt != null) {
      data['processed_at'] = this.processedAt.toJson();
    }
    return data;
  }
}

class Transaction {
  String pk;
  String status;
  String type;
  int amount;
  int fees;
  String bParty;
  String message;
  String service;
  String reference;
  String ts;
  int direction;

  Transaction(
      {this.pk,
      this.status,
      this.type,
      this.amount,
      this.fees,
      this.bParty,
      this.message,
      this.service,
      this.reference,
      this.ts,
      this.direction});

  Transaction.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    status = json['status'];
    type = json['type'];
    amount = json['amount'];
    fees = json['fees'];
    bParty = json['b_party'];
    message = json['message'];
    service = json['service'];
    reference = json['reference'];
    ts = json['ts'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['status'] = this.status;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['fees'] = this.fees;
    data['b_party'] = this.bParty;
    data['message'] = this.message;
    data['service'] = this.service;
    data['reference'] = this.reference;
    data['ts'] = this.ts;
    data['direction'] = this.direction;
    return data;
  }
}

class ProcessedAt {
  String date;
  int timezoneType;
  String timezone;

  ProcessedAt({this.date, this.timezoneType, this.timezone});

  ProcessedAt.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}
