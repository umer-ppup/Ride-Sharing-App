import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ride/ui/homePage.dart';
import 'package:ride/ui/loginScreen.dart';
import 'package:ride/widgets/widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => homePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: AppColors.white[100],
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 3,
                      child:Center(
                        child: Container(
                          child: OrientationBuilder(
                            builder: (context, orientation) => Center(
                              child: Image.asset(
                                Assets.splashcaranimation,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ),

                  SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color:AppColors.black[100]
                        ),
                      );
                    },
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      child: OrientationBuilder(
                        builder: (context, orientation) => Center(
                            child: Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.atrulelogo,
                                height: 70.0,
                                width: 80.0,
                              ),
                              textwidget('ATRULE TECHNOLOGIES',15.0)
                            ],
                          ),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
