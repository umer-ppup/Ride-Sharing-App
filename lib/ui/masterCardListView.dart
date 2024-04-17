import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_slider.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:flutter/material.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/ui/masterCardAdd.dart';
import 'package:ride/widgets/widget.dart';

class masterCardListView extends StatefulWidget {
  @override
  _masterCardListViewState createState() => _masterCardListViewState();
}

class _masterCardListViewState extends State<masterCardListView> {
  mobXclass mobx = mobXclass();
  var _creditCards = [
    CreditCard(
      cardBackground: SolidColorCardBackground(Colors.black.withOpacity(0.6)),
      cardNetworkType: CardNetworkType.visaBasic,
      // cardHolderName: 'The boring developer',
      cardNumber: '1234 1234 1234 1234',
      // company: CardCompany.yesBank,
      validity: Validity(
        validThruMonth: 1,
        validThruYear: 21,
        validFromMonth: 1,
        validFromYear: 16,
      ),
    ),
    CreditCard(
      cardBackground: SolidColorCardBackground(Colors.black.withOpacity(0.6)),
      cardNetworkType: CardNetworkType.visaBasic,
      // cardHolderName: 'The boring developer',
      cardNumber: '1234 1234 1234 1234',
      // company: CardCompany.yesBank,
      validity: Validity(
        validThruMonth: 1,
        validThruYear: 21,
        validFromMonth: 1,
        validFromYear: 16,
      ),
    ),
    CreditCard(
      cardBackground: SolidColorCardBackground(Colors.black.withOpacity(0.6)),
      cardNetworkType: CardNetworkType.visaBasic,
      // cardHolderName: 'The boring developer',
      cardNumber: '1234 1234 1234 1234',
      // company: CardCompany.yesBank,
      validity: Validity(
        validThruMonth: 1,
        validThruYear: 21,
        validFromMonth: 1,
        validFromYear: 16,
      ),
    ),
    CreditCard(
      cardBackground: SolidColorCardBackground(Colors.black.withOpacity(0.6)),
      cardNetworkType: CardNetworkType.visaBasic,
      // cardHolderName: 'The boring developer',
      cardNumber: '1234 1234 1234 1234',
      // company: CardCompany.yesBank,
      validity: Validity(
        validThruMonth: 1,
        validThruYear: 21,
        validFromMonth: 1,
        validFromYear: 16,
      ),
    ),
    CreditCard(
      cardNetworkType: CardNetworkType.visa,
      // cardHolderName: 'THE BORING DEVELOPER',
      cardNumber: '2434 2434 **** ****',
      company: CardCompany.sbi,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white[100]),
        title: whitecolortextwidget('Save Cards'),
      ),
      body: Center(
        child: CreditCardSlider(
          _creditCards,
          repeatCards: RepeatCards.bothDirection,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>masterCard()));
        },
        child: Icon(Icons.add,color: AppColors.white[100],),
        backgroundColor: AppColors.black[100],
      ),
    );
  }
}
