import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:ride/Constants/varaibleAssets.dart';
part 'mobX_store.g.dart';


class mobXclass extends _mobXclass with _$mobXclass{

}

abstract class _mobXclass with Store{
  @observable
   String count,placeDistance,trackriderTime;
   PolylineId newid = PolylineId('bc');
   @observable
    Set<Marker> markers = {};
  @observable
  Set<Marker> drivemarker = {};
  @observable
  Set<Circle> circle = {};
   @observable
    Map<PolylineId, Polyline> polylines = {};
   @observable
    Map<PolylineId, Polyline> trackpolylines = {};
  @observable
  Map<PolylineId, Polyline> drivepolyline = {};
  @observable
  String startAddress;
  // @action
  // void chnagelocation(Position position){
  //   count =position.toString();
  //   Secrets.currentPosition = position;
  // }
  @action
  getCurrentLocation() async {
    print("HAmmmmza");
    await Secrets.geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      print("HAMza");
      Secrets.currentPosition = position;
      print("two");
      // Secrets.currentPosition = position;
      Secrets.mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(Secrets.currentPosition.latitude, Secrets.currentPosition.longitude),
            zoom: 18,
          ),
        ),
      );
      print("current location"+Secrets.currentPosition.toString());
      //   geolocator.getPositionStream().listen((event) {
      //     print("track" + event.toString());
      //       dono = event;
      //   Secrets.showornot = false;
      //
      // });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }
   @action
   _getAddress() async {
     try {
       var p = await placemarkFromCoordinates(
           Secrets.currentPosition.latitude, Secrets.currentPosition.longitude);

       var place = p[0];
        Secrets.currentAddress =
         "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
         Secrets.startAddressController.text = Secrets.currentAddress;
         startAddress = Secrets.currentAddress;
         print('adress'+startAddress.toString());
     } catch (e) {
       print(e);
     }
   }

  @action
  Future changestate (var lati,var long , int num){
    if(num == 1){
      Secrets.polylineCoordinates.add(LatLng(lati,long));
    }else{
      Secrets.trackpolylineCoordinates.add(LatLng(lati,long));
    }
  }

  @action
  Future cretate (Polyline polyline){

    print('nikal'+trackpolylines.length.toString());
  }

  @action
  Future marker (Marker marker){
   markers.add(marker);
   print('maeker'+markers.length.toString());
  }

 @action
  Future<bool> calculateDistance() async {
    try {
      List<Location> startPlacemark = await locationFromAddress(Secrets.startAddress);
      List<Location> destinationPlacemark =
      await locationFromAddress(Secrets.destinationAddress);

      if (startPlacemark != null && destinationPlacemark != null) {
         Secrets.startCoordinates = Secrets.startAddress == Secrets.currentAddress
            ? Position(
            latitude: Secrets.currentPosition.latitude,
            longitude: Secrets.currentPosition.longitude)
            : Position(
            latitude: startPlacemark[0].latitude,
            longitude: startPlacemark[0].longitude);
        print("place" +
            destinationPlacemark.length.toString() +
            "startplace" +
            startPlacemark.length.toString());
         Secrets.destinationCoordinates = Position(
            latitude: destinationPlacemark[0].latitude,
            longitude: destinationPlacemark[0].longitude);
        print("place1" +
            Secrets.startCoordinates.toString() +
            "startplace" +
            Secrets.destinationCoordinates.toString());

        print("place2" +
            Secrets.startCoordinates.toString() +
            "startplace" +
            Secrets.destinationCoordinates.toString());

        Marker startMarker = Marker(
            rotation: Secrets.startCoordinates.heading,
            markerId: MarkerId('$Secrets.Secrets.startCoordinates'),
            position: LatLng(
              Secrets.startCoordinates.latitude,
              Secrets.startCoordinates.longitude,
            ),
            infoWindow: InfoWindow(
              title: 'start I  Weather',
              snippet: Secrets.startAddress + "  I " + Secrets.startweather.toString(),
            ),
            icon: Secrets.Clear1);

        Marker destinationMarker = Marker(
          rotation: Secrets.destinationCoordinates.heading,
          markerId: MarkerId('$Secrets.Secrets.destinationCoordinates'),
          position: LatLng(
            Secrets.destinationCoordinates.latitude,
            Secrets.destinationCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Destination I  Weather',
            snippet: Secrets.destinationAddress + "I" + Secrets.desweather.toString(),
          ),
          icon: Secrets.usericon,
        );
        print("place3" +
            Secrets.startCoordinates.toString() +
            "startplace" +
            Secrets.destinationCoordinates.toString());
        markers.add(startMarker);
         markers.add(destinationMarker);

        print("place" +
            Secrets.startCoordinates.toString() +
            "startplace" +
            Secrets.destinationCoordinates.toString());
        print('START COORDINATES: $Secrets.startCoordinates');
        print('DESTINATION COORDINATES: $Secrets.destinationCoordinates');

        Position _northeastCoordinates;
        Position _southwestCoordinates;

        double miny =
        (Secrets.startCoordinates.latitude <= Secrets.destinationCoordinates.latitude)
            ? Secrets.startCoordinates.latitude
            : Secrets.destinationCoordinates.latitude;
        double minx =
        (Secrets.startCoordinates.longitude <= Secrets.destinationCoordinates.longitude)
            ? Secrets.startCoordinates.longitude
            : Secrets.destinationCoordinates.longitude;
        double maxy =
        (Secrets.startCoordinates.latitude <= Secrets.destinationCoordinates.latitude)
            ? Secrets.destinationCoordinates.latitude
            : Secrets.startCoordinates.latitude;
        double maxx =
        (Secrets.startCoordinates.longitude <= Secrets.destinationCoordinates.longitude)
            ? Secrets.destinationCoordinates.longitude
            : Secrets.startCoordinates.longitude;

        _southwestCoordinates = Position(latitude: miny, longitude: minx);
        _northeastCoordinates = Position(latitude: maxy, longitude: maxx);
        Secrets.mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: LatLng(
                _northeastCoordinates.latitude,
                _northeastCoordinates.longitude,
              ),
              southwest: LatLng(
                _southwestCoordinates.latitude,
                _southwestCoordinates.longitude,
              ),
            ),
            100.0,
          ),
        );

        await createPolylines(Secrets.startCoordinates, Secrets.destinationCoordinates,1);
        getTime(Secrets.startCoordinates.latitude,Secrets.startCoordinates.longitude,Secrets.destinationCoordinates.latitude,Secrets.destinationCoordinates.longitude,1);
        double totalDistance = 0.0;
        for (int i = 0; i < Secrets.polylineCoordinates.length - 1; i++) {
          totalDistance += _coordinateDistance(
            Secrets.polylineCoordinates[i].latitude,
            Secrets.polylineCoordinates[i].longitude,
            Secrets.polylineCoordinates[i + 1].latitude,
            Secrets.polylineCoordinates[i + 1].longitude,
          );
        }
        placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: '+  placeDistance.toString() +' km');
        return true;
      } else {
        print("dddd");
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
  @action
//region calulate total ditance between two points
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
//endregion
  @action
  //region Get estimated time by google map api
   getTime(double latitude, double longitude, double latitude2,
      double longitude2,int num) async {
    Dio dio = new Dio();
    Response response = await dio.get(
        Secrets.EstimatedTimeurl+
            latitude.toString() +
            "," +
            longitude.toString() +
            "&destinations=" +
            latitude2.toString() +
            "," +
            longitude2.toString() +
            "&key=" +
            Secrets.API_KEY);
    var result = json.decode(response.toString());
    print("estimated time" +
        result['rows'][0]['elements'][0]['duration']['text'].toString());
    if(num == 1){
      Secrets.esitimatedTime = result['rows'][0]['elements'][0]['duration']['text'].toString();
    }else if(num == 2){
      trackriderTime = result['rows'][0]['elements'][0]['duration']['text'].toString();
    }

  }

//endregion
  @action
//region make polyline on map between start point to end point
  Future<void> createPolylines(Position start, Position destination,int num) async {
    print('startjaaa'+start.toString());
    print('desjaja'+destination.toString());
    Secrets.polylinePoints = PolylinePoints();
    PolylineResult result = await  Secrets. polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );


    GoogleMapPolyline googleMapPolyline =
    GoogleMapPolyline(apiKey: Secrets.API_KEY);
    List<LatLng> re = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(start.latitude, start.longitude),
        destination: LatLng(destination.latitude, destination.longitude),
        mode: RouteMode.driving);

    if (re.isNotEmpty) {
      print("new cheak" +  Secrets.polylineCoordinates.length.toString());
      re.forEach((element) {
        print('hamza polyline');
        changestate(element.latitude, element.longitude,1);
        // Secrets.polylineCoordinates.add(LatLng(element.latitude, element.longitude));
      });
    }

    print("cheak" +  Secrets.polylineCoordinates.length.toString());
    print("poins length" + result.points.length.toString());
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppColors.black[100],
      points:  Secrets.polylineCoordinates,
      width: 6,
    );
      polylines[id] = polyline;
    polyline.points.forEach((element) {
      print("cheak kre" + element.latitude.toString());
    });
  }

//endregion



  @action
  void changeCameraPosition(Position currentposition){
    print('camera position');
    Secrets.mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentposition.latitude, currentposition.longitude),
          zoom: 18,
        ),
      ),
    );
  }
  @action
  void placemarker(Position position) {
    LatLng latLng =LatLng(Secrets.currentPosition.latitude, Secrets.currentPosition.longitude);
    Marker driver = Marker(
        markerId: MarkerId('driver'),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
        draggable: false,
        flat: true,
        zIndex: 2,
        rotation: Secrets.currentPosition.heading,
        anchor: Offset(0.5,0.5),
        icon: Secrets.Clear1);

    Marker user = Marker(
        markerId: MarkerId('drivere'),
        position: LatLng(
          Secrets.currentPosition.latitude,
          Secrets.currentPosition.longitude,
        ),
        draggable: false,
        flat: true,
        zIndex: 2,
        rotation: Secrets.currentPosition.heading,
        anchor: Offset(0.5,0.5),
        icon: Secrets.usericon);
    Circle newcir = Circle(
      circleId: CircleId('one'),
      radius: Secrets.currentPosition.accuracy,
      zIndex: 1,
      center: latLng,
      fillColor: Colors.blue.withAlpha(70),
    );
      Secrets.trackridermarker.add(driver);
      Secrets.trackridermarker.add(user);
      Secrets.trackridercircle.add(newcir);
  }

@action
  Future<void> jajaj(Position start, Position destination) async {
    Secrets.drivepolylinePoints = PolylinePoints();
    PolylineResult result = await  Secrets. drivepolylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );

    GoogleMapPolyline googleMapPolyline =
    GoogleMapPolyline(apiKey: Secrets.API_KEY);
    List<LatLng> re = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(start.latitude, start.longitude),
        destination: LatLng(destination.latitude, destination.longitude),
        mode: RouteMode.driving);
    if (re.isNotEmpty) {
      print("track cheak" +  Secrets.drivepolylineCoordinates.length.toString());
      re.forEach((element) {
        print('track polyline');
        // changestate(element.latitude, element.longitude, 2);
        Secrets.drivepolylineCoordinates.add(LatLng(element.latitude, element.longitude));
      });
    }

    print("track cheak1" +  Secrets.drivepolylineCoordinates.length.toString());
    print("track poins length" + result.points.length.toString());
    PolylineId mmm = PolylineId('vvvv');
    Polyline polyline = Polyline(
      polylineId: mmm,
      color: AppColors.black[100],
      points:  Secrets.drivepolylineCoordinates,
      width: 6,
    );
      drivepolyline[newid] = polyline;
    polyline.points.forEach((element) {
      print("drive" + element.toString());
    });
  }
}