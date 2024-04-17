import 'package:flutter/material.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/widgets/widget.dart';

class ProfileMenu extends StatelessWidget {

  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
        color: AppColors.black[100],
        onPressed: press,
        child: Row(
          children: [
            icon,
            SizedBox(width: 20),
            Expanded(child:whitecolortextwidget(text)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),);
  }
}
