import 'package:flutter/material.dart';
import 'package:weather/home/screen/widgets/location_input.dart';
import 'package:weather/home/screen/widgets/weather_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LocationInput(),
            const Expanded(child: WeatherDisplay()),
          ],
        ),
      ),
    );
  }
}
