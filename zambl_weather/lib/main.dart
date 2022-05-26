import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zambl_weather/Models.dart';
import 'package:zambl_weather/server_communication_controller.dart';

import 'package:zambl_weather/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    title: 'ZamblWeather',
      home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _repo = ServerCommunicationController();
  final sharedPreferences = sharedPreferencesController();


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
                ElevatedButton(onPressed: _search, child: Text('Search')),
                if(_response!=null)
                ElevatedButton(onPressed: () => sharedPreferences.save(_response!.city.toString()), child: Text('Add to favourites'))
              ],
            ),
          ),
          bottomNavigationBar: (
          ElevatedButton(
            child: const Text('Favourite cities'),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PreferredList()),);
            }
          )
          ),
        ));
  }

  void _search() async {
    final response = await _repo.getWeather(_cityTextController.text);
    print(_repo.getWeather(_cityTextController.text));
    setState(() => _response = response);
  }
}

class PreferredList extends StatelessWidget {
  const PreferredList({super.key});


  @override
  Widget build(BuildContext context) {
    final sharedPreferences = sharedPreferencesController();

    return FutureBuilder(
    future: Future.wait([
      sharedPreferences.get()
    ]),
    builder: (context, response) {
    if (response.connectionState == ConnectionState.done) {
    if (response.data != null) {
    final rep = response.data as List<dynamic>;
    print(rep[0] as List<String>);
    }
    }
    return const Text("Saved Cities");
    });
    // List<UserModel>? userList = await UserInterestsService.getUsersWithTags([Tag("Music")]);
  }
}