import 'package:flutter/material.dart';
import 'input_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50], // Light beige background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to pH Soil Predictor!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700], // Deep green title
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'This app helps you predict soil pH based on various environmental and soil factors. Input the required data, and we will provide an estimated pH value.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown[600], // Dark brown description
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const InputPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400], // Warm brown button
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Start Predicting'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}