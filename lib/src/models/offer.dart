import 'dart:convert';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

String offerToJson(Offer data) => json.encode(data.toJson());

List<Offer> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Offer>((json) => Offer.fromJson(json)).toList();
}

class Offer {
  String offerId;
  String title;
  String type;
  String totalClaims;
  String countedClaims;
  String termsConditions;

  Offer({
    this.offerId,
    this.title,
    this.type,
    this.totalClaims,
    this.countedClaims,
    this.termsConditions,
  });

  factory Offer.fromJson(Map<dynamic, dynamic> json) => Offer(
        offerId: json["offer_id"],
        title: json["title"],
        type: json["type"],
        totalClaims: json["total_claims"],
        countedClaims: json["counted_claims"],
        termsConditions: json["terms_conditions"],
      );

  Map<dynamic, dynamic> toJson() => {
        "offer_id": offerId,
        "title": title,
        "type": type,
        "total_claims": totalClaims,
        "counted_claims": countedClaims,
        "terms_conditions": termsConditions,
      };
}
