import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/widgets/widget.dart';

class masterCard extends StatefulWidget {
  @override
  _masterCardState createState() => _masterCardState();
}

class _masterCardState extends State<masterCard> {
  FocusNode _focusNode;
  mobXclass mobx = mobXclass();
  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? Assets.showBack = true : Assets.showBack = false;
      });
    });

    // StripePayment.setOptions(
    //     StripeOptions(
    //         publishableKey:Assets.stripePubliskKey,
    //         merchantId: Assets.stripeSecret,
    //         androidPayMode: 'test'
    //     ));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: whitecolortextwidget('Save Card'),
        iconTheme: IconThemeData(color: AppColors.white[100]),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 35.0,),
              CreditCard(
                cardNumber: Assets.cardNumber,
                cardExpiry: Assets.expiryDate,
                cardHolderName: Assets.cardHolderName,
                cvv: Assets.cvv,
                bankName: "Pakistan Bank",
                showBackSide: Assets.showBack,
                frontBackground: CardBackgrounds.black,
                backBackground: CardBackgrounds.white,
                showShadow: true,
              ),

              SizedBox(height: 20.0,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 containerWidget('Card Number', context),
                  containerWidget('Card Holder Name', context),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height:55.0,
                          width: MediaQuery.of(context).size.width/2.5,
                          decoration: BoxDecoration(
                              color: AppColors.white[100],
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey[400]  )
                          ),
                          child:FoamTextfield('Card Expiry'),
                        ),
                        SizedBox(width: 10.0,),
                        Container(
                          height:55.0,
                          width: MediaQuery.of(context).size.width/2.5,
                          decoration: BoxDecoration(
                              color: AppColors.white[100],
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey[400]  )
                          ),
                          child:FoamTextfield('CVV'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0,),
             buttonwidget('Save Card', context,2)
            ],
          ),
        ),
      ),
    );
  }
}
