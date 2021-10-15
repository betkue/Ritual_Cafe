import 'dart:convert';
Commande CommandeFromJson(String str) => Commande.fromJson(json.decode(str));
String CommandeToJson(Commande data) => json.encode(data.toJson());

class Commande {
  int id;
  int indexCollection;
  int indexProduit;
  String nom;
  String image;
  List<VarrianteValue> varriantes;
  int price;
  int priceadd;
  int nombre;
  int prixTotal;
  String tag;
  String complement;
  String date;
  String note;
  int idCommande;
Commande(
      this.id,
      this.indexCollection,
      this.indexProduit,
      this.tag,
      this.nom,
      this.image,
      this.nombre,
      this.price,
      this.priceadd,
      this.prixTotal,
      this.varriantes,
      this.complement,
      this.date,
      this.note,
      this.idCommande);

  Commande.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indexCollection = json['indexCollection'];
    indexProduit = json['indexProduit'];
    nom = json['nom'];
    image = json['image'];
    if (json['varriantes'] != null) {
      varriantes = <VarrianteValue>[];
      json['varriantes'].forEach((v) {
        varriantes.add(new VarrianteValue.fromJson(v));
      });
    }
    price = json['price'];
    priceadd = json['priceadd'];
    nombre = json['nombre'];
    prixTotal = json['prixTotal'];
    tag = json['tag'];
    complement = json['complement'];
    date = json['date'];
    note = json['note'];
    idCommande = json['idCommande'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['indexCollection'] = this.indexCollection;
    data['indexProduit'] = this.indexProduit;
    data['nom'] = this.nom;
    data['image'] = this.image;
    if (this.varriantes != null) {
      data['varriantes'] = this.varriantes.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['priceadd'] = this.priceadd;
    data['nombre'] = this.nombre;
    data['prixTotal'] = this.prixTotal;
    data['tag'] = this.tag;
    data['complement'] = this.complement;
    data['date'] = this.date;
    data['note'] = this.note;
    data['idCommande'] = this.idCommande;
    return data;
  }
}

class VarrianteValue {
  String nom;
  bool choisi;
  String value;
  int nbrChoce;
  List<OptionalValue> options;

  VarrianteValue(this.nom, this.choisi, this.value, this.nbrChoce, this.options);

  VarrianteValue.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    choisi = json['choisi'];
    value = json['value'];
    nbrChoce = json['nbrChoce'];
    if (json['options'] != null) {
      options = <OptionalValue>[];
      json['options'].forEach((v) {
        options.add(new OptionalValue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['choisi'] = this.choisi;
    data['value'] = this.value;
    data['nbrChoce'] = this.nbrChoce;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionalValue {
  String nom;
  bool etat;

  OptionalValue(this.nom, this.etat);

  OptionalValue.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    etat = json['etat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['etat'] = this.etat;
    return data;
  }
}
