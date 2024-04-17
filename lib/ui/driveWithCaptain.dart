import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:ride/Constants/varaibleAssets.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/widgets/widget.dart';


class driveWithCaptain extends StatefulWidget {
  @override
  _driveWithCaptainState createState() => _driveWithCaptainState();
}

class _driveWithCaptainState extends State<driveWithCaptain> {
  mobXclass mobx = mobXclass();
  Position position =Position(latitude: 31.47662453359844,longitude:74.2735904551365 );
  Position desti =Position(latitude:31.518355778712184,longitude: 74.30208991281022 );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    drivewithCaptainBottomsheet(context);
    });
    placemarker();
   jajaj(Secrets.startCoordinates, Secrets.destinationCoordinates);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context){
          return Stack(
            children: [
              GoogleMap(
                markers: mobx.drivemarker  != null
                    ? Set<Marker>.from(mobx.drivemarker )
                    : null,
                initialCameraPosition: Secrets.initialLocation,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                compassEnabled: true,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                polylines: Set<Polyline>.of(mobx.drivepolyline.values),
                onMapCreated: (GoogleMapController controller) {
                  Secrets.trackmapCOntroller = controller;
                  Secrets.trackmapCOntroller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(Secrets.startCoordinates.latitude,Secrets.startCoordinates.longitude),
                          zoom: 16,
                        ),
                      ));
                },
              ),

            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.black[100],
        onPressed: () {
          drivewithCaptainBottomsheet(context);
        },
        icon: Icon(Icons.arrow_drop_up_outlined,size: 40.0,color: AppColors.white[100],),
        label: whitecolortextwidget("Tap to see all information"),
      ),
    );
  }


  void placemarker() {
    LatLng latLng =LatLng(Secrets.startCoordinates.latitude, Secrets.startCoordinates.longitude);
    Marker start = Marker(
        markerId: MarkerId('driver'),
        position: LatLng(
          Secrets.startCoordinates.latitude,
          Secrets.startCoordinates.longitude,
        ),
        draggable: false,
        flat: true,
        zIndex: 2,
        rotation: Secrets.currentPosition.heading,
        anchor: Offset(0.5,0.5),
        icon: Secrets.Clear1);

    Marker destination = Marker(
        markerId: MarkerId('second'),
        position: LatLng(
          Secrets.destinationCoordinates.latitude,
          Secrets.destinationCoordinates.longitude,
        ),
        draggable: false,
        flat: true,
        rotation: Secrets.currentPosition.heading,
        anchor: Offset(0.5,0.5),
        icon: Secrets.usericon);

    setState(() {
      mobx.drivemarker.add(start);
      mobx.drivemarker.add(destination);
    });
  }
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
    setState(() {
      mobx.drivepolyline[mmm] = polyline;
    });
    polyline.points.forEach((element) {
      print("drive" + element.toString());
    });
  }

}
