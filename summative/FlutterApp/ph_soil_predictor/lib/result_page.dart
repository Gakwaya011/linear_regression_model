import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String prediction;

  const ResultPage({Key? key, required this.prediction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Result'),
        backgroundColor: Colors.green[700],
      ),
      backgroundColor: Colors.amber[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                prediction.startsWith('Error') ? prediction : 'Predicted pH: $prediction',
                style: TextStyle(
                  fontSize: 20,
                  color: prediction.startsWith('Error') ? Colors.red : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true); // Pass true to indicate input reset
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Back to Input'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}