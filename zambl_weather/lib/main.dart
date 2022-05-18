import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zambl_weather/Models.dart';
import 'package:zambl_weather/server_communication_controller.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _repo = ServerCommunicationController();

  ServerResponse? _response;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                if (_response != null)
                  Column(
                    children: [
                      Text('${_response?.city}',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)
                      ),

                      Image.network(_response!.iconUrl),
                      Text(_response!.weather.description,
                           style: TextStyle(fontSize: 45),),
                      Text(
                        '${_response!.temp.temperature}°C',
                        style: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                        controller: _cityTextController,
                        decoration: InputDecoration(labelText: 'City'),
                        textAlign: TextAlign.center),
                  ),
                ),
                ElevatedButton(onPressed: _search, child: Text('Search'))
              ],
            ),
          ),
        ));
  }

  void _search() async {
    final response = await _repo.getWeather(_cityTextController.text);
    print(_repo.getWeather(_cityTextController.text));
    setState(() => _response = response);
  }
}