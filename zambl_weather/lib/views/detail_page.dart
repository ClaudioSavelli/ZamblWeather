import 'package:flutter/material.dart';
import 'package:zambl_weather/controllers/server_communication_controller.dart';
import 'package:zambl_weather/models/server/forecast_weather_response.dart';
import 'package:zambl_weather/models/temperature.dart';
import 'package:zambl_weather/models/weather.dart';
import 'package:zambl_weather/views/components/datetime_weather_bloc.dart';
import 'package:zambl_weather/views/components/tomorrow_weather_widget.dart';
import 'package:zambl_weather/views/components/week_weather_widget.dart';
import 'package:zambl_weather/widgets/app_scaffold.dart';
import 'package:zambl_weather/widgets/empty_widget.dart';

class DetailPage extends StatefulWidget {
  final String cityName;
  DetailPage({Key? key, required this.cityName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailPage(cityName);
}

class _DetailPage extends State<DetailPage> {
  final _serverController = ServerCommunicationController();
  final String cityName;

  _DetailPage(this.cityName);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: cityName,
      body: FutureBuilder(
          future: Future.wait([
            _serverController.getForecastWeather(cityName)
          ]),
          builder: (context, response) {
            if (response.connectionState == ConnectionState.done) {
              if (response.data != null) {
                final forecast = (response.data as List<dynamic>)[0] as ForecastWeatherResponse;
                return Center(
                  child: Column(
                    children: [
                      TomorrowWeatherWidget(forecast: forecast,),
                      WeekWeatherWidget(forecast: forecast)
                    ],
                  ),
                );
              }
            }
            return const EmptyWidget();
          }
      ),
    );
  }
/*
  Widget _WeekWeatherWidget(BuildContext context, ForecastWeatherResponse forecast) {
    final map = 
  }*/
}