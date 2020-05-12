import 'package:flutter/material.dart';
import 'package:yestolbre/src/merchnat_view.dart';
import 'package:yestolbre/widgets/carousel.dart';

class OfferInList implements ListItem {
  Widget buildCarousel(BuildContext context) => null;
  Widget buildOfferInList(BuildContext context) {
    return Container(
      // height: 170,
      margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.red,
            width: 120,
            height: 100,
            child: FittedBox(
              child: Image.asset("assets/offer.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Offer title",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "5% OFF",
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
                onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
