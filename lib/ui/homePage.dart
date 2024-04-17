import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/assets.dart';
import 'package:ride/Constants/varaibleAssets.dart';
import 'package:ride/Drawer/drawer.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/ui/loginScreen.dart';
import 'package:ride/widgets/widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:shared_preferences/shared_preferences.dart';


class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  mobXclass mobx = mobXclass();
  bool hide = false;
  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefs();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        drawer: NavDrawe(),
        appBar: AppBar(
          title: whitecolortextwidget(Assets.Appname),
          iconTheme: IconThemeData(color: AppColors.white[100]),
          brightness: Brightness.dark,
          actions: [
            !hide ?InkWell(
                onTap: () {
                  // getCurrentLocation();
                  setState(() {
                    if (Secrets.bottomsheetenableornot) {
                     ;
                      Secrets.startCoordinates != null ? Secrets.bottomsheetenableornot = false:print('object');
                    } else {
                      Secrets.startCoordinates != null ? Secrets.bottomsheetenableornot = true:print('object');
                    }
                  });

                  // mobx.getCurrentLocation();
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      Secrets.routeshow ? 'More' : 'Less',
                      style: TextStyle(
                          fontFamily: 'lily',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )):Container()
          ],
        ),
        body: Observer(
          builder: (context) {
            return Stack(
              children: <Widget>[
                // Map View
                GoogleMap(
                  markers: mobx.markers != null
                      ? Set<Marker>.from(mobx.markers)
                      : null,
                  circles: mobx.circle != null
                      ? Set<Circle>.from(mobx.circle)
                      : null,
                  initialCameraPosition: Secrets.initialLocation,
                  // myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  compassEnabled: true,
                  tiltGesturesEnabled: false,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  polylines: Set<Polyline>.of(mobx.polylines.values),
                  onMapCreated: (GoogleMapController controller) {
                    Secrets.mapController = controller;
                  },
                ),

                // Show zoom buttons
                Secrets.bottomsheetenableornot != true
                    ? Positioned(
                     bottom: 30.0,
                      child: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Material(
                              color: AppColors.black[100], // button color
                              child: InkWell(
                                splashColor: AppColors.black[100],
                                // inkwell color
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.white[100],
                                  ),
                                ),
                                onTap: () {
                                  Secrets.mapController.animateCamera(
                                    CameraUpdate.zoomIn(),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ClipOval(
                            child: Material(
                              color: AppColors.black[100], // button color
                              child: InkWell(
                                splashColor: AppColors.black[100],
                                // inkwell color
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    Icons.remove,
                                    color: AppColors.white[100],
                                  ),
                                ),
                                onTap: () {
                                  handelmarker();
                                  Secrets.mapController.animateCamera(
                                    CameraUpdate.zoomOut(),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                  ),
                ),
                    )
                    : Container(),
                // Show the place input fields & button for
                // showing the route

                Secrets.bottomsheetenableornot != true
                    ? SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          width: width * 0.9,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 10.0),
                                    child: Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        border: Border.all(
                                            color: Colors.grey[400]),
                                      ),
                                      child: SearchMapPlaceWidget(
                                        apiKey: Secrets.API_KEY,
                                        icon: Icons.my_location,
                                        iconColor: AppColors.black[100],
                                        placeType: PlaceType.address,
                                        placeholder: mobx.startAddress !=
                                            null
                                            ? mobx.startAddress.toString()
                                            : 'Start Address',
                                        onSelected: (Place place) async {
                                          setState(() {
                                            Secrets.startAddressController
                                                .text = place.description.toString();
                                            Secrets.startAddress =
                                                place.description.toString();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 10.0),
                                    child: Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        border: Border.all(
                                            color: Colors.grey[400]),
                                      ),
                                      child: SearchMapPlaceWidget(
                                        apiKey: Secrets.API_KEY,
                                        icon: Icons.place,
                                        iconColor: AppColors.black[100],
                                        placeType: PlaceType.address,
                                        placeholder: Secrets
                                            .destinationAddress !=
                                            null
                                            ? Secrets.destinationAddress
                                            .toString()
                                            : 'Destination Address',
                                        onSelected: (Place place) async {
                                          setState(() {
                                            print("placesssss" +
                                                place.description
                                                    .toString());
                                            Secrets.destinationAddressController
                                                .text =
                                                place.description
                                                    .toString();
                                            Secrets.destinationAddress =
                                                place.description
                                                    .toString();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Visibility(
                                    visible: mobx.placeDistance == null
                                        ? false
                                        : true,
                                    child: Text(
                                      'DISTANCE ' +
                                          mobx.placeDistance
                                              .toString() +
                                          ' km',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black[100]
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  RaisedButton(
                                    padding: const EdgeInsets.all(8.0),
                                    color: AppColors.black[100],
                                    onPressed: () {
                                      setState(() {
                                        if (Secrets.startAddress != '' &&
                                            Secrets.destinationAddress !=
                                                '') {
                                          setState(() {
                                            Secrets.startAddress =
                                                mobx.startAddress;
                                            print('Nahiiiiii' +
                                                mobx.markers.length.toString());
                                            if (mobx.markers.isNotEmpty)
                                              mobx.markers.clear();

                                            if (mobx
                                                .polylines.isNotEmpty)
                                              mobx.polylines.clear();
                                            if (Secrets
                                                .polylineCoordinates
                                                .isNotEmpty)
                                              Secrets.polylineCoordinates
                                                  .clear();
                                            mobx.placeDistance = null;
                                            Secrets.UserKmDistance = '0';
                                          });

                                          mobx.calculateDistance()
                                              .then((isCalculated) {
                                            if (isCalculated) {
                                              print("succes" +
                                                  mobx.placeDistance
                                                      .toString());
                                              setState(() {
                                               hide = true;
                                              });
                                            } else {
                                              print("failed");
                                            }
                                          });
                                        } else {
                                          print('new fail');
                                        }
                                      });
                                    },
                                    child: whitecolortextwidget(
                                        "Show Route"),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                )
                    : Container(),
                // Show current location button
                if (Secrets.bottomsheetenableornot)
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 400.0,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.white[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Image.asset(
                                Assets.hideanimation,
                                height: 200.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: textwidget('TO Location', Assets.font1)),
                                  Expanded(child:   textwidget(
                                        Secrets.destinationAddress != null ? Secrets
                                            .destinationAddress : '', Assets.font1),
                                  )

                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: textwidget(
                                        'From Location', Assets.font1),
                                  ),
                                  Expanded(child:  textwidget(
                                      mobx.startAddress != null ? mobx
                                          .startAddress : '', Assets.font1),)

                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: textwidget(
                                        'Total Distance', Assets.font1),
                                  ),
                                  Expanded(
                                    child:  textwidget(mobx.placeDistance != null ? mobx
                                        .placeDistance : '', Assets.font1),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: textwidget(
                                        'Expected Time', Assets.font1),
                                  ),
                                  Expanded(
                                    child:textwidget(
                                        Secrets.esitimatedTime != null ? Secrets
                                            .esitimatedTime : '', Assets.font1),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              RaisedButton(
                                padding: const EdgeInsets.all(8.0),
                                color: AppColors.black[100],
                                onPressed: () {
                                  setState(() {
                                    choicebottomsheet(context);
                                  });
                                },
                                child:
                                whitecolortextwidget("Book A Ride"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Container()
              ],
            );
          },
        ),
      floatingActionButton: new Visibility(
        visible: hide,
        child: new FloatingActionButton.extended(
          backgroundColor: AppColors.red[100],
          onPressed: (){
            setState(() {
              Secrets.bottomsheetenableornot = true;
              hide =false;
            });
          },
          tooltip: 'Book Ride',
          label: whitecolortextwidget('Tap to book a ride'),
        ),
      ),
    );
  }

  void handelmarker() {
    LatLng latLng =LatLng(Secrets.currentPosition.latitude, Secrets.currentPosition.longitude);
    Marker taap = Marker(
        markerId: MarkerId('tapweather'),
        position: LatLng(
          Secrets.currentPosition.latitude,
          Secrets.currentPosition.longitude,
        ),
        draggable: false,
        flat: true,
        zIndex: 2,
        rotation: Secrets.currentPosition.heading,
        anchor: Offset(0.5,0.5),
        icon: Secrets.Clear1);

       Circle newcir = Circle(
         circleId: CircleId('one'),
         radius: Secrets.currentPosition.accuracy,
         zIndex: 1,
         center: latLng,
         fillColor: Colors.blue.withAlpha(70),
       );
    setState(() {
      mobx.markers.add(taap);
      mobx.circle.add(newcir);
    });
  }

  //region make icon accordin to wather
  void makeicons() async {
    final Uint8List markerIconc = await getBytesFromAsset(Assets.caricon, 150);
    Secrets.Clear1 = BitmapDescriptor.fromBytes(markerIconc);
    final Uint8List usericon = await getBytesFromAsset(Assets.newusericon, 150);
    Secrets.usericon = BitmapDescriptor.fromBytes(usericon);

  }

//endregion

//region icon size adjust
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void getprefs() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String cheakLogin = prefs.getString('login');
    if(cheakLogin != '1'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }else{
      mobx.getCurrentLocation();
      makeicons();
      handelmarker();
    }
  }
//endregion
}