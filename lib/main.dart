import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride/Constants/app_theme.dart';
import 'package:ride/SplashScreen/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: themeData,
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: SplashScreen(),
    );
  }
}


