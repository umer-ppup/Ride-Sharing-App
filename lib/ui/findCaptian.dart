import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/ui/screenSize.dart';
import 'package:ride/widgets/widget.dart';

class findCaptain extends StatefulWidget {
  @override
  _findCaptainState createState() => _findCaptainState();
}

class _findCaptainState extends State<findCaptain> {
  mobXclass mobx = mobXclass();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => callmethod());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.only(bottom: 30.0,left: 10.0,right: 10.0,top: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.white[100],
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(Assets.mapanimation,width: MediaQuery.of(context).size.width,
                      height: ScreenSizeResponsive.screenHeight(context, dividedBy: 3),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textwidget('Driver Name',Assets.font1),
                        textwidget(Assets.driverName != null ?Assets.driverName : '-----',Assets.font1),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textwidget('Car No',Assets.font1),
                        textwidget(Assets.carNumber != null ?Assets.carNumber :'-----',Assets.font1),
                      ],
                    ),

                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textwidget('Driver NO',Assets.font1),
                        textwidget(Assets.driverPhone != null ?Assets.driverPhone : '-----',Assets.font1),
                      ],
                    ),

                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textwidget('Total fare',Assets.font1),
                        textwidget(Assets.totalFare != null ? Assets.totalFare :'-----',Assets.font1),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textwidget('Driver Rating',Assets.font1),
                        textwidget(Assets.totalFare != null ? '4.5*' :'-----',Assets.font1),
                      ],
                    ),

                    SizedBox(height: 10),
                    Assets.findOrNot != true ?Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        child: whitecolortextwidget('Wait a while Ride Hailing finding a best captain for your ride'),
                      ),
                    ):Container(),
                    SizedBox(height: 20.0,),
                    Assets.findOrNot ? buttonwidget('Track Rider',context,1):Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void callmethod() {
   setState(() {
     Assets.findOrNot = true;
     Assets.driverName ='Hamza iqbal';
     Assets.driverPhone ='03066969306';
     Assets.carNumber ='LES 2450';
     Assets.totalFare ='350';
   });
  }
}
