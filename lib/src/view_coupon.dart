import 'package:flutter/material.dart';

class ViewCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupon"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(14, 20, 14, 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              "Your Promo Code",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey[500],
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Theme.of(context).primaryColor,
              width: MediaQuery.of(context).size.width / 1.5,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "XDFETFASFERW3",
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Merchant Name",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blue[500],
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "ENJOY YOUR",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
                fontSize: 18,
              ),
            ),
            Text(
              "TREAT!",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
                fontSize: 50,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Present this promo code at the counter at any of partner brand to avail a discount or a freebie",
              // textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FlatButton(
              onPressed: () {
                print("more..");
              },
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.all(10),
                child: Text(
                  "Checkout out more awesome deals",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
