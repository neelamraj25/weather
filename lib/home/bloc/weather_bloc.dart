import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather/home/bloc/weather_event.dart';
import 'package:weather/home/bloc/weather_state.dart';
import '../../model/weather_data_model.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<FetchWeatherByCurrentLocation>(_onFetchWeatherByCurrentLocation);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weatherData = await fetchWeatherFromAPI(location: event.location);
      emit(WeatherLoaded(weatherData));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather data'));
    }
  }

  Future<void> _onFetchWeatherByCurrentLocation(
    FetchWeatherByCurrentLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final locationData = await getLocation();
      final weatherData = await fetchWeatherFromAPI(
        latitude: locationData.latitude,
        longitude: locationData.longitude,
      );
      emit(WeatherLoaded(weatherData));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather data for current location'));
    }
  }

  Future<WeatherData> fetchWeatherFromAPI({
    String? location,
    double? latitude,
    double? longitude,
  }) async {
    String apiUrl;
    const apiKey = "2e86b83fbdf868ebc82466afc268c211";

    if (location != null) {
      apiUrl =
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric';
    } else if (latitude != null && longitude != null) {
      apiUrl =
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    } else {
      throw Exception('Location data is missing');
    }

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherData(
        temperature: '${data['main']['temp']}°C',
        description: data['weather'][0]['description'],
        iconUrl:
            'https://openweathermap.org/img/wn/${data['weather'][0]['icon']}@2x.png',
        windSpeed: '${data['wind']['speed']} m/s',
        humidity: '${data['main']['humidity']}%',
        visibility: '${data['visibility']} m',
      );
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<LocationData> getLocation() async {
    final location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        throw Exception('Location services are disabled.');
      }
    }

    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        throw Exception('Location permissions are denied.');
      }
    }

    return await location.getLocation();
  }
}
