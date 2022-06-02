import 'package:flutter/material.dart';
import 'package:zambl_weather/models/server/forecast_weather_response.dart';
import 'package:zambl_weather/views/components/datetime_weather_bloc.dart';

class WeekWeatherWidget extends StatelessWidget {
  final ForecastWeatherResponse forecast;
  const WeekWeatherWidget({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final map = forecast.getWeatherOfNext4Days();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Next 4 days :", style: TextStyle(fontSize: 20),),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          padding: const EdgeInsets.only(bottom: 10),
          height: MediaQuery.of(context).size.height / 2,
          child: Card(
            elevation: 5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: map.keys.length~/2,
              itemBuilder: (context, index) {
                final dateTimeM = map.keys.elementAt(index*2);
                final weatherM = map.values.elementAt(index*2).keys.elementAt(0);
                final temperatureM = map.values.elementAt(index*2).values.elementAt(0);
                final dateTimeA = map.keys.elementAt(index*2+1);
                final weatherA = map.values.elementAt(index*2+1).keys.elementAt(0);
                final temperatureA = map.values.elementAt(index*2+1).values.elementAt(0);
                return Column(
                    children: [
                      Text(dateTimeA.day.toString().padLeft(2, "0") + "/" + dateTimeA.month.toString().padLeft(2, "0"), style: const TextStyle(fontSize: 20),),
                      DatetimeWeatherBloc(
                      weather: weatherM,
                      dateTime: dateTimeM,
                      temperature: temperatureM,
                      ),
                      DatetimeWeatherBloc(
                        weather: weatherA,
                        dateTime: dateTimeA,
                        temperature: temperatureA,
                      )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}