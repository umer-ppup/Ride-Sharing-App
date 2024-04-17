import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Models/signUpRequestModel.dart';
import 'package:ride/localjson/localjson.dart';
import 'package:ride/widgets/ProfileHeader.dart';
import 'package:ride/widgets/ProfileMenu.dart';
import 'package:ride/widgets/widget.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white[100]),
        backgroundColor: AppColors.black[100],
        title:whitecolortextwidget('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top:10.0),
                child: ProfileHeader()),
            SizedBox(height: 20),
            ProfileMenu(
              text: user.name != null ? user.name :"Loading",
              icon: Icon(Icons.supervised_user_circle_outlined,color: AppColors.white[100],),
              press: () => {},
            ),
            ProfileMenu(
              text: user.email != null ?user.email :"Loading",
              icon: Icon(Icons.email,color: AppColors.white[100]),
              press: () => {},
            ),
            ProfileMenu(
              text: user.password != null ?user.password :"Loading",
              icon: Icon(Icons.lock,color: AppColors.white[100]),
              press: () => {},
            ),
            ProfileMenu(
              text: user.phone!= null ?user.phone :"Loading",
              icon: Icon(Icons.phone,color: AppColors.white[100]),
              press: () => {},
            ),
            ProfileMenu(
              text: "Logout",
              icon: Icon(Icons.sensor_door_outlined,color: AppColors.white[100]),
              press: () => {},
            ),
          ],
        ),
      ),
    );
  }

  Storage storage = new Storage();
  signUpPostModel user = new signUpPostModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Storage.readData().then((value) async {
      if(value != ""){
        setState(() {
          user = signUpPostModel.fromJson(json.decode(value));
        });
      }
      else{
        user.name = "ABC";
        user.email = "sample@email.com";
        user.phone = "Sample phone number";
        user.password = "";
      }
    });
  }
}

