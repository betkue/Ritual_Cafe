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
  String  complement;
  String date;
  String note;
  int idCommande;
  Commande(this.id,this.indexCollection,this.indexProduit,this.tag,this.nom,
  this.image,this.nombre,this.price,this.priceadd,this.prixTotal,
  this.varriantes,this.complement,this.date,this.note,this.idCommande);
}
class OptionalValue{
  String nom;
  bool etat;
  OptionalValue(this.nom,this.etat);
}
class VarrianteValue {
  String nom;
  bool choisi;
  String value;
  int nbrChoce;
  List<OptionalValue> options;
  VarrianteValue(this.nom,this.options,this.value,this.choisi,this.nbrChoce);

}