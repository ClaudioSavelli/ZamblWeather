import 'package:flutter/material.dart';
import 'package:zambl_weather/controllers/server_communication_controller.dart';
import 'package:zambl_weather/controllers/shared_preferences_controller.dart';
import 'package:zambl_weather/views/components/city_item.dart';
import 'package:zambl_weather/views/detail_page.dart';
import 'package:zambl_weather/widgets/app_scaffold.dart';
import 'package:zambl_weather/widgets/empty_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoritePage();
}

class _FavoritePage extends State<FavoritePage> {
  final sharedPreferences = SharedPreferencesController();
  final _serverController = ServerCommunicationController();

  void _loadDetails(String cityName) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DetailPage(cityName: cityName)));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: Future.wait([
                sharedPreferences.get()
              ]),
              builder: (context, response) {
                if (response.connectionState == ConnectionState.done) {
                  if (response.data != null) {
                    final rep = response.data as List<dynamic>;
                    final cityList = rep[0] as List<String>;
                    return _listOfCities(cityList);
                  }
                }
                return const EmptyWidget();
              }
            )
          ],
        )
    ));
  }

  Widget _listOfCities(List<String> cityList) {
    // TODO : a better way to set the height
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: MediaQuery.of(context).size.height - 100,
      child: ListView.builder(
        itemCount: cityList.length,
        itemBuilder: (context, index) {
          final item = cityList[index];
          return FutureBuilder(
            future: Future.wait([
              _serverController.getCurrentWeather(item)
            ]),
            builder: (context, response) {
              if (response.connectionState == ConnectionState.done) {
                if (response.data != null) {
                  final rep = (response.data as List<dynamic>);
                  return CityItem(cityName: item, response: rep[0], onClick: _loadDetails,);
                }
              }
              return const EmptyWidget();
            },
          );
        },
      ),
    );
  }
}