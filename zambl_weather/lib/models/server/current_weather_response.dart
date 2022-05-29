import 'package:zambl_weather/models/temperature.dart';
import 'package:zambl_weather/models/weather.dart';

class CurrentWeatherResponse {
  final String city;
  final Weather weather;
  final Temperature temp;

  CurrentWeatherResponse({required this.city, required this.weather, required this.temp});

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> json) {
    final city = json['name'];

    final weatherJson = json['weather'][0];
    final weather = Weather.fromJson(weatherJson);

    final tempJson = json['main'];
    final temp = Temperature.fromJson(tempJson);

    return CurrentWeatherResponse(city : city, weather : weather, temp : temp);
  }
}