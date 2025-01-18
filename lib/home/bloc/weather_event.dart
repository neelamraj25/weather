abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String location;

  FetchWeather(this.location);
}

class FetchWeatherByCurrentLocation extends WeatherEvent {}
