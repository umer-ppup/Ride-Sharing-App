import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:ride/Models/completeRideModel.dart';
import 'package:ride/Models/startRidePostModel.dart';
import 'package:ride/Models/submitReview.dart';
import 'package:ride/Models/vechileTypeModel.dart';
import 'package:ride/apiCalls/apiCalls.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/ui/driveWithCaptain.dart';
import 'package:ride/ui/findCaptian.dart';
import 'package:ride/ui/masterCardListView.dart';
import 'package:ride/ui/reviewPage.dart';
import 'package:ride/ui/trackRiderScreen.dart';
import 'package:ride/Constants/varaibleAssets.dart';

mobXclass mobx = mobXclass();

Widget formtextField(TextEditingController textediting, String hint, bool value) {
  return TextFormField(
    style: TextStyle(color: AppColors.black[100]),
    controller: textediting,
    textInputAction: TextInputAction.next,
    obscureText: value,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.grye[100],
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:AppColors.black[100],
        ),
      ),
      border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
      alignLabelWithHint: true,
      labelText: hint,
      labelStyle: TextStyle(
        fontSize: 16,
        color: AppColors.black[100],
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      suffixIcon: hint == 'Enter Email' ? Icon(Icons.email,color: AppColors.black[100],) :Icon(Icons.lock,color: AppColors.black[100],),
    ),

    validator: (textediting) {
      if (textediting.isEmpty) {
        return 'Fill The Field';
      }
      else if (hint == 'Enter Email' ?!Secrets.kEmailValidatorRegExp.hasMatch(textediting):
      !Secrets.kPasswordValidatorRegExp.hasMatch(textediting)) {
        return 'Invalid Format';
      }
      else {
        return null;
      }
    },
  );
}
Widget reviewfield(TextEditingController textediting, String hint, bool value) {
  return TextFormField(
    style: TextStyle(color: AppColors.black[100]),
    controller: textediting,
    textInputAction: TextInputAction.next,
    obscureText: value,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.grye[100],
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:AppColors.black[100],
        ),
      ),
      border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
      alignLabelWithHint: true,
      labelText: hint,
      labelStyle: TextStyle(
        fontSize: 16,
        color: AppColors.black[100],
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      suffixIcon: hint == 'Enter Email' ? Icon(Icons.card_giftcard,color: AppColors.black[100],) :Icon(Icons.lock,color: AppColors.black[100],),
    ),

    validator: (textediting) {
      if (textediting.isEmpty) {
        return 'Fill The Field';
      } else if (hint == 'Enter Email' ?!Secrets.kEmailValidatorRegExp.hasMatch(textediting):
      !Secrets.kPasswordValidatorRegExp.hasMatch(textediting)) {
        return 'Invalid Format';
      } else {
        return null;
      }
    },
  );
}

Widget signUpformField(TextEditingController textediting, String hint, bool value) {
  return TextFormField(
    style: TextStyle(color: AppColors.black[100]),
    controller: textediting,
    textInputAction: TextInputAction.next,
    autofocus: true,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.grye[100],
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:AppColors.black[100],
        ),
      ),
      border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
      alignLabelWithHint: true,
      labelText: hint,
      labelStyle: TextStyle(
        fontSize: 16,
        color: AppColors.black[100],
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    ),

    validator: (textediting) {
      if (textediting.isEmpty) {
        return 'Fill The Field';
      } else if (hint == 'Enter Phone' ?!Secrets.kPhoneValidatorRegExp.hasMatch(textediting):
      textediting.length < 2) {
        return 'Invalid Format';
      } else {
        return null;
      }
    },
  );
}

Widget twosignup(TextEditingController textediting, String hint, bool value) {
  return TextFormField(
    style: TextStyle(color: AppColors.black[100]),
    controller: textediting,
    textInputAction: TextInputAction.next,
    autofocus: true,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.grye[100],
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:AppColors.black[100],
        ),
      ),
      border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
      alignLabelWithHint: true,
      labelText: hint,
      labelStyle: TextStyle(
        fontSize: 16,
        color: AppColors.black[100],
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      // suffixIcon: hint == 'Enter email' ? Icon(Icons.email,color: AppColors.black[100],) :Icon(Icons.lock,color: AppColors.black[100],),
    ),

    validator: (textediting) {
      if (textediting.isEmpty) {
        return 'Fill The Field';
      } else if (hint == 'Enter email' ?!Secrets.kEmailValidatorRegExp.hasMatch(textediting):
      !Secrets.kPasswordValidatorRegExp.hasMatch(textediting)) {
        return 'Invalid Format';
      } else {
        return null;
      }
    },
  );
}


   Widget textwidget(String txt, double adjustfont) {
    return Text(txt,
      overflow: TextOverflow.fade,
      maxLines: 2,
      softWrap: false,style: TextStyle(
        color: AppColors.black[100], fontSize: adjustfont),);
  }

   Widget textwidgetbold(String txt, double font) {
    return Text(txt,
      overflow: TextOverflow.fade,
      maxLines: 2,
      softWrap: false,style: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.black[100],
        fontSize: font),);
  }

   Widget whitecolortextwidget(String txt) {
    return Text(txt,
      overflow: TextOverflow.fade,
      maxLines: 2,
      softWrap: false,style: TextStyle(
        fontWeight: FontWeight.bold, color: AppColors.white[100]),);
  }

   paymentmethod(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: AppColors.black[100],
            ),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 30,
                  ),
                  SizedBox(
                      height: 210.0,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            color: AppColors.white[100],
                          ),
                          child: Stack(
                            alignment: Alignment(0, 0),
                            // overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                top: -36,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                      border: Border.all(
                                          color: Color(0xff232f34), width: 10)),
                                  child: Center(
                                    child: ClipOval(
                                      child: Image.asset(
                                        Assets.loginpageanimation,
                                        height: 46.0, width: 46.0,),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: ListView(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0, top: 25.0),
                                        child: textwidgetbold(
                                            'Select a payment Method',
                                            Assets.font2)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: textwidget(
                                                'Total Fear : ', Assets.font1)),
                                        Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: textwidgetbold(
                                                Secrets.totalfear.toString(), Assets.font1)),
                                      ],
                                    ),
                                    new ListTile(
                                        leading: Image.asset(
                                            Assets.monyeanimation),
                                        title: textwidget(
                                            'Cash', Assets.font1),
                                        onTap: () =>
                                        {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      findCaptain()))
                                        }
                                    ),
                                    new ListTile(
                                        leading: Image.asset(
                                            Assets.creditCardAmination),
                                        title: textwidget(
                                            'Card payment', Assets.font1),
                                        onTap: () =>
                                        {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      findCaptain()))
                                        }
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                      )),
                  // Container(
                  //   height: 56,
                  //   color: Color(0xff4a6572),
                  // )
                ],
              ),
            ),
          );
        });
  }

totalpaymentdetails(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            color: AppColors.black[100],
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 30,
                ),
                SizedBox(
                    height: 210.0,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          color: AppColors.white[100],
                        ),
                        child: Stack(
                          alignment: Alignment(0, 0),
                          // overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              top: -36,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(
                                        color: Color(0xff232f34), width: 10)),
                                child: Center(
                                  child: ClipOval(
                                    child: Image.asset(
                                      Assets.loginpageanimation,
                                      height: 46.0, width: 46.0,),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: ListView(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0, top: 25.0),
                                      child: textwidgetbold(
                                          'Your journey Fare',
                                          Assets.font2)),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: textwidget(
                                              'To: ', Assets.font1)),
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: textwidgetbold(
                                              Secrets.destinationAddress, Assets.font1)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: textwidget(
                                              'From: ', Assets.font1)),
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: textwidgetbold(
                                              Secrets.startAddress.toString(), Assets.font1)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: textwidget(
                                              'Total KM: ', Assets.font1)),
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: textwidgetbold(
                                              mobx.placeDistance != null ? mobx
                                                  .placeDistance : '', Assets.font1)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: textwidget(
                                              'Ride Time: ', Assets.font1)),
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: textwidgetbold(
                                              Secrets.esitimatedTime != null ? Secrets
                                                  .esitimatedTime : '', Assets.font1)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: textwidget(
                                              'Total Fare : ', Assets.font1)),
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: textwidgetbold(
                                              Secrets.totalfear.toString(), Assets.font1)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    )),
                // Container(
                //   height: 56,
                //   color: Color(0xff4a6572),
                // )
              ],
            ),
          ),
        );
      });
}

   trackRiderBottomAppBar(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: AppColors.black[100],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 30,
                  ),
                  SizedBox(
                      height: 270.0,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            color: AppColors.white[100],
                          ),
                          child: Stack(
                            alignment: Alignment(0, 0),
                            // overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                top: -36,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(
                                        color: Color(0xff232f34), width: 10),
                                  ),
                                  child: Center(
                                    child: ClipOval(
                                      child: Image.asset(
                                        Assets.loginpageanimation,
                                        height: 46.0, width: 46.0,),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: ListView(
                                  padding: EdgeInsets.only(
                                      top: 30.0, right: 15.0, left: 15.0),
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                         Row(
                                            children: [
                                              Expanded(
                                                child: textwidgetbold(
                                                    'TO :  ', Assets.font2),
                                              ),
                                              Expanded(
                                                child:  textwidget(
                                                    Secrets.destinationAddress, Assets.font1),
                                              )
                                            ],
                                          ),

                                    SizedBox(height: 10.0,),
                                        Row(
                                        children: [
                                          Expanded(
                                            child: textwidgetbold(
                                                'From :  ', Assets.font2),
                                          ),
                                          Expanded(
                                            child:textwidget(
                                                Secrets.startAddress,
                                                Assets.font1),
                                          ),
                                        ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        textwidget(
                                            'Captain Name :', Assets.font1),
                                       textwidgetbold(
                                            'Hamza iqbal', Assets.font1),
                                      ],
                                    ),

                                    SizedBox(height: 10.0,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                           textwidget(
                                              'Expected Time', Assets.font1),
                                           Observer(builder:  (context){
                                             return  textwidgetbold(
                                                 mobx.trackriderTime != null ? mobx.trackriderTime :'Loding', Assets.font1);
                                           })
                                      ],
                                    ),
                                    SizedBox(height: 10.0,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            textwidget(
                                                'phn :', Assets.font1),
                                            textwidget(
                                                ' 0306757575', Assets.font1),
                                          ],
                                        ),
                                        CircleAvatar(
                                            backgroundColor: AppColors
                                                .black[100],
                                            radius: 20,
                                            child: Icon(Icons.phone,
                                              color: AppColors
                                                  .white[100],) //Text
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                       mapStratAndCancelButton(
                                            'Cancel Ride', context,
                                            AppColors.red[100]),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                      )),

                ],
              ),
            ),
          );
        });
  }

   choicebottomsheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: AppColors.black[100],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 30,
                  ),

                  SizedBox(
                      height: (56 * 6).toDouble(),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            color: AppColors.white[100],
                          ),
                          child: Stack(
                            alignment: Alignment(0, 0),
                            // overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                top: -36,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                      border: Border.all(
                                          color: Color(0xff232f34), width: 10)),
                                  child: Center(
                                    child: ClipOval(
                                      child: Image.asset(
                                        Assets.loginpageanimation,
                                        height: 46.0, width: 46.0,),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: FutureBuilder(
                                  future: getVechileTypeRequest('TYPE_URL'),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (BuildContext, index) {
                                            VechileTypeModel vechileTypeModel = snapshot.data[index];
                                            return ListTile(
                                                leading: Image.asset(
                                                    vechileTypeModel.image),
                                                title: textwidget(
                                                    vechileTypeModel.vechiletype, Assets.font1),
                                                trailing: textwidget(vechileTypeModel.killometterrupe.toString(),15.0),
                                                onTap: () =>
                                                {
                                                  Secrets.vechileId = vechileTypeModel.id,
                                                  Secrets.totalfear = vechileTypeModel.killometterrupe,
                                                 paymentmethod(context)
                                                }
                                            );
                                          });
                                    } else {
                                      debugPrint('Step 1, build loading widget');
                                      return Container();
                                    }
                                  },
                                ),
                              )
                            ],
                          )
                      )),
                  // Container(
                  //   height: 56,
                  //   color: Color(0xff4a6572),
                  // )
                ],
              ),
            ),
          );
        });
  }

   drivewithCaptainBottomsheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: Colors.black,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 30,
                  ),
                  SizedBox(
                      height: 275.0,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            color: AppColors.white[100],
                          ),
                          child: Stack(
                            alignment: Alignment(0, 0),
                            // overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                top: -36,
                                child: Container(

                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(
                                        color: Color(0xff232f34), width: 10),
                                  ),
                                  child: Center(
                                    child: ClipOval(
                                      child: Image.asset(
                                        Assets.loginpageanimation,
                                        height: 46.0, width: 46.0,),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: ListView(
                                  padding: EdgeInsets.only(
                                      top: 30.0, right: 15.0, left: 15.0),
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Expanded(
                                          child: textwidgetbold(
                                              'TO :  ', Assets.font2),
                                        ),
                                        Expanded(
                                          child:  textwidget(
                                              Secrets.destinationAddress, Assets.font1),
                                        )
                                      ],
                                    ),

                                    SizedBox(height: 10.0,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: textwidgetbold(
                                              'From :  ', Assets.font2),
                                        ),
                                        Expanded(
                                          child:textwidget(
                                              Secrets.startAddress,
                                              Assets.font1),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Expanded(
                                          child: textwidget(
                                              'Captain Name :', Assets.font1),
                                        ),
                                        Expanded(
                                          child: textwidgetbold(
                                              'Hamza iqbal', Assets.font1),
                                        )

                                      ],
                                    ),

                                    SizedBox(height: 10.0,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Expanded(
                                          child: textwidget(
                                              'Expected Time', Assets.font1),
                                        ),
                                        Expanded(
                                          child:  textwidgetbold(
                                              Secrets.esitimatedTime, Assets.font1),
                                        )


                                      ],
                                    ),
                                    SizedBox(height: 10.0,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Expanded(
                                          child: textwidget(
                                              'Total Fear :', Assets.font1),
                                        ),
                                        Expanded(
                                          child:textwidgetbold(
                                              Secrets.totalfear, Assets.font1),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        completeRideButton(
                                            'End Ride', context,
                                            AppColors.black[100]),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                      )),
                ],
              ),
            ),
          );
        });
  }


   Widget buttonwidget(String txt, BuildContext context, int num) {
    return ButtonTheme(
      minWidth: 200.0,
      height: 50.0,
      child: RaisedButton(
        padding: const EdgeInsets.all(8.0),
        color: AppColors.black[100],
        onPressed: () {
          if (num == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => trackRiderScreen()));
          } else if (num == 2) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => masterCardListView()));
          }
          else if (num == 3) {
            submitReviewModel submit =submitReviewModel(userId: Secrets.userId,
            rating: Secrets.ratingTotal.toString(), comment: Secrets.submitreviewController.text.toString() );
            submitRieviewPostRequest('URL_TYPE',body: submit.toMap()).then((value){

            });
          }
        },
        child: whitecolortextwidget(txt),
      ),
    );
  }

   Widget newbutton(String txt, BuildContext context) {
    return ButtonTheme(
      minWidth: 200.0,
      height: 50.0,
      child: RaisedButton(
        padding: const EdgeInsets.all(8.0),
        color: AppColors.black[100],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => reviewScreen()));
        },
        child: whitecolortextwidget(txt),
      ),
    );
  }


   Widget mapStratAndCancelButton(String txt, BuildContext context, Color color) {
    return ButtonTheme(
      minWidth: MediaQuery
          .of(context)
          .size
          .width / 2.5,
      height: 55.0,
      child: RaisedButton(
        padding: const EdgeInsets.all(8.0),
        color: color,
        onPressed: () {
          startRidePostModel rideStart = startRidePostModel(request: '1');
          startRidePostRequest('TYPE_URL', body: rideStart.toMap()).then((value){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => driveWithCaptain()));
          });
        },
        child: whitecolortextwidget(txt),
      ),
    );
  }

   Widget completeRideButton(String txt, BuildContext context, Color color) {
    return ButtonTheme(
      minWidth: MediaQuery
          .of(context)
          .size
          .width / 1.5,
      height: 55.0,
      child: RaisedButton(
        padding: const EdgeInsets.all(8.0),
        color: color,
        onPressed: () {
          completeRideModel completeride = completeRideModel(userId: Secrets.userId,
          totalFear: Secrets.totalfear, to: Secrets.destinationAddress ,from: Secrets.startAddress);
          endRidePostRequest('CREATE_URL', body: completeride.toMap()).then((value){

          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => reviewScreen()));
        },
        child: whitecolortextwidget(txt),
      ),
    );
  }

   Widget FoamTextfield(String txt) {
    return TextField(
      onChanged: (value) {
        if (txt == 'Card Number') {
          Assets.cardNumber = value;
        } else if (txt == 'Card Expiry') {
          Assets.expiryDate = value;
        } else if (txt == 'Card Holder Name') {
          Assets.cardHolderName = value;
        } else if (txt == 'CVV') {
          Assets.cvv = value;
        }
      },
      style: TextStyle(color: Colors.black),
      obscureText: false,
      autofocus: true,
      decoration: InputDecoration(
        hoverColor: AppColors.black[100],
        hintText: txt,
        focusColor: AppColors.black[100],
        hintStyle: TextStyle(fontWeight: FontWeight.w300,
            fontSize: 14.0, color: AppColors.black[100]),
        fillColor: Colors.transparent,
        filled: true,
        contentPadding: EdgeInsets.all(15.0),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]),
        ),

      ),
    );
  }


   Widget containerWidget(String txt, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0, bottom: 5.0),
      child: Container(
        height: 55.0,
        decoration: BoxDecoration(
            color: AppColors.white[100],
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey[400])
        ),
        child: FoamTextfield(txt),
      ),
    );
  }

