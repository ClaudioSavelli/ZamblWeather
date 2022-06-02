import 'package:zambl_weather/models/temperature.dart';
import 'package:zambl_weather/models/weather.dart';
import 'package:zambl_weather/utils/date_converter.dart';

class ForecastWeatherResponse {
  final String city;
  final Map<DateTime, Map<Weather, Temperature>> forecast;

  ForecastWeatherResponse({required this.city, required this.forecast});

  factory ForecastWeatherResponse.fromJson(Map<String, dynamic> json) {
    final city = json['city']['name'];
    final Map<DateTime, Map<Weather, Temperature>> forecast = {};

    for(int i = 0; i < 40; i++) {
      final Map<Weather, Temperature> map = {};
      final date = DateConverter.readTimestamp(json['list'][i]['dt']);
      final weather = Weather.fromJson(json['list'][i]['weather'][0]);
      final temp = Temperature.fromJson(json['list'][i]['main']);
      map[weather] = temp;
      forecast[date] = map;
    }

    return ForecastWeatherResponse(city : city, forecast : forecast);
  }

  /// Return the map of Datetime : (Weather: Temperature) for the next 24 hours
  Map<DateTime, Map<Weather, Temperature>> getWeatherOfNext24H() {
    final today = DateTime.now();
    Map<DateTime, Map<Weather, Temperature>> mapWeatherTemp = {};
    forecast.forEach((datetime, value) {
      // If the datetime is tomorrow
      if (datetime.difference(today).inDays == 1) {
        mapWeatherTemp.addEntries([MapEntry(datetime, value)]);
      }
    });
    return mapWeatherTemp;
  }

  Map<DateTime, Map<Weather, Temperature>> getWeatherOfNext4Days() {
    final today = DateTime.now();
    Map<DateTime, Map<Weather, Temperature>> mapWeatherTemp = {};
    forecast.forEach((datetime, value) {
      if (datetime.difference(today).inDays <= 5 && datetime.difference(today).inDays > 0) {
        if (datetime.hour == 10 || datetime.hour == 16) {
          mapWeatherTemp.addEntries([MapEntry(datetime, value)]);
        }
      }
    });
    return mapWeatherTemp;
  }
}