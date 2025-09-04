class WeatherModel {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final double maxTemp;
  final double minTemp;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.maxTemp,
    required this.minTemp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'].toDouble(),
      condition: json['current']['condition']['text'],
      icon: json['current']['condition']['icon'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c']
          .toDouble(),
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c']
          .toDouble(),
    );
  }
}
