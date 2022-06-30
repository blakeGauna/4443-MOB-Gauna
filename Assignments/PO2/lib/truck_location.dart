import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> getJsonFromFirebaseRestApi() async {
  String url = "https://food-truckz-default-rtdb.firebaseio.com/truck_locations.json";
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

class Truck{
  Truck(
  this.city, this.email, this.firstname, this.foodtype, this.id, this.lastname, this.lat, this.lng, this.phone, this.state, this.truckcolor, this.truckname, this.truckurl);

  final String city;
  final String email;
  final String firstname;
  final String foodtype;
  final int id;
  final String lastname;
  final double lat;
  final double lng;
  final String phone;
  final String state;
  final String truckcolor;
  final String truckname;
  final String truckurl;

  factory Truck.fromJson(Map<String, dynamic> parsedJson){
    return Truck(parsedJson['city'].toString(), parsedJson['email'].toString(), parsedJson['first_name'].toString(), parsedJson['food_type'].toString(), parsedJson['id'].toInt(), parsedJson['last_name'].toString(), parsedJson['lat'].toDouble(), parsedJson['lng'].toDouble(), parsedJson['phone'].toString(), parsedJson['state'].toString(), parsedJson['truck_color'].toString(), parsedJson['truck_name'].toString(), parsedJson['url'].toString());
  }

}