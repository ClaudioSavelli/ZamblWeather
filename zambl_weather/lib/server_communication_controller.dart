import 'dart:convert';

import 'Models.dart';
import 'package:http/http.dart' as http;
import 'const.dart';

class ServerCommunicationController {
  Future<ServerResponse> getWeather(String city) async {
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', {'q': city, 'appid': MYAPI, 'units' : 'metric'});

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return ServerResponse.fromJson(json);
}}