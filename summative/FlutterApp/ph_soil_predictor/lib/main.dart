import 'package:flutter/material.dart';
import 'package:ph_soil_predictor/welcome_page.dart';
// import 'input_page.dart'; // Import the InputPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'pH Soil Predictor',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WelcomePage(), // Set InputPage as the home page
    );
  }
}