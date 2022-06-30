import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_truckz/login_screen.dart';
import 'package:food_truckz/registration_screen.dart';
import 'package:food_truckz/welcome_screen.dart';
import 'package:food_truckz/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FoodTruckz());
}

class FoodTruckz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MapScreen.id: (context) => MapScreen(),
      },
    );
  }
}
