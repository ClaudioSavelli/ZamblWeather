import 'package:flutter/material.dart';
import 'package:zambl_weather/models/server/forecast_weather_response.dart';
import 'package:zambl_weather/views/components/datetime_weather_bloc.dart';

class TomorrowWeatherWidget extends StatelessWidget {
  final ForecastWeatherResponse forecast;
  const TomorrowWeatherWidget({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final map = forecast.getWeatherOfNext24H();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Next 24 hours :", style: TextStyle(fontSize: 20),),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          padding: const EdgeInsets.only(bottom: 10),
          height: MediaQuery.of(context).size.height / 4,
          child: Card(
            elevation: 5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: map.keys.length,
              itemBuilder: (context, index) {
                final dateTime = map.keys.elementAt(index);
                final weather = map.values.elementAt(index).keys.elementAt(0);
                final temperature = map.values.elementAt(index).values.elementAt(0);
                return DatetimeWeatherBloc(
                  weather: weather,
                  dateTime: dateTime,
                  temperature: temperature,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
  
}