/*
* import 'dart:convert';
CollectionsJson CollectionsJsonFromJson(String str) => CollectionsJson.fromJson(json.decode(str));
String CollectionsJsonToJson(CollectionsJson data) => json.encode(data.toJson());
class CollectionsJson {
  List<Data> data;
  Links links;
  Meta meta;

  CollectionsJson({this.data, this.links, this.meta});

  CollectionsJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
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
  String name;
  Null description;
  int entrepriseId;
  Null parentCollectionId;
  String createdAt;
  String updatedAt;
  List<Produits> produits;
  List<Mediasdata> medias;
  Null parent;

  Data(
      {this.id,
        this.name,
        this.description,
        this.entrepriseId,
        this.parentCollectionId,
        this.createdAt,
        this.updatedAt,
        this.produits,
        this.medias,
        this.parent});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    entrepriseId = json['entreprise_id'];
    parentCollectionId = json['parent_collection_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['produits'] != null) {
      produits = new List<Produits>();
      json['produits'].forEach((v) {
        produits.add(new Produits.fromJson(v));
      });
    }
    if (json['medias'] != null) {
      medias = <Mediasdata>[];
      json['medias'].forEach((v) {
        medias.add(new Mediasdata.fromJson(v));
      });
    }
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['entreprise_id'] = this.entrepriseId;
    data['parent_collection_id'] = this.parentCollectionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.produits != null) {
      data['produits'] = this.produits.map((v) => v.toJson()).toList();
    }
    if (this.medias != null) {
      data['medias'] = this.medias.map((v) => v.toJson()).toList();
    }
    data['parent'] = this.parent;
    return data;
  }
}
class Mediasdata {
  Null media;

  Mediasdata( {this.media});

  Mediasdata.fromJson(Map<String, dynamic> json) {
    media = json['medias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medias'] = this.media;
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
  List<Medias> medias;
  List<Tags> tags;
  List<String> collections;
  List<Variants> variants;
  List<Avis> avis;

  Produits(
      {this.id,
        this.name,
        this.description,
        this.stocks,
        this.tempsPreparation,
        this.editable,
        this.available,
        this.infiniteStocks,
        this.comparaisonPrice,
        this.price,
        this.entrepriseId,
        this.createdAt,
        this.updatedAt,
        this.slug,
        this.code,
        this.pivot,
        this.medias,
        this.tags,
        this.collections,
        this.variants,
        this.avis});

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
    if (json['medias'] != null) {
      medias = <Medias>[];
      json['medias'].forEach((v) {
        medias.add(new Medias.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    collections = json['collections'].cast<String>();
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
      });
    }
    if (json['avis'] != null) {
      avis = <Avis>[];
      json['avis'].forEach((v) {
        avis.add( new Avis.fromJson(v));
      });
    }
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
    if (this.medias != null) {
      data['medias'] = this.medias.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['collections'] = this.collections;
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    if (this.avis != null) {
      data['avis'] = this.avis.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int collectionId;
  int productId;

  Pivot({this.collectionId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    collectionId = json['collection_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collection_id'] = this.collectionId;
    data['product_id'] = this.productId;
    return data;
  }
}

class Medias {
  String link;
  String collectionName;
  Collection collection;
  String thumb;

  Medias({this.link, this.collectionName, this.collection, this.thumb});

  Medias.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    collectionName = json['collection_name'];
    collection = json['collection'] != null
        ? new Collection.fromJson(json['collection'])
        : null;
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['collection_name'] = this.collectionName;
    if (this.collection != null) {
      data['collection'] = this.collection.toJson();
    }
    data['thumb'] = this.thumb;
    return data;
  }
}

class Collection {
  int id;
  String name;
  Null description;
  int entrepriseId;
  String createdAt;
  String updatedAt;

  Collection(
      {this.id,
        this.name,
        this.description,
        this.entrepriseId,
        this.createdAt,
        this.updatedAt});

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    entrepriseId = json['entreprise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['entreprise_id'] = this.entrepriseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Tags {
  int id;
  String name;
  Null description;
  String createdAt;
  String updatedAt;
  Null slug;
  int orderColumn;
  Null type;
  PivotTags pivot;

  Tags(
      {this.id,
        this.name,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.slug,
        this.orderColumn,
        this.type,
        this.pivot});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    orderColumn = json['order_column'];
    type = json['type'];
    pivot = json['pivot'] != null ? new PivotTags.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slug'] = this.slug;
    data['order_column'] = this.orderColumn;
    data['type'] = this.type;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class PivotTags {
  int productId;
  int tagId;

  PivotTags({this.productId, this.tagId});

  PivotTags.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    tagId = json['tag_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['tag_id'] = this.tagId;
    return data;
  }
}

class Variants {
  String name;
  String slug;
  List<Options> options;
  bool required;
  String description;
  int maxChoices;

  Variants(
      {this.name,
        this.slug,
        this.options,
        this.required,
        this.description,
        this.maxChoices});

  Variants.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    if (json['options'] != null) {
      options =  <Options>[];
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    required = json['required'];
    description = json['description'];
    maxChoices = json['max_choices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    data['required'] = this.required;
    data['description'] = this.description;
    data['max_choices'] = this.maxChoices;
    return data;
  }
}

class Avis {
  Null avis;

  Avis( {this.avis});

  Avis.fromJson(Map<String, dynamic> json) {
    avis = json['avis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avis'] = this.avis;
    return data;
  }
}

class Options {
  int id;
  String name;
  int price;
  String description;
  int additionnalFee;

  Options(
      {this.id, this.name, this.price, this.description, this.additionnalFee});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    additionnalFee = json['additionnal_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['additionnal_fee'] = this.additionnalFee;
    return data;
  }
}

class Links {
  String first;
  String last;
  Null prev;
  Null next;

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

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

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

* */