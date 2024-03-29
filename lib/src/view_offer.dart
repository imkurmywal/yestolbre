import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yestolbre/src/models/merchnat.dart';
import 'package:yestolbre/src/view_coupon.dart';

class ViewOffer extends StatefulWidget {
  Merchant merchant;
  int index;
  ViewOffer({@required this.merchant, @required this.index});
  @override
  _ViewOfferState createState() => _ViewOfferState();
}

class _ViewOfferState extends State<ViewOffer> {
  final ref = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    super.initState();
    listenToMerchant();
  }

  void countClaimNow() {
    ref
        .child(
            "merchants/${widget.merchant.merchantId}/offers/${widget.merchant.offers[widget.index].offerId}")
        .update({
      "counted_claims":
          "${int.parse(widget.merchant.offers[widget.index].countedClaims) + 1}",
    });
  }

  void listenToMerchant() async {
    ref
        .child("merchants/${widget.merchant.merchantId}")
        .onValue
        .listen((Event event) {
      if (event.snapshot.value == null) {
        return;
      }
      setState(() {
        widget.merchant = Merchant.fromJson(event.snapshot.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offer Details"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: FittedBox(
                child: Image.network(
                  widget.merchant.offers[widget.index].imageUrl,
                ),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.merchant.offers[widget.index].type == "free" ? "FREE" : widget.merchant.offers[widget.index].offPercent + " OFF"}",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[200]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.merchant.offers[widget.index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${widget.merchant.name}\n${widget.merchant.address}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(14, 10, 14, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.merchant.offers[widget.index].termsConditions,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Categories",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.merchant.category,
                        style: TextStyle(color: Colors.blue[500], fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "total claimed coupons".toUpperCase(),
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.merchant.offers[widget.index].countedClaims,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Center(
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                onPressed: () {
                  countClaimNow();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewCoupon(
                                merchant: widget.merchant,
                                index: widget.index,
                              )));
                },
                child: Container(
                  width: 160,
                  height: 30,
                  child: Center(
                    child: Text(
                      "CLAIM NOW",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  // padding: EdgeInsets.all(2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
