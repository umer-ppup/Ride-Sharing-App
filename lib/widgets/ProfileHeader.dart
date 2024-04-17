
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';

class ProfileHeader extends StatelessWidget {

  const ProfileHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115.0,
      width: 115.0,
      child: Stack(
        fit: StackFit.expand,
        // overflow: Overflow.visible,
        children: [
          CircleAvatar(backgroundImage: AssetImage(Assets.profileimage),),
          Positioned(right: -16,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.white),
                  ),
                  color: AppColors.black[100],
                  child: SvgPicture.asset(Assets.cameraicon),
                  onPressed: () {},
                ),
              ))
        ],
      ),
    );
  }
}
