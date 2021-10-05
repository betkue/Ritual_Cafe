// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
Company jsonCompanyFromJson(String str) => Company.fromJson(json.decode(str));
String jsonCompanyToJson(Company data) => json.encode(data.toJson());
class Company {
	int id;
	String nom;
	Null logo;
	String contact;
	String tel;
	Null slogan;
	Null website;
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
	Datas datas;
	Null villeId;
	String name;
	List<Null> reviews;
	List<Null> discounts;
	List<Null> medias;

	Company({this.id, this.nom, this.logo, this.contact, this.tel, this.slogan, this.website, this.slugExpress, this.etat, this.email, this.delaiLivraison, this.categorieEntrepriseId, this.description, this.createdAt, this.updatedAt, this.viewId, this.devise, this.tarifLivraison, this.datas, this.villeId, this.name, this.reviews, this.discounts, this.medias});

	Company.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		nom = json['nom'];
		logo = json['logo'];
		contact = json['contact'];
		tel = json['tel'];
		slogan = json['slogan'];
		website = json['website'];
		slugExpress = json['slug_express'];
		etat = json['etat'];
		email = json['email'];
		delaiLivraison = json['delai_livraison'];
		categorieEntrepriseId = json['categorie_entreprise_id'];
		description = json['description'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		viewId = json['view_id'];
		devise = json['devise'] != null ? new Devise.fromJson(json['devise']) : null;
		tarifLivraison = json['tarif_livraison'];
		datas = json['datas'] != null ? new Datas.fromJson(json['datas']) : null;
		villeId = json['ville_id'];
		name = json['name'];
		if (json['reviews'] != null) {
			reviews = <Null> [];
			json['reviews'].forEach((v) { reviews.add(null.toString()); });
		}
		if (json['discounts'] != null) {
			discounts = <Null> [];
			json['discounts'].forEach((v) { discounts.add(null.toString()); });
		}
		if (json['medias'] != null) {
			medias =  <Null> [];
			json['medias'].forEach((v) { medias.add(null.toString()); });
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
		if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => 'null');
    }
		if (this.discounts != null) {
      data['discounts'] = this.discounts.map((v) => 'null');
    }
		if (this.medias != null) {
      data['medias'] = this.medias.map((v) => 'null');
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
		createdAt = json['created_at'];
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

class Data {
	String state;

	Data({this.state});

	Data.fromJson(Map<String, dynamic> json) {
		state = json['state'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['state'] = this.state;
		return data;
	}
}

class Datas {
	Registration registration;

	Datas({this.registration});

	Datas.fromJson(Map<String, dynamic> json) {
		registration = json['registration'] != null ? new Registration.fromJson(json['registration']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.registration != null) {
      data['registration'] = this.registration.toJson();
    }
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
	Null submit;
	String currency;
	String password;
	Previous pPrevious;
	String lastName;
	String lastStep;
	String firstName;
	String description;
	String alreadySell;
	String companySize;
	String tarifLivraison;
	String companyCategory;

	Registration({this.tel, this.name, this.email, this.steps, this.fFlash, this.sToken, this.step2, this.step3, this.submit, this.currency, this.password, this.pPrevious, this.lastName, this.lastStep, this.firstName, this.description, this.alreadySell, this.companySize, this.tarifLivraison, this.companyCategory});

	Registration.fromJson(Map<String, dynamic> json) {
		tel = json['tel'];
		name = json['name'];
		email = json['email'];
		steps = json['steps'];
		fFlash = json['_flash'] != null ? new Flash.fromJson(json['_flash']) : null;
		sToken = json['_token'];
		step2 = json['step_2'];
		step3 = json['step_3'];
		submit = json['submit'];
		currency = json['currency'];
		password = json['password'];
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
		data['submit'] = this.submit;
		data['currency'] = this.currency;
		data['password'] = this.password;
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
  
	List<Null> news;
	List<Null> old;

	Flash({this.news, this.old});

	Flash.fromJson(Map<String, dynamic> json) {
		if (json['new'] != null) {
			news = <Null>[];
			json['new'].forEach((v) { news.add(null.toString()); });
		}
		if (json['old'] != null) {
			old =  <Null>[];
			json['old'].forEach((v) { old.add(null.toString()); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.news != null) {
      data['new'] = this.news.map((v) => 'null').toList();
    }
		if (this.old != null) {
      data['old'] = this.old.map((v) =>'null').toList();
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
