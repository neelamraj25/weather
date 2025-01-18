import 'dart:convert';

import '../model/weather_data_model.dart';
import 'package:http/http.dart' as http;

Future<WeatherData> fetchWeatherFromAPI({
  String? location,
  double? latitude,
  double? longitude,
}) async {
  String apiUrl;
  const apiKey = "2e86b83fbdf868ebc82466afc268c211";

  if (location != null) {
    apiUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$apiKey&units=metric';
  } else if (latitude != null && longitude != null) {
    apiUrl =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
  } else {
    throw Exception('Location data is missing');
  }

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return WeatherData(
      temperature: '${data['list'][0]['main']['temp']}°C',
      description: data['list'][0]['weather'][0]['description'],
      iconUrl:
          'https://openweathermap.org/img/wn/${data['list'][0]['weather'][0]['icon']}@2x.png',
      windSpeed: '${data['list'][0]['wind']['speed']} m/s',
      humidity: '${data['list'][0]['main']['humidity']}%',
      visibility: '${data['list'][0]['visibility']} m',
      forecast: data['list']
          .map((forecast) => WeatherData(
                temperature: '${forecast['main']['temp']}°C',
                description: forecast['weather'][0]['description'],
                iconUrl:
                    'https://openweathermap.org/img/wn/${forecast['weather'][0]['icon']}@2x.png',
              ))
          .toList(),
    );
  } else {
    throw Exception('Failed to load weather data');
  }
}

