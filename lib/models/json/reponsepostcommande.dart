import 'dart:convert';
ReponsePostCommande ReponsePostCommandeFromJson(String str) => ReponsePostCommande.fromJson(json.decode(str));
String ReponsePostCommandeToJson(ReponsePostCommande data) => json.encode(data.toJson());

class ReponsePostCommande {

	int id;

	ReponsePostCommande({this.id});

	ReponsePostCommande.fromJson(Map<String, dynamic> json) {

		id = json['id'];
	
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		
		return data;
	}
}


