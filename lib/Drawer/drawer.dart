import 'package:flutter/material.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:ride/ui/loginScreen.dart';
import 'package:ride/ui/masterCardAdd.dart';
import 'package:ride/ui/profileScreen.dart';
import 'package:ride/ui/saveAddress.dart';
import 'package:ride/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NavDrawe extends StatefulWidget {
  @override
  _NavDraweState createState() => _NavDraweState();
}

class _NavDraweState extends State<NavDrawe> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Drawer(
          child: Container(
            color: AppColors.black[100],
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(child: new DrawerHeader(child: Image.asset(Assets.draweranimation,height: 70.0,width: 90,)),color: AppColors.white[100],),
                ListTile(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileBody()));
                  },
                  leading: Icon(Icons.account_circle),
                  title: whitecolortextwidget('Profile'),
                ),

                ListTile(
                  leading: Icon(Icons.list),
                  title: whitecolortextwidget('Previous Rides'),
                  onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>prviousRide()))},
                ),


                ListTile(
                  leading: Icon(Icons.list),
                  title: whitecolortextwidget('Privacy policy'),
                  onTap: () => {Navigator.of(context).pop()},
                ),

                ListTile(
                  leading: Icon(Icons.apartment_sharp),
                  title: whitecolortextwidget('Logout'),
                  onTap: () => {
                    methodlogout()
                  },
                ),

                Divider(),
                ListTile(
                  leading: Icon(Icons.announcement_sharp),
                  title: whitecolortextwidget('About us'),
                  onTap: () =>
                  {
                    _launchURL()
                  },
                ),

              ],
            ),
          )
        )
    );
  }

  _launchURL() async {
    const url = 'https://atrule.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  methodlogout() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('login', '0');
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
}




