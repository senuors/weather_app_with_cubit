part of 'weather_cubit.dart';

class WeatherState {}

final class NoWeatherState extends WeatherState {}

final class WeatherLoadedState extends WeatherState {
  final WeatherModel weather;
  WeatherLoadedState(this.weather);
}

final class WeatherFailureState extends WeatherState {}

final class WeatherLoadingState extends WeatherState {}
