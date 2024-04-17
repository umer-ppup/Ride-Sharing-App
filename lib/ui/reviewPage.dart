import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:ride/Constants/varaibleAssets.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/ui/screenSize.dart';
import 'package:ride/widgets/widget.dart';

class reviewScreen extends StatefulWidget {
  @override
  _reviewScreenState createState() => _reviewScreenState();
}

class _reviewScreenState extends State<reviewScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      totalpaymentdetails(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: AppColors.white[100]),
        title: whitecolortextwidget('Give Review'),
      ),
      body: Container(
        color: AppColors.white[100],
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.reviewanimation,
                width: MediaQuery.of(context).size.width,
                height:
                    ScreenSizeResponsive.screenHeight(context, dividedBy: 3),
              ),
              RatingBar(
                onRatingChanged: (rating) => setState(() => Secrets.ratingTotal = rating),
                filledIcon: Icons.emoji_emotions,
                emptyIcon: Icons.emoji_emotions_outlined,
                filledColor: AppColors.deepPurple[50],
                emptyColor: AppColors.black[100],
                size: 48,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  height: 120.0,
                  decoration: BoxDecoration(
                      color: AppColors.white[100],
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.grey[400])),
                  child: reviewfield(Secrets.submitreviewController, 'Enter The Comment', false),
                ),
              ),

              SizedBox(height: 15.0,),

              buttonwidget('Submit Review' , context , 3)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.red[100],
        onPressed: () async{
          totalpaymentdetails(context);
          // await mobx.polulinefortrackrider(position,desti);
        },
        icon: Icon(Icons.arrow_drop_up_outlined,size: 40.0,color: AppColors.white[100],),
        label: whitecolortextwidget("Tap to Fare information"),
      ),
    );
  }
}
