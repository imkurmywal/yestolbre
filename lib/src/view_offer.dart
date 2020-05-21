import 'package:flutter/material.dart';
import 'package:yestolbre/src/models/merchnat.dart';
import 'package:yestolbre/src/view_coupon.dart';

class ViewOffer extends StatelessWidget {
  Merchant merchant;
  int index;
  ViewOffer({@required this.merchant, @required this.index});

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
                  merchant.offers[index].imageUrl,
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
                    "${merchant.offers[index].offPercent} OFF",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[200]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    merchant.offers[index].title,
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
                    "${merchant.name}\n${merchant.address}",
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
                    merchant.offers[index].termsConditions,
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
                        merchant.category,
                        style: TextStyle(color: Colors.blue[500], fontSize: 16),
                      ),
                    ],
                  )
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewCoupon(
                                merchant: merchant,
                                index: index,
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
