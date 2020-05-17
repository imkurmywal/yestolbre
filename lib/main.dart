import 'package:flutter/material.dart';
import 'package:yestolbre/src/home_view.dart';
import 'package:yestolbre/src/view_coupon.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yestolbre',
      theme: ThemeData(
        primaryColor: Color(0xffFF5C27),
      ),
      home: ViewCoupon(),
    );
  }
}
