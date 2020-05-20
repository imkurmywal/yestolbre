import 'dart:convert';

import 'package:yestolbre/src/models/offer.dart';

Merchant merchantFromJson(String str) => Merchant.fromJson(json.decode(str));

String merchantToJson(Merchant data) => json.encode(data.toJson());

class Merchant {
  String merchantId;
  String name;
  String category;
  String address;
  String logoUrl;
  String phoneNumber;
  String latitude;
  String longitude;
  String fbUrl;
  Map<String, Offer> offers;
  Merchant({
    this.merchantId,
    this.name,
    this.category,
    this.address,
    this.logoUrl,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.fbUrl,
    this.offers,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        merchantId: json["merchant_id"],
        name: json["name"],
        category: json["category"],
        address: json["address"],
        logoUrl: json["logo_url"],
        phoneNumber: json["phone_number"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        fbUrl: json["fb_url"],
        offers: Map.from(json["offers"])
            .map((k, v) => MapEntry<String, Offer>(k, Offer.fromJson(v))),
      );
  Map<String, dynamic> toJson() => {
        "merchant_id": merchantId,
        "name": name,
        "category": category,
        "address": address,
        "logo_url": logoUrl,
        "phone_number": phoneNumber,
        "latitude": latitude,
        "longitude": longitude,
        "fb_url": fbUrl,
        "offers": Map.from(offers)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}
