import 'package:flutter/material.dart';

class ViewOffer extends StatelessWidget {
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
                child: Image.asset("assets/offer.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "20% OFF",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[200]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "For every purchase of American breakfast",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Merchant Name and Address",
                  style: TextStyle(
                    color: Colors.blue[500],
                    fontSize: 17,
                  ),
                ),
              ],
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
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec dui augue. Aliquam erat volutpat. Nullam velit massa, euismod vel eros in, mattis faucibus eros. Ut dignissim.",
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
                        "Categories, Restaurant",
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
                onPressed: () {},
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
