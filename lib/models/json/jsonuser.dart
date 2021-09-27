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
  int id;
  String firstname;
  String surname;
  String email;
  String tel;
  String sex;
  String birthDate;
  String profilePicture;
  int phoneVerified;
  Other other;
  String createdAt;
  String updatedAt;
  String stripeId;
  String cardBrand;
  String cardLastFour;
  String trialEndsAt;

  Use(
      {this.id,
      this.firstname,
      this.surname,
      this.email,
      this.tel,
      this.sex,
      this.birthDate,
      this.profilePicture,
      this.phoneVerified,
      this.other,
      this.createdAt,
      this.updatedAt,
      this.stripeId,
      this.cardBrand,
      this.cardLastFour,
      this.trialEndsAt});

  Use.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    surname = json['surname'];
    email = json['email'];
    tel = json['tel'];
    sex = json['sex'];
    birthDate = json['birth_date'];
    profilePicture = json['profile_picture'];
    phoneVerified = json['phone_verified'];
    other = json['other'] != null ? new Other.fromJson(json['other']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    cardBrand = json['card_brand'];
    cardLastFour = json['card_last_four'];
    trialEndsAt = json['trial_ends_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['tel'] = this.tel;
    data['sex'] = this.sex;
    data['birth_date'] = this.birthDate;
    data['profile_picture'] = this.profilePicture;
    data['phone_verified'] = this.phoneVerified;
    if (this.other != null) {
      data['other'] = this.other.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stripe_id'] = this.stripeId;
    data['card_brand'] = this.cardBrand;
    data['card_last_four'] = this.cardLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
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
