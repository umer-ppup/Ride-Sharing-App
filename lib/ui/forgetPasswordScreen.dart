import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:ride/Constants/varaibleAssets.dart';
import 'package:ride/Models/forgetPasswordModel.dart';
import 'package:ride/apiCalls/apiCalls.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/ui/screenSize.dart';


class ForgetPassword extends StatefulWidget {
  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController phone;
  mobXclass mobx = mobXclass();
  var _encname;
  ProgressDialog pr;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Wait...',
        borderRadius: 5.0,
        backgroundColor: AppColors.white[100],
        progressWidget: SpinKitFadingCircle(color: AppColors.black[100],),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: AppColors.black[100], fontSize: 10.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: AppColors.black[100], fontSize: 14.0, fontWeight: FontWeight.w600)
    );
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: AppColors.white[100],
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(Assets.forgetpasswordanimation,
                        width: MediaQuery.of(context).size.width,height: ScreenSizeResponsive.screenHeight(context, dividedBy: 3)),
                    SizedBox(height: 50.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(Assets.forgettxt,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10.0,),
                        Text(Assets.forgetguide,
                          style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.normal,
                              color: Colors.grey[600]),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0,right: 15.0,left: 15.0,bottom: 5.0),
                      child: Container(
                        height: 55.0,
                        decoration: BoxDecoration(
                            color: AppColors.white[100],
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey[400])),
                        child: TextField(
                          controller: phone,
                          decoration: InputDecoration(
                            hoverColor: AppColors.black[100],
                            hintText: "Enter The phone Number",
                            focusColor: AppColors.black[100],
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14.0),
                            fillColor: Colors.transparent,
                            filled: true,
                            contentPadding: EdgeInsets.all(15.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.white[100]),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.white[100]),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          // onEditingComplete: () => node.nextFocus(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0,left: 15.0,top: 5.0),
                      child: Container(
                        height:55.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors.black[100],
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            pr.show();
                            forgetPasswordModel newForgetPasswordRequest = new forgetPasswordModel(userId: Secrets.userId, phone: phone.text);
                            forgetPasswordPostRequest('CREATE_loginPost_URL', body: newForgetPasswordRequest.toMap()).then((value){
                              pr.hide();
                            });
                          },
                          child:Center(
                            child: Text(Assets.forgetbuttontxt,style: TextStyle(fontWeight: FontWeight.bold,color:AppColors.white[100],
                               ),),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

}