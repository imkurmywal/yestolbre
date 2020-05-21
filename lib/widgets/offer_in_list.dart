import 'package:flutter/material.dart';
import 'package:yestolbre/src/merchnat_view.dart';
import 'package:yestolbre/src/models/merchnat.dart';
import 'package:yestolbre/src/view_coupon.dart';
import 'package:yestolbre/src/view_offer.dart';
import 'package:yestolbre/widgets/carousel.dart';

class OfferInList implements ListItem {
  Merchant merchant;
  int index;
  OfferInList({@required this.merchant, @required this.index});

  Widget buildCarousel(BuildContext context) => null;
  Widget buildOfferInList(BuildContext context) {
    return Container(
      // height: 170,
      margin: EdgeInsets.fromLTRB(10, 14, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
              merchant.offers[index - 1].imageUrl,
              width: 120,
              height: 100,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  merchant.offers[index - 1].title,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${merchant.offers[index - 1].offPercent} OFF",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewOffer(
                                  merchant: merchant,
                                  index: index - 1,
                                )));
                  },
                  child: Container(
                    width: 80,
                    height: 30,
                    child: Center(
                      child: Text(
                        "Claim",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    // padding: EdgeInsets.all(2),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
