import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ViewCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupon"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(14, 20, 14, 30),
        width: MediaQuery.of(context).size.width,
        child: DottedBorder(
          borderType: BorderType.Rect,
          dashPattern: [10],
          strokeWidth: 3,
          strokeCap: StrokeCap.square,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(14, 10, 14, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
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
                    color: Color(0xff01A233),
                    width: MediaQuery.of(context).size.width / 1.5,
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "XDFETFASFER",
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
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
                    height: 20,
                  ),
                  ClipOval(
                    child: Image.network(
                      "https://www.freelogodesign.org/Content/img/logo-samples/bakary.png",
                      height: 140,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Present this promo code at the counter at any of partner brand to avail a discount or a freebie",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                    height: 50,
                  ),
                  Text(
                    "20% Discount on breakfast & lunch".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // FlatButton(
                  //   onPressed: () {
                  //     Navigator.of(context).popUntil((route) => route.isFirst);
                  //   },
                  //   child: Container(
                  //     color: Colors.black,
                  //     padding: EdgeInsets.all(10),
                  //     child: Text(
                  //       "Checkout out more awesome deals",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 17,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
