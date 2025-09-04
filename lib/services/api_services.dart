import 'package:dio/dio.dart';
import 'package:weather_app_with_cubit/models/weather_mode.dart';

class ApiServices {
  final Dio _dio = Dio();
  final String apiKey = 'f1fee75b4afa481a966145519252408';
  final String baseURL = 'http://api.weatherapi.com/v1';

  ApiServices(Dio dio);

  Future<WeatherModel?> getCurrentWeather(String cityName) async {
    try {
      final response = await _dio.get(
        '$baseURL/forecast.json',
        queryParameters: {'key': apiKey, 'q': cityName, 'days': 1},
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }
    } catch (e) {
      print('Error fetching weather: $e');
    }
    return null;
  }
}
