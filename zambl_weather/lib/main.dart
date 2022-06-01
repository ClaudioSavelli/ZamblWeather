import 'package:flutter/material.dart';
import 'package:zambl_weather/controllers/server_communication_controller.dart';

import 'package:zambl_weather/controllers/shared_preferences_controller.dart';
import 'package:zambl_weather/models/server/current_weather_response.dart';
import 'package:zambl_weather/utils/date_converter.dart';
import 'package:zambl_weather/views/main_page.dart';

void main() {
  runApp(const MaterialApp(
    title: 'ZamblWeather',
      home: MainPage(),
  ));
}