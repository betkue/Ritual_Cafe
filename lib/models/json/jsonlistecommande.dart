import 'dart:convert';
JsonListeCommandes JsonListeCommandesFromJson(String str) => JsonListeCommandes.fromJson(json.decode(str));
String JsonListeCommandesToJson(JsonListeCommandes data) => json.encode(data.toJson());
class JsonListeCommandes {
	List<Data> data;
	Links links;
	Meta meta;

	JsonListeCommandes({this.data, this.links, this.meta});

	JsonListeCommandes.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = <Data>[];
			json['data'].forEach((v) { data.add(new Data.fromJson(v)); });
		}
		links = json['links'] != null ? new Links.fromJson(json['links']) : null;
		meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
		if (this.links != null) {
      data['links'] = this.links.toJson();
    }
		if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
		return data;
	}
}

class Data {
	int id;
	int montant;
	int clientId;
	String reductionId;
	String createdAt;
	String updatedAt;
	int entrepriseId;
	String shippingAddressId;
	int livraison;
	String shippingDate;
	String reference;
	String humanShippingDate;
	int shippingState;
	String shippingMode;
	String note;
	int paymentState;
	int state;
	String paymentMode;
	String paymentDate;
	String source;
	String deletedAt;
	Map datas;
	String subtotal;
	Client client;
	Restaurant restaurant;
	Restaurant company;
	String adresse;
	List<Null> addresses;
	List<Null> livreurs;
	List<Produits> produits;

	Data({this.id, this.montant, this.clientId, this.reductionId, this.createdAt, this.updatedAt, this.entrepriseId, this.shippingAddressId, this.livraison, this.shippingDate, this.reference, this.humanShippingDate, this.shippingState, this.shippingMode, this.note, this.paymentState, this.state, this.paymentMode, this.paymentDate, this.source, this.deletedAt, this.datas, this.subtotal, this.client, this.restaurant, this.company, this.adresse, this.addresses, this.livreurs, this.produits});

	Data.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		montant = json['montant'];
		clientId = json['client_id'];
		reductionId = json['reduction_id'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		entrepriseId = json['entreprise_id'];
		shippingAddressId = json['shipping_address_id'];
		livraison = json['livraison'];
		shippingDate = json['shipping_date'];
		reference = json['reference'];
		humanShippingDate = json['human_shipping_date'];
		shippingState = json['shipping_state'];
		shippingMode = json['shipping_mode'];
		note = json['note'];
		paymentState = json['payment_state'];
		state = json['state'];
		paymentMode = json['payment_mode'];
		paymentDate = json['payment_date'];
		source = json['source'];
		deletedAt = json['deleted_at'];
		datas = new Map();//!= null ? json['datas'] : 
		subtotal = json['subtotal']!= null ? json['subtotal']:"";
		client = json['client'] != null ? new Client.fromJson(json['client']) : null;
		restaurant = json['restaurant'] != null ? new Restaurant.fromJson(json['restaurant']) : null;
		company = json['company'] != null ? new Restaurant.fromJson(json['company']) : null;
		adresse = json['adresse'];
		if (json['addresses'] != null) {
			addresses = <Null>[];
			json['addresses'].forEach((v) { addresses.add(null.toString()); });
		}
		if (json['livreurs'] != null) {
			livreurs =<Null>[];
			json['livreurs'].forEach((v) { livreurs.add(null.toString()); });
		}
		if (json['produits'] != null) {
			produits = <Produits>[];
			json['produits'].forEach((v) { produits.add(new Produits.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['montant'] = this.montant;
		data['client_id'] = this.clientId;
		data['reduction_id'] = this.reductionId;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		data['entreprise_id'] = this.entrepriseId;
		data['shipping_address_id'] = this.shippingAddressId;
		data['livraison'] = this.livraison;
		data['shipping_date'] = this.shippingDate;
		data['reference'] = this.reference;
		data['human_shipping_date'] = this.humanShippingDate;
		data['shipping_state'] = this.shippingState;
		data['shipping_mode'] = this.shippingMode;
		data['note'] = this.note;
		data['payment_state'] = this.paymentState;
		data['state'] = this.state;
		data['payment_mode'] = this.paymentMode;
		data['payment_date'] = this.paymentDate;
		data['source'] = this.source;
		data['deleted_at'] = this.deletedAt;
		data['datas'] = this.datas;
		data['subtotal'] = this.subtotal;
		if (this.client != null) {
      data['client'] = this.client.toJson();
    }
		if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
		if (this.company != null) {
      data['company'] = this.company.toJson();
    }
		data['adresse'] = this.adresse;
		if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => null.toString()).toList();
    }
		if (this.livreurs != null) {
      data['livreurs'] = this.livreurs.map((v) => null.toString()).toList();
    }
		if (this.produits != null) {
      data['produits'] = this.produits.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Client {
	int id;
	String firstname;
	String surname;
	String email;
	String tel;
	String sex;
	String profilePicture;
	Null other;

	Client({this.id, this.firstname, this.surname, this.email, this.tel, this.sex, this.profilePicture, this.other});

	Client.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		firstname = json['firstname'];
		surname = json['surname'];
		email = json['email'];
		tel = json['tel'];
		sex = json['sex'];
		profilePicture = json['profile_picture'];
		other = json['other'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['firstname'] = this.firstname;
		data['surname'] = this.surname;
		data['email'] = this.email;
		data['tel'] = this.tel;
		data['sex'] = this.sex;
		data['profile_picture'] = this.profilePicture;
		data['other'] = this.other;
		return data;
	}
}

class Restaurant {
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
	List<Null> quartiers;
	List<Null> villes;

	Restaurant({this.id, this.nom, this.logo, this.contact, this.tel, this.slogan, this.website, this.slugExpress, this.etat, this.email, this.delaiLivraison, this.categorieEntrepriseId, this.description, this.createdAt, this.updatedAt, this.viewId, this.devise, this.tarifLivraison, this.datas, this.villeId, this.quartiers, this.villes});

	Restaurant.fromJson(Map<String, dynamic> json) {
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
		if (json['quartiers'] != null) {
			quartiers =<Null>[];
			json['quartiers'].forEach((v) { quartiers.add(null.toString()); });
		}
		if (json['villes'] != null) {
			villes = <Null>[];
			json['villes'].forEach((v) { villes.add(null.toString()); });
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
		if (this.quartiers != null) {
      data['quartiers'] = this.quartiers.map((v) => null.toString()).toList();
    }
		if (this.villes != null) {
      data['villes'] = this.villes.map((v) =>null.toString()).toList();
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
	Registration registration;

	Datas2({this.registration});

	Datas2.fromJson(Map<String, dynamic> json) {
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
	Null submit;

	Registration({this.tel, this.name, this.email, this.steps, this.fFlash, this.sToken, this.step2, this.step3, this.currency, this.password, this.pPrevious, this.lastName, this.lastStep, this.firstName, this.description, this.alreadySell, this.companySize, this.tarifLivraison, this.companyCategory, this.submit});

	Registration.fromJson(Map<String, dynamic> json) {
		tel = json['tel'];
		name = json['name'];
		email = json['email'];
		steps = json['steps'];
		fFlash = json['_flash'] != null ? new Flash.fromJson(json['_flash']) : null;
		sToken = json['_token'];
		step2 = json['step_2'];
		step3 = json['step_3'];
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
		submit = json['submit'];
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
		data['submit'] = this.submit;
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
			old = <Null>[];
			json['old'].forEach((v) { old.add(null.toString()); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.news != null) {
      data['new'] = this.news.map((v) => null.toString()).toList();
    }
		if (this.old != null) {
      data['old'] = this.old.map((v) => null.toString()).toList();
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

class Produits {
	int id;
	String name;
	String description;
	int stocks;
	int tempsPreparation;
	int editable;
	int available;
	int infiniteStocks;
	int comparaisonPrice;
	int price;
	int entrepriseId;
	String createdAt;
	String updatedAt;
	String slug;
	String code;
	Pivot pivot;

	Produits({this.id, this.name, this.description, this.stocks, this.tempsPreparation, this.editable, this.available, this.infiniteStocks, this.comparaisonPrice, this.price, this.entrepriseId, this.createdAt, this.updatedAt, this.slug, this.code, this.pivot});

	Produits.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		description = json['description'];
		stocks = json['stocks'];
		tempsPreparation = json['temps_preparation'];
		editable = json['editable'];
		available = json['available'];
		infiniteStocks = json['infiniteStocks'];
		comparaisonPrice = json['comparaison_price'];
		price = json['price'];
		entrepriseId = json['entreprise_id'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		slug = json['slug'];
		code = json['code'];
		pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['description'] = this.description;
		data['stocks'] = this.stocks;
		data['temps_preparation'] = this.tempsPreparation;
		data['editable'] = this.editable;
		data['available'] = this.available;
		data['infiniteStocks'] = this.infiniteStocks;
		data['comparaison_price'] = this.comparaisonPrice;
		data['price'] = this.price;
		data['entreprise_id'] = this.entrepriseId;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		data['slug'] = this.slug;
		data['code'] = this.code;
		if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
		return data;
	}
}

class Pivot {
	int commandId;
	int productId;
	int id;
	int prix;
	int quantite;
	String dateCommande;
	String properties;

	Pivot({this.commandId, this.productId, this.id, this.prix, this.quantite, this.dateCommande, this.properties});

	Pivot.fromJson(Map<String, dynamic> json) {
		commandId = json['command_id'];
		productId = json['product_id'];
		id = json['id'];
		prix = json['prix'];
		quantite = json['quantite'];
		dateCommande = json['date_commande'];
		properties = json['properties'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['command_id'] = this.commandId;
		data['product_id'] = this.productId;
		data['id'] = this.id;
		data['prix'] = this.prix;
		data['quantite'] = this.quantite;
		data['date_commande'] = this.dateCommande;
		data['properties'] = this.properties;
		return data;
	}
}

class Links {
	String first;
	String last;
	String prev;
	String next;

	Links({this.first, this.last, this.prev, this.next});

	Links.fromJson(Map<String, dynamic> json) {
		first = json['first'];
		last = json['last'];
		prev = json['prev'];
		next = json['next'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['first'] = this.first;
		data['last'] = this.last;
		data['prev'] = this.prev;
		data['next'] = this.next;
		return data;
	}
}

class Meta {
	int currentPage;
	int from;
	int lastPage;
	String path;
	int perPage;
	int to;
	int total;

	Meta({this.currentPage, this.from, this.lastPage, this.path, this.perPage, this.to, this.total});

	Meta.fromJson(Map<String, dynamic> json) {
		currentPage = json['current_page'];
		from = json['from'];
		lastPage = json['last_page'];
		path = json['path'];
		perPage = json['per_page'];
		to = json['to'];
		total = json['total'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['current_page'] = this.currentPage;
		data['from'] = this.from;
		data['last_page'] = this.lastPage;
		data['path'] = this.path;
		data['per_page'] = this.perPage;
		data['to'] = this.to;
		data['total'] = this.total;
		return data;
	}
}

class Data2 {
	int id;
	int montant;
	int clientId;
	Null reductionId;
	String createdAt;
	String updatedAt;
	int entrepriseId;
	Null shippingAddressId;
	int livraison;
	String shippingDate;
	String reference;
	String humanShippingDate;
	int shippingState;
	String shippingMode;
	String note;
	int paymentState;
	int state;
	String paymentMode;
	String paymentDate;
	String source;
	String deletedAt;
	String datas;
	String subtotal;
	Client client;
	Restaurant restaurant;
	Restaurant company;
	String adresse;
	List<Null> addresses;
	List<Null> livreurs;
	List<Produits> produits;

	Data2({this.id, this.montant, this.clientId, this.reductionId, this.createdAt, this.updatedAt, this.entrepriseId, this.shippingAddressId, this.livraison, this.shippingDate, this.reference, this.humanShippingDate, this.shippingState, this.shippingMode, this.note, this.paymentState, this.state, this.paymentMode, this.paymentDate, this.source, this.deletedAt, this.datas, this.subtotal, this.client, this.restaurant, this.company, this.adresse, this.addresses, this.livreurs, this.produits});

	Data2.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		montant = json['montant'];
		clientId = json['client_id'];
		reductionId = json['reduction_id'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		entrepriseId = json['entreprise_id'];
		shippingAddressId = json['shipping_address_id'];
		livraison = json['livraison'];
		shippingDate = json['shipping_date'];
		reference = json['reference'];
		humanShippingDate = json['human_shipping_date'];
		shippingState = json['shipping_state'];
		shippingMode = json['shipping_mode'];
		note = json['note'];
		paymentState = json['payment_state'];
		state = json['state'];
		paymentMode = json['payment_mode'];
		paymentDate = json['payment_date'];
		source = json['source'];
		deletedAt = json['deleted_at'];
		datas = json['datas'];
		subtotal = json['subtotal'];
		client = json['client'] != null ? new Client.fromJson(json['client']) : null;
		restaurant = json['restaurant'] != null ? new Restaurant.fromJson(json['restaurant']) : null;
		company = json['company'] != null ? new Restaurant.fromJson(json['company']) : null;
		adresse = json['adresse'];
		if (json['addresses'] != null) {
			addresses = <Null>[];
			json['addresses'].forEach((v) { addresses.add(null.toString()); });
		}
		if (json['livreurs'] != null) {
			livreurs = <Null>[];
			json['livreurs'].forEach((v) { livreurs.add(null.toString()); });
		}
		if (json['produits'] != null) {
			produits = <Produits>[];
			json['produits'].forEach((v) { produits.add(new Produits.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['montant'] = this.montant;
		data['client_id'] = this.clientId;
		data['reduction_id'] = this.reductionId;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		data['entreprise_id'] = this.entrepriseId;
		data['shipping_address_id'] = this.shippingAddressId;
		data['livraison'] = this.livraison;
		data['shipping_date'] = this.shippingDate;
		data['reference'] = this.reference;
		data['human_shipping_date'] = this.humanShippingDate;
		data['shipping_state'] = this.shippingState;
		data['shipping_mode'] = this.shippingMode;
		data['note'] = this.note;
		data['payment_state'] = this.paymentState;
		data['state'] = this.state;
		data['payment_mode'] = this.paymentMode;
		data['payment_date'] = this.paymentDate;
		data['source'] = this.source;
		data['deleted_at'] = this.deletedAt;
		data['datas'] = this.datas;
		data['subtotal'] = this.subtotal;
		if (this.client != null) {
      data['client'] = this.client.toJson();
    }
		if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
		if (this.company != null) {
      data['company'] = this.company.toJson();
    }
		data['adresse'] = this.adresse;
		if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => null.toString()).toList();
    }
		if (this.livreurs != null) {
      data['livreurs'] = this.livreurs.map((v) =>null.toString()).toList();
    }
		if (this.produits != null) {
      data['produits'] = this.produits.map((v) => v.toJson()).toList();
    }
		return data;
	}
}
