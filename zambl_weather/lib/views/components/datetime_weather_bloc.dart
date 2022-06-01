import 'package:flutter/material.dart';
import 'package:zambl_weather/models/temperature.dart';
import 'package:zambl_weather/models/weather.dart';

class DatetimeWeatherBloc extends StatelessWidget {
  final DateTime dateTime;
  final Weather weather;
  final Temperature temperature;
  const DatetimeWeatherBloc({Key? key, required this.dateTime,
    required this.weather,
    required this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            Text(dateTime.hour.toString() + "h", style: const TextStyle(fontSize: 20),),
            Image.network(weather.iconUrl),
            Text(
              temperature.toString(),
              style: const TextStyle(fontSize: 20)
            )
          ],
        ),
      ),
    );
  }
}