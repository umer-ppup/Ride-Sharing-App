import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride/Constants/varaibleAssets.dart';
import 'package:ride/mobX/mobX_store.dart';
import 'package:ride/widgets/widget.dart';
import 'package:ride/Constants/appcolor.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class trackRiderScreen extends StatefulWidget {
  @override
  _trackRiderScreenState createState() => _trackRiderScreenState();
}

class _trackRiderScreenState extends State<trackRiderScreen> {
  SolidController _controller = SolidController();
  Position position =Position(latitude: 31.47662453359844,longitude:74.2735904551365 );
  Position desti =Position(latitude:Secrets.startCoordinates.latitude,longitude: Secrets.startCoordinates.latitude );
  mobXclass mobx = mobXclass();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     trackRiderBottomAppBar(context);
    });
    mobx.placemarker(position);
    mobx.getTime(position.latitude, position.longitude, desti.latitude, desti.longitude,2);
    polulinefortrackrider(position, Secrets.startCoordinates);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: AppColors.white[100]),
        title: InkWell(
          onTap: (){
       polulinefortrackrider(position,desti);
          },
          child: whitecolortextwidget('Track Rider'),
        ),
        brightness: Brightness.dark,
      ),
      body: Observer(
        builder: (context){
          return Stack(
            children: [
              GoogleMap(
                markers: Secrets.trackridermarker  != null
                    ? Set<Marker>.from(Secrets.trackridermarker )
                    : null,
                initialCameraPosition: Secrets.initialLocation,
                // myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                compassEnabled: true,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                polylines: Set<Polyline>.of(mobx.trackpolylines.values),
                onMapCreated: (GoogleMapController controller) {
                  Secrets.trackmapCOntroller = controller;
                  Secrets.trackmapCOntroller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(position.latitude,position.longitude),
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
        onPressed: () async{
          trackRiderBottomAppBar(context);
          // await mobx.polulinefortrackrider(position,desti);
          },
        icon: Icon(Icons.arrow_drop_up_outlined,size: 40.0,color: AppColors.white[100],),
        label: whitecolortextwidget("Tap to see all information"),
      ),
    );
  }

  Future<void> polulinefortrackrider(Position start, Position destination) async {
    mobx.trackpolylines.clear();
    Secrets.trackpolylinePoints = PolylinePoints();
    PolylineResult result = await  Secrets. trackpolylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );

    GoogleMapPolyline googleMapPolyline =
    GoogleMapPolyline(apiKey: Secrets.API_KEY);
    List<LatLng> re = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(start.latitude, start.longitude),
        destination: LatLng(Secrets.currentPosition.latitude, Secrets.currentPosition.longitude),
        mode: RouteMode.driving);
    if (re.isNotEmpty) {
      print("track cheak" +  Secrets.trackpolylineCoordinates.length.toString());
      re.forEach((element) {
        print('track polyline');
        mobx.changestate(element.latitude, element.longitude, 2);
        // Secrets.trackpolylineCoordinates.add(LatLng(element.latitude, element.longitude));
      });
    }
    print("track cheak1" +  Secrets.trackpolylineCoordinates.length.toString());
    print("track poins length" + result.points.length.toString());
    PolylineId id = PolylineId('new');
    Polyline polyline = Polyline(
      polylineId: mobx.newid,
      color: AppColors.black[100],
      points:  Secrets.trackpolylineCoordinates,
      width: 6,
    );
    setState(() {
      mobx.trackpolylines[id] = polyline;
    });
    polyline.points.forEach((element) {
      print("new kre" + element.toString());
    });
  }
}
