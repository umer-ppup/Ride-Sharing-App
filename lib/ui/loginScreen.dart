import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:ride/Constants/varaibleAssets.dart';
import 'package:ride/Models/loginModel.dart';
import 'package:ride/apiCalls/apiCalls.dart';
import 'package:ride/localjson/localjson.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/ui/homePage.dart';
import 'package:ride/ui/screenSize.dart';
import 'package:ride/ui/signUpScreen.dart';
import  'package:ride/widgets/widget.dart';
import 'package:ride/ui/forgetPasswordScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController email, password;
  ProgressDialog pr;
  final _formKey = GlobalKey<FormState>();
  mobXclass mobx = mobXclass();
  double height,width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = TextEditingController();
    password = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Wait...',
        borderRadius: 5.0,
        backgroundColor:  AppColors.white[100],
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
         child: Form(
           key: _formKey,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
             children: <Widget>[
               Image.asset(Assets.loginpageanimation,height: ScreenSizeResponsive.screenHeight(context, dividedBy: 3),
                   width: MediaQuery.of(context).size.width),
               Padding(
                 padding: EdgeInsets.all(15.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[

                textwidget(Assets.welcometxt,Assets.font1),
                     SizedBox(height: 10.0,),
                     Text(Assets.guidetxt,
                       style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.normal,
                           color: Colors.grey[600]),),

                   ],
                 ),
               ),

               Padding(
                 padding: EdgeInsets.all(15.0),
                 child: Column(
                   children: <Widget>[
                     formtextField(email, 'Enter Email',false),
                     SizedBox(height: 15.0,),
                     formtextField(password, 'Enter password',true),
                     SizedBox(height: 15.0,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                         InkWell(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                           },
                           child: Text(
                             Assets.loginforgetpasswordtxt,
                             style: TextStyle(
                                 color:  AppColors.black[100],
                                 fontSize: 13.0,
                                 fontWeight: FontWeight.bold),
                           ),
                         ),
                       ],
                     ),
                     SizedBox(
                       height: 10.0,
                     ),
                     Container(
                       height:55.0,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           color: AppColors.black[100],
                           borderRadius: BorderRadius.circular(5.0)
                       ),
                       child: MaterialButton(
                           // getIdByPrefrence();
                           // pr.show();
                          onPressed:() async{
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              pr.show();
                              Storage.readData().then((value) async {
                                if(value != ""){
                                  loginPost user = loginPost.fromJson(json.decode(value));
                                  if(user.email == email.text && user.password == password.text){
                                    await pr.hide();
                                    method();
                                  }
                                  else{
                                    pr.hide();
                                    Fluttertoast.showToast(
                                        msg: "Error: Login failed.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: AppColors.white[100],
                                        textColor: AppColors.black[100],
                                        fontSize: 16.0
                                    );
                                  }
                                }
                              });

                              // loginPost newloginPost = new loginPost(userId: Secrets.userId, email: email.text, password: password.text);
                              // loginpostRequest('CREATE_loginPost_URL', body: newloginPost.toMap()).then((value){
                              //   pr.hide();
                              // });
                            }
                          },
                         child:Center(
                           child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.white[100],
                               ),),
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 20.0,
                     ),
                     InkWell(
                       onTap: () async{
                         Navigator.pushReplacement(context,
                             MaterialPageRoute(builder: (context) => signUpScreen()));
                       },
                       child: Text(
                         Assets.loginpagecreatenewaccounttxt,
                         style: TextStyle(
                             color: AppColors.black[100],
                             fontSize: 13.0,
                             decoration: TextDecoration.underline,
                             fontWeight: FontWeight.normal),
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
        ),
      ),
    );
  }
  void method() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setString('login', '1');
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => homePage()));
  }
}