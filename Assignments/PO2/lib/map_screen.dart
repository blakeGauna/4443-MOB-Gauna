import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:food_truckz/truck_location.dart';
// import 'src/locations.dart' as locations;

class MapScreen extends StatefulWidget {
  static const String id = 'map_screen';

  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Map<String, Marker> _markers = {};
  final List<Truck> truckLocations = [];
  Future loadTruckData() async {
      String jsonString = await getJsonFromFirebaseRestApi();
      final jsonResponse = jsonDecode(jsonString);
      setState((){
        for (Map<String, dynamic> i in jsonResponse) {
          truckLocations.add(Truck.fromJson(i));
        }
      });
    }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    await loadTruckData();
      setState(() {
        for (int i = 0; i < truckLocations.length; i++) {
          final marker = Marker(
            markerId: MarkerId(truckLocations[i].truckname),
            position: LatLng(truckLocations[i].lat, truckLocations[i].lng),
            infoWindow: InfoWindow(
              title: truckLocations[i].truckname,
              snippet: truckLocations[i].phone,
            ),
          );
          _markers[truckLocations[i].truckname] = marker;
        }
  });
  }
  // final Set<Marker> _markers = {};
  // List<Truck> truckLocations = [];
  //
  // void _onMapCreated(GoogleMapController controller){
  //   setState((){
  //     for(int i = 0; i > truckLocations.length; i++) {
  //       _markers.add(
  //           Marker(
  //               markerId: MarkerId(truckLocations[i].truckname),
  //               position: LatLng(truckLocations[i].lat, truckLocations[i].lng)
  //           )
  //       );
  //     }
  //   });
  // }
  //
  //
  // Future loadTruckData() async {
  //   String jsonString = await getJsonFromFirebaseRestApi();
  //   final jsonResponse = jsonDecode(jsonString);
  //   setState((){
  //     for (Map<String, dynamic> i in jsonResponse) {
  //       truckLocations.add(Truck.fromJson(i));
  //     }
  //   });
  // }
  //
  // @override
  // void initState(){
  //   loadTruckData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Food Truck Locations'),
          backgroundColor: Colors.red[300],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(33.964683, -98.51316),
            zoom: 10,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}