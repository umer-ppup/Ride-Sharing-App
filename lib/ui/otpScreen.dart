import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:ride/Constants/varaibleAssets.dart';
import 'package:ride/Models/otpModel.dart';
import 'package:ride/apiCalls/apiCalls.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/ui/screenSize.dart';
import 'package:ride/ui/loginScreen.dart';



class OtpScreen extends StatefulWidget {

  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {

  TextEditingController Otp1;
  var _encOtp;
  String currentText;
  ProgressDialog pr;
  mobXclass mobx = mobXclass();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Otp1=TextEditingController();

  }
  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Waiting...',
        borderRadius: 5.0,
        backgroundColor: AppColors.white[100],
        progressWidget: SpinKitFadingCircle(color: AppColors.black[100],),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: AppColors.black[100], fontSize: 10.0, fontWeight: FontWeight.w400,fontFamily: 'lily'),
        messageTextStyle: TextStyle(
            color: AppColors.black[100], fontSize: 14.0, fontWeight: FontWeight.w600,fontFamily: 'lily')
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.black[100],
          title: Text(Assets.otptxt,),
        ),
        body:Container(
          alignment: Alignment.center,
          color: AppColors.white[100],
          child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(Assets.otpanimation,
                          width: MediaQuery.of(context).size.width,height: ScreenSizeResponsive.screenHeight(context, dividedBy: 3)),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(Assets.otptxt,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily: 'lily'),),
                            SizedBox(height: 10.0,),
                            Text(Assets.otpguide,
                              style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.normal,fontFamily: 'lily',
                                  color: Colors.grey[600]),),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child:PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: AppColors.white[100],
                            fontWeight: FontWeight.bold,
                          ),
                          length: 4,
                          obscureText: false,
                          obscuringCharacter: '*',
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v.length < 3) {
                              return "I'm from validator";
                            } else {
                              return null;
                            }
                          },
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 60,
                            fieldWidth: 60,
                            activeFillColor:AppColors.white[100],
                            inactiveColor: AppColors.white[100],
                            disabledColor: AppColors.white[100],
                            activeColor: AppColors.white[100],
                            inactiveFillColor: AppColors.white[100],
                            selectedColor: AppColors.white[100],
                            selectedFillColor: AppColors.white[100]
                        ),
                          cursorColor: AppColors.black[100],
                          animationDuration: Duration(milliseconds: 300),
                          textStyle: TextStyle(fontSize: 20, height: 1.6),
                          backgroundColor: AppColors.white[100],
                          enableActiveFill: true,
                          controller: Otp1,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            print("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )

                      ),
                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width/1.5,
                        decoration: BoxDecoration(
                            color: AppColors.black[100],
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: MaterialButton(
                           onPressed: (){
                             pr.show();
                             otpPostModel newOtpPost = new otpPostModel(userId: Secrets.userId, otp:Otp1.text);
                             otpPostRequest('CREATE_loginPost_URL', body: newOtpPost.toMap()).then((value){
                               pr.hide();
                             });
                           },
                          child:Center(
                            child: Text(Assets.buttontext,style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.white[100],
                                ),),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            Assets.otpnotsend,
                            style: TextStyle(
                                color: Colors.grey, fontSize: 13.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () {

                              },
                              child: Text(
                                Assets.resend,
                                style: TextStyle(
                                    color: AppColors.black[100],
                                    fontSize: 13.0,
                                    decoration: TextDecoration.underline,),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
          ),
        )
    );
  }
  void method() {
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginPage())));
    pr.hide();
  }

}


