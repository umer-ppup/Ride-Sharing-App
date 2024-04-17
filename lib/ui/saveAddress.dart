import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Json/previousRideJson.dart';
import 'package:ride/Models/completeRideModel.dart';
import 'package:ride/Models/previousRideModel.dart';
import 'package:ride/apiCalls/apiCalls.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/widgets/widget.dart';


class prviousRide extends StatefulWidget {
  @override
  _prviousRideState createState() => _prviousRideState();
}

class _prviousRideState extends State<prviousRide> {
  mobXclass mobx = mobXclass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: whitecolortextwidget('Previous Rides'),
        iconTheme: IconThemeData(color: AppColors.white[100]),
        brightness: Brightness.dark,
      ),
      body:Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: previousRideGetRequest('CREATE_URL'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext, index) {
                          completeRideModel PrviousRide = snapshot.data[index];
                          return Design(
                            to: PrviousRide.to,
                            from: PrviousRide.from,
                            total: PrviousRide.totalFear,
                          );
                        });
                  } else {
                    debugPrint('Step 1, build loading widget');
                    return Container();
                  }
                },
              ),
            ],
          )
        ),
      )
    );
  }

}


class Design extends StatelessWidget {
  final to,from,total;

  const Design({Key key, this.to, this.from, this.total}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              SizedBox(
                width: 80,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.grye[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Image.asset('assets/images/cariconnew.png',),
                  ),

                ),
              ),
              SizedBox(width: 20),
              Padding(
                padding: EdgeInsets.only(top: 10.0,bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Row(
                            children: [
                              Icon(Icons.location_on,color: AppColors.black[100],size: 20.0,),
                              SizedBox(width: 10.0,),
                              textwidget(to.toString(),15.0),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.house,color: AppColors.black[100],size: 20.0,),
                            SizedBox(width: 10.0,),
                            textwidget(from.toString(),15.0),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.map,color: AppColors.black[100],size: 20.0,),
                            SizedBox(width: 10.0,),
                            textwidget("8 Km",15.0),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.money_off,color: AppColors.black[100],size: 20.0,),
                            SizedBox(width: 10.0,),
                            textwidget("300",15.0),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
