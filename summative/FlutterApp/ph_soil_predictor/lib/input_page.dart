import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final Map<String, TextEditingController> controllers = {};
  final Map<String, String> labels = {
    'nitrogen': 'Nitrogen (0-200)',
    'phosphorus': 'Phosphorus (0-100)',
    'potassium': 'Potassium (0-150)',
    'temperature': 'Temperature (0-40°C)',
    'humidity': 'Humidity (0-100%)',
    'rainfall': 'Rainfall (0-30cm)',
    'elevation': 'Elevation (0-1000m)',
    'slope': 'Slope (0-90°)',
    'aspect': 'Aspect (0-360°)',
    'water_holding_capacity': 'Water Holding Capacity (0-100%)',
    'wind_speed': 'Wind Speed (0-50 km/h)',
    'solar_radiation': 'Solar Radiation (0-300 W/m²)',
    'ec': 'EC (0-2 dS/m)',
    'zn': 'Zinc (0-5 ppm)',
    'soil_texture_Loam': 'Loam (0-1)',
    'soil_texture_Sandy': 'Sandy (0-1)',
    'soil_texture_Sandy_Clay': 'Sandy Clay (0-1)',
    'soil_texture_Sandy_Loam': 'Sandy Loam (0-1)',
  };
  final Map<String, List<double>> validRanges = {
    'nitrogen': [0, 200], 'phosphorus': [0, 100], 'potassium': [0, 150],
    'temperature': [0, 40], 'humidity': [0, 100], 'rainfall': [0, 30],
    'elevation': [0, 1000], 'slope': [0, 90], 'aspect': [0, 360],
    'water_holding_capacity': [0, 100], 'wind_speed': [0, 50],
    'solar_radiation': [0, 300], 'ec': [0, 2], 'zn': [0, 5],
    'soil_texture_Loam': [0, 1], 'soil_texture_Sandy': [0, 1],
    'soil_texture_Sandy_Clay': [0, 1], 'soil_texture_Sandy_Loam': [0, 1],
  };
  final Map<String, bool> isValid = {};
  bool isLoading = false;
  
  @override
  void initState() {
    super.initState();
    labels.keys.forEach((key) {
      controllers[key] = TextEditingController();
      isValid[key] = true;
    });
  }

  void validateInput(String key, String value) {
    setState(() {
      if (value.isEmpty) {
        isValid[key] = false;
        return;
      }
      final numValue = double.tryParse(value);
      if (numValue == null || numValue < validRanges[key]![0] || numValue > validRanges[key]![1]) {
        isValid[key] = false;
      } else {
        isValid[key] = true;
      }
    });
  }

  bool get isFormValid => isValid.values.every((valid) => valid) && controllers.values.every((c) => c.text.isNotEmpty);

  void _resetFields() {
    for (var controller in controllers.values) {
      controller.clear();
    }
    setState(() {
      isValid.updateAll((key, value) => true);
    });
  }

  Future<void> _predictpH(BuildContext context) async {
    if (!isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid values within range.')),
      );
      return;
    }

    setState(() => isLoading = true);
    
    Map<String, dynamic> inputData = controllers.map((key, controller) =>
      MapEntry(key, double.parse(controller.text)));
    
    try {
      final response = await http.post(
        Uri.parse('https://ph-prediction-api.onrender.com/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(inputData),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        bool shouldReset = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(prediction: decodedResponse['prediction'].toString()),
          ),
        ) ?? false;

        if (shouldReset) {
          _resetFields();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Network error or API unavailable.')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildInputField(String key) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: isValid[key]! ? Colors.grey.shade300 : Colors.red),
      ),
      child: TextField(
        controller: controllers[key],
        onChanged: (value) => validateInput(key, value),
        decoration: InputDecoration(
          labelText: labels[key],
          border: InputBorder.none,
          errorText: isValid[key]! ? null : 'Invalid range',
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil pH Predictor'),
        backgroundColor: Colors.green[700],
      ),
      backgroundColor: Colors.amber[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ...labels.keys.map((key) => _buildInputField(key)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading || !isFormValid ? null : () => _predictpH(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Predict pH', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
