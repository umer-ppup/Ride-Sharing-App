// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:ride/Models/signUpRequestModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Secrets {
  // Add your Google Maps API Key here
  static const API_KEY = 'AIzaSyCTgG9bky31CZBNcTHTrjBvGl4vPdDPwcY';


  static const EstimatedTimeurl =  "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=" ;

  //Google map controller
  static  GoogleMapController mapController;
  static  GoogleMapController trackmapCOntroller;
  //Strings that are you to assign values
  // @observable
  // static Set<Marker> markers = {};
  @observable
  static String desweather,startweather,tapweather,tapvisibility,
      hourtem,visi1,humidity,duepoint,dewpoint,humadity,currentAddress,
      startAddress,destinationAddress,esitimatedTime ;
  //button according to conditions that are use
  static bool enable=false,showornot = true,routeshow = false;
  //set markers on marker through this..

  //set icon that are shon on map
  static BitmapDescriptor ICONICON;
  //icons short cut because api call in loop and then it make an issue
  static  BitmapDescriptor Haze1, Clear1, mist1, rainy1, cloud1, smoke1, elseno, startflag, desflag,usericon;

  static CameraPosition initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  //Google Map camera zoom
  static  double CAMERA_ZOOM = 16;
  static double CAMERA_TILT = 80;
  static double pinPillPosition = -100;
  static double CAMERA_BEARING = 30;
  //user select how many KM after he want to see weather
  static String UserKmDistance;
  //By defult KM
  static String KmDistance = '50';

  // static PolylinePoints polylinePoints;
  static PolylinePoints polylinePoints;
  @observable
  static List<LatLng> polylineCoordinates = [];
  @observable
  static PolylinePoints trackpolylinePoints;
  @observable
  static List<LatLng> trackpolylineCoordinates = [];
  @observable
  static PolylinePoints drivepolylinePoints;
  @observable
  static List<LatLng> drivepolylineCoordinates = [];

  @observable
  static Position currentPosition;

  static final Geolocator geolocator = Geolocator();
  @observable
  static final startAddressController = TextEditingController();

  static final destinationAddressController = TextEditingController();

  static bool bottomsheetenableornot=false;

  static Set<Marker> trackridermarker = {};
  static Set<Circle> trackridercircle = {};
  static String userId,vechileId,paymentId,totalfear;

  static bool conditionCheak = false;
  static SharedPreferences prefs;
  static List items;
  static double ratingTotal;
  static TextEditingController submitreviewController;

  static final kEmailValidatorRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  static final kPasswordValidatorRegExp =
  RegExp(r"^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$");
  static final RegExp kPhoneValidatorRegExp =
  RegExp(r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$");

  static Position startCoordinates,destinationCoordinates;
  static List<signUpPostModel> data = [];
}