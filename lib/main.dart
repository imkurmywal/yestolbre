import 'package:flutter/material.dart';
import 'package:yestolbre/src/home_view.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  return runApp(MyApp());
}



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
      home: HomeView(),
    );
  }
}
