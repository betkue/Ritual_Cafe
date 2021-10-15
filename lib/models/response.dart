

import 'dart:convert';

ResponseSend ResponseSendFromJson(String str) => ResponseSend.fromJson(json.decode(str));
String ResponseSendToJson(ResponseSend data) => json.encode(data.toJson());
class ResponseSend {
	  bool etat;
  String message;

	ResponseSend(this.etat, this.message);

	ResponseSend.fromJson(Map<String, dynamic> json) {
		etat =json['etat'];
		message = json['detail'].toString();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['etat'] = this.etat;
		data['message'] = this.message;
		return data;
	}
}