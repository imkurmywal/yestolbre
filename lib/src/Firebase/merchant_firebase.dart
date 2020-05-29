import 'package:firebase_database/firebase_database.dart';
import 'package:yestolbre/src/models/merchnat.dart';
import 'dart:async';

// client added furthor requirements so I have to add this classs.
class MerchantDB {
  static MerchantDB shared = MerchantDB();
  final ref = FirebaseDatabase.instance.reference();
  getMerchants({Function fetched}) {
    List<Merchant> allMerchants = new List<Merchant>();
    ref.child("merchants").onValue.listen((Event event) {
      for (Map<dynamic, dynamic> value in event.snapshot.value.values) {
        allMerchants.add(new Merchant.fromJson(value));
      }
      fetched(allMerchants);
    });
  }
}
