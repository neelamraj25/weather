import 'package:flutter/material.dart';
import 'package:weather/home/bloc/weather_state.dart';
import 'package:weather/home/screen/widgets/custom.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final WeatherLoaded state;

  const WeatherDetailsScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final weather = state.weatherData;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
        backgroundColor: Color(0xFF6FA8DC),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6FA8DC), Color(0xFF14274E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Image.network(
                        weather.iconUrl!,
                        width: size.width * 0.4,
                        height: size.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        weather.description!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${weather.temperature}°C',
                        style: const TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.white38, thickness: 1),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherInfoCard(
                            title: "Wind",
                            value: weather.windSpeed!,
                            icon: Icons.air,
                          ),
                          WeatherInfoCard(
                            title: "Humidity",
                            value: weather.humidity!,
                            icon: Icons.water_drop,
                          ),
                          WeatherInfoCard(
                            title: "Visibility",
                            value: weather.visibility!,
                            icon: Icons.visibility,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (weather.forecast != null && weather.forecast is List)
                        Column(
                          children: (weather.forecast as List).map((forecast) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${forecast.temperature}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    forecast.description,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
