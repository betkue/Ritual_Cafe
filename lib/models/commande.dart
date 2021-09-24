class Commande {
  int id;
  int indexCollection;
  String nom;
  String image;
  List<VarrianteValue> varriantes;
  int price;
  int priceadd;
  int nombre;
  int prixTotal;
  String tag;
  Commande(this.id,this.indexCollection,this.tag,this.nom,this.image,this.nombre,this.price,this.priceadd,this.prixTotal,this.varriantes);
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
  List<OptionalValue> options;
  VarrianteValue(this.nom,this.options,this.value,this.choisi);

}