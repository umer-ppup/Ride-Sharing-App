import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:ride/Constants/varaibleAssets.dart';
import 'package:ride/Models/loginModel.dart';
import 'package:ride/Models/signUpRequestModel.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/ui/otpScreen.dart';
import 'package:ride/ui/screenSize.dart';
import 'package:ride/ui/loginScreen.dart';
import 'package:ride/widgets/widget.dart';
import 'package:ride/apiCalls/apiCalls.dart';
import 'package:ride/localjson/localjson.dart';

class signUpScreen extends StatefulWidget {
  @override
  _signUpScreenState createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  // Item selectedUser;
  mobXclass mobx = mobXclass();
  List data;
  String mystate;
  final _formKey = GlobalKey<FormState>();
  TextEditingController email, password, phone, name;
  ProgressDialog pr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name =TextEditingController();
    password =TextEditingController();
    phone =TextEditingController();
    email =TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Waiting...',
        borderRadius: 5.0,
        backgroundColor: AppColors.white[100],
        progressWidget: SpinKitFadingCircle(color: AppColors.black[100]),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: AppColors.black[100],
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
          ),
        messageTextStyle: TextStyle(
            color: AppColors.black[100],
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            )
    );
    final node = FocusScope.of(context);
    return Scaffold(
      body: Container(
        color: AppColors.white[100],
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10.0),
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Image.asset(Assets.signupanimation,
                          width: MediaQuery.of(context).size.width,
                          height: ScreenSizeResponsive.screenHeight(context, dividedBy: 3),),
                        SizedBox(height: 20.0,),
                        signUpformField(name, 'John Doe',false),
                        SizedBox(
                          height: 10.0,
                        ),
                        twosignup(email, 'Enter email',false),
                        SizedBox(
                          height: 10.0,
                        ),
                        twosignup(password, 'Enter Password',true),
                        SizedBox(
                          height: 10.0,
                        ),
                        signUpformField(phone, 'Enter Phone',false),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 50.0,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              color: AppColors.black[100],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: MaterialButton(
                             onPressed: (){
                               if (_formKey.currentState.validate()) {
                                 _formKey.currentState.save();
                                 pr.show();
                                 Storage.readData().then((value) async {
                                   if(value != ""){
                                     signUpPostModel user = signUpPostModel.fromJson(json.decode(value));
                                     if(user.email != email.text){
                                       signUpPostModel user = new signUpPostModel(
                                           name: name.text,
                                           email: email.text,
                                           password: password.text,
                                           phone: phone.text
                                       );
                                       await Storage.writeData(json.encode(user));
                                       await pr.hide();
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                       Fluttertoast.showToast(
                                           msg: "Succesfully Register",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.BOTTOM,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: AppColors.white[100],
                                           textColor: AppColors.black[100],
                                           fontSize: 16.0
                                       );
                                     }
                                     else{
                                       await pr.hide();
                                       Fluttertoast.showToast(
                                           msg: "Error: Email already exists.",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.BOTTOM,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: AppColors.white[100],
                                           textColor: AppColors.black[100],
                                           fontSize: 16.0
                                       );
                                     }
                                   }
                                   else{
                                     signUpPostModel user = new signUpPostModel(
                                         name: name.text,
                                         email: email.text,
                                         password: password.text,
                                         phone: phone.text
                                     );
                                     await Storage.writeData(json.encode(user));
                                     await pr.hide();
                                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                   }
                                 });

                                 // signUpPostModel  newSignUpRequest = new signUpPostModel(
                                 //     name: name.text, email: email.text, password: password.text,phone: phone.text);
                                 // signUpPostRequest('CREATE_loginPost_URL', body: newSignUpRequest.toMap()).then((value){
                                 //   if(value == 'success'){
                                 //     pr.hide();
                                 //     Fluttertoast.showToast(
                                 //         msg: "Success",
                                 //         toastLength: Toast.LENGTH_SHORT,
                                 //         gravity: ToastGravity.BOTTOM,
                                 //         backgroundColor: AppColors.white[100],
                                 //         textColor: AppColors.black[100],
                                 //         fontSize: 16.0);
                                 //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                 //   }else{
                                 //     pr.hide();
                                 //     Fluttertoast.showToast(
                                 //         msg: "Failed",
                                 //         toastLength: Toast.LENGTH_SHORT,
                                 //         gravity: ToastGravity.BOTTOM,
                                 //         backgroundColor: AppColors.white[100],
                                 //         textColor: AppColors.black[100],
                                 //         fontSize: 16.0);
                                 //   }
                                 // });
                               }
                             },
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white[100],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already Have a Account",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.0,
          ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) =>
                                          LoginPage()));
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color:AppColors.black[100],
                                      fontSize: 13.0,
                                      decoration: TextDecoration.underline,
                                      fontFamily: 'Lily'),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

}

