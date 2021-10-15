// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

Company jsonCompanyFromJson(String str) => Company.fromJson(json.decode(str));
String jsonCompanyToJson(Company data) => json.encode(data.toJson());
class Company {
	int id;
	String nom;
	String logo;
	String contact;
	String tel;
	String slogan;
	String website;
	String slugExpress;
	int etat;
	String email;
	Null delaiLivraison;
	int categorieEntrepriseId;
	String description;
	String createdAt;
	String updatedAt;
	String viewId;
	Devise devise;
	String tarifLivraison;
	Datas2 datas;
	String villeId;
	String name;
	int lowestPrice;
	List<Map> reviews;
	List<Map> discounts;
	List<Map> medias;

	Company({this.id, this.nom, this.logo, this.contact, this.tel, this.slogan, this.website, this.slugExpress, this.etat, this.email, this.delaiLivraison, this.categorieEntrepriseId, this.description, this.createdAt, this.updatedAt, this.viewId, this.devise, this.tarifLivraison, this.datas, this.villeId, this.name, this.lowestPrice, this.reviews, this.discounts, this.medias});

	Company.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		nom = json['nom'];
		logo = json['logo'] != null?json['logo']:"";
		contact = json['contact'];
		tel = json['tel'];
		slogan = json['slogan'] != null?json['slogan']:"";
		website = json['website'] != null?json['website']:"";
		slugExpress = json['slug_express'];
		etat = json['etat'];
		email = json['email'];
		delaiLivraison = null;//json['delai_livraison'];
		categorieEntrepriseId = json['categorie_entreprise_id'];
		description = json['description'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		viewId = json['view_id'];
		devise = json['devise'] != null ? new Devise.fromJson(json['devise']) : null;
		tarifLivraison = json['tarif_livraison'];
		datas = json['datas'] != null ? new Datas2.fromJson(json['datas']) : null;
		villeId = json['ville_id']!= null  ?json['ville_id'].toString():json['ville_id'].toString();
		name = json['name'];
		lowestPrice = json['lowest_price'];
		if (json['reviews'] != null) {
			reviews = <Map>[];
			json['reviews'].forEach((v) { reviews.add(new Map()); });
		}
		if (json['discounts'] != null) {
			discounts =<Map>[];
			json['discounts'].forEach((v) { discounts.add(new Map()); });
		}
		if (json['medias'] != null) {
			medias =   <Map>[];
			json['medias'].forEach((v) { medias.add(new Map()); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['nom'] = this.nom;
		data['logo'] = this.logo;
		data['contact'] = this.contact;
		data['tel'] = this.tel;
		data['slogan'] = this.slogan;
		data['website'] = this.website;
		data['slug_express'] = this.slugExpress;
		data['etat'] = this.etat;
		data['email'] = this.email;
		data['delai_livraison'] = this.delaiLivraison;
		data['categorie_entreprise_id'] = this.categorieEntrepriseId;
		data['description'] = this.description;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		data['view_id'] = this.viewId;
		if (this.devise != null) {
      data['devise'] = this.devise.toJson();
    }
		data['tarif_livraison'] = this.tarifLivraison;
		if (this.datas != null) {
      data['datas'] = this.datas.toJson();
    }
		data['ville_id'] = this.villeId;
		data['name'] = this.name;
		data['lowest_price'] = this.lowestPrice;
		if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v).toList();
    }
		if (this.discounts != null) {
      data['discounts'] = this.discounts.map((v) => v).toList();
    }
		if (this.medias != null) {
      data['medias'] = this.medias.map((v) => v).toList();
    }
		return data;
	}
}

class Devise {
	int id;
	String name;
	String code;
	String symbol;
	Datas datas;
	Null createdAt;
	String updatedAt;

	Devise({this.id, this.name, this.code, this.symbol, this.datas, this.createdAt, this.updatedAt});

	Devise.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		code = json['code'];
		symbol = json['symbol'];
		datas = json['datas'] != null ? new Datas.fromJson(json['datas']) : null;
		createdAt = null;//json['created_at'];
		updatedAt = json['updated_at'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['code'] = this.code;
		data['symbol'] = this.symbol;
		if (this.datas != null) {
      data['datas'] = this.datas.toJson();
    }
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		return data;
	}
}

class Datas {
	String state;

	Datas({this.state});

	Datas.fromJson(Map<String, dynamic> json) {
		state = json['state'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['state'] = this.state;
		return data;
	}
}

class Datas2 {
	Payments payments;
	Accounting accounting;
	Registration registration;

	Datas2({this.payments, this.accounting, this.registration});

	Datas2.fromJson(Map<String, dynamic> json) {
		payments = json['payments'] != null ? new Payments.fromJson(json['payments']) : null;
		accounting = json['accounting'] != null ? new Accounting.fromJson(json['accounting']) : null;
		registration = json['registration'] != null ? new Registration.fromJson(json['registration']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.payments != null) {
      data['payments'] = this.payments.toJson();
    }
		if (this.accounting != null) {
      data['accounting'] = this.accounting.toJson();
    }
		if (this.registration != null) {
      data['registration'] = this.registration.toJson();
    }
		return data;
	}
}

class Payments {
	Cash cash;
	Paypal paypal;
	Mobilemoney mobilemoney;
  Card card;

	Payments({this.cash, this.paypal, this.mobilemoney,this.card});

	Payments.fromJson(Map<String, dynamic> json) {
		cash = json['cash'] != null ? new Cash.fromJson(json['cash']) : null;
		paypal = json['paypal'] != null ? new Paypal.fromJson(json['paypal']) : null;
		mobilemoney = json['mobilemoney'] != null ? new Mobilemoney.fromJson(json['mobilemoney']) : null;
		card = json['card'] != null ? new Card.fromJson(json['card']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.cash != null) {
      data['cash'] = this.cash.toJson();
    }
		if (this.paypal != null) {
      data['paypal'] = this.paypal.toJson();
    }
		if (this.mobilemoney != null) {
      data['mobilemoney'] = this.mobilemoney.toJson();
    }
		if (this.card != null) {
      data['card'] = this.card.toJson();
    }
		return data;
	}
}

class Cash {
	bool accept;
	String fullName;

	Cash({this.accept, this.fullName});

	Cash.fromJson(Map<String, dynamic> json) {
		accept = json['accept'];
		fullName = json['full_name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['accept'] = this.accept;
		data['full_name'] = this.fullName;
		return data;
	}
}
class Card {
	bool accept;
	String fullName;

	Card({this.accept, this.fullName});

	Card.fromJson(Map<String, dynamic> json) {
		accept = json['accept'];
		fullName = json['full_name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['accept'] = this.accept;
		data['full_name'] = this.fullName;
		return data;
	}
}

class Paypal {
	String link;
	bool accept;
	String fullName;

	Paypal({this.link, this.accept, this.fullName});

	Paypal.fromJson(Map<String, dynamic> json) {
		link = json['link'];
		accept = json['accept'];
		fullName = json['full_name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['link'] = this.link;
		data['accept'] = this.accept;
		data['full_name'] = this.fullName;
		return data;
	}
}

class Mobilemoney {
	String phone;
	bool accept;
	String fullName;

	Mobilemoney({this.phone, this.accept, this.fullName});

	Mobilemoney.fromJson(Map<String, dynamic> json) {
		phone = json['phone'];
		accept = json['accept'];
		fullName = json['full_name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['phone'] = this.phone;
		data['accept'] = this.accept;
		data['full_name'] = this.fullName;
		return data;
	}
}

class Accounting {
	int removed;
	int remained;
	int generated;

	Accounting({this.removed, this.remained, this.generated});

	Accounting.fromJson(Map<String, dynamic> json) {
		removed = json['removed'];
		remained = json['remained'];
		generated = json['generated'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['removed'] = this.removed;
		data['remained'] = this.remained;
		data['generated'] = this.generated;
		return data;
	}
}

class Registration {
	String tel;
	String name;
	String email;
	String steps;
	Flash fFlash;
	String sToken;
	Null step2;
	Null step3;
	String currency;
	Previous pPrevious;
	String lastName;
	String lastStep;
	String firstName;
	String description;
	String alreadySell;
	String companySize;
	String tarifLivraison;
	String companyCategory;

	Registration({this.tel, this.name, this.email, this.steps, this.fFlash, this.sToken, this.step2, this.step3, this.currency, this.pPrevious, this.lastName, this.lastStep, this.firstName, this.description, this.alreadySell, this.companySize, this.tarifLivraison, this.companyCategory});

	Registration.fromJson(Map<String, dynamic> json) {
		tel = json['tel'];
		name = json['name'];
		email = json['email'];
		steps = json['steps'];
		fFlash = json['_flash'] != null ? new Flash.fromJson(json['_flash']) : null;
		sToken = json['_token'];
		step2 = null;//json['step_2'];
		step3 = null;//json['step_3'];
		currency = json['currency'];
		pPrevious = json['_previous'] != null ? new Previous.fromJson(json['_previous']) : null;
		lastName = json['last_name'];
		lastStep = json['last_step'];
		firstName = json['first_name'];
		description = json['description'];
		alreadySell = json['already_sell'];
		companySize = json['company_size'];
		tarifLivraison = json['tarif_livraison'];
		companyCategory = json['company_category'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['tel'] = this.tel;
		data['name'] = this.name;
		data['email'] = this.email;
		data['steps'] = this.steps;
		if (this.fFlash != null) {
      data['_flash'] = this.fFlash.toJson();
    }
		data['_token'] = this.sToken;
		data['step_2'] = this.step2;
		data['step_3'] = this.step3;
		data['currency'] = this.currency;
		if (this.pPrevious != null) {
      data['_previous'] = this.pPrevious.toJson();
    }
		data['last_name'] = this.lastName;
		data['last_step'] = this.lastStep;
		data['first_name'] = this.firstName;
		data['description'] = this.description;
		data['already_sell'] = this.alreadySell;
		data['company_size'] = this.companySize;
		data['tarif_livraison'] = this.tarifLivraison;
		data['company_category'] = this.companyCategory;
		return data;
	}
}

class Flash {
	List<Map> news;
	List<Map> old;

	Flash({this.news, this.old});

	Flash.fromJson(Map<String, dynamic> json) {
		if (json['new'] != null) {
			news = <Map>[];
			json['new'].forEach((v) { news.add(new Map()); });
		}
		if (json['old'] != null) {
			old = <Map>[];
			json['old'].forEach((v) { old.add(new Map()); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.news != null) {
      data['new'] = this.news.map((v) => v).toList();
    }
		if (this.old != null) {
      data['old'] = this.old.map((v) => v).toList();
    }
		return data;
	}
}

class Previous {
	String url;

	Previous({this.url});

	Previous.fromJson(Map<String, dynamic> json) {
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['url'] = this.url;
		return data;
	}
}
