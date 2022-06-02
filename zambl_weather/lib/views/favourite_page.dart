import 'package:flutter/material.dart';
import 'package:zambl_weather/controllers/server_communication_controller.dart';
import 'package:zambl_weather/controllers/shared_preferences_controller.dart';
import 'package:zambl_weather/views/detail_page.dart';
import 'package:zambl_weather/widgets/app_scaffold.dart';
import 'package:zambl_weather/widgets/empty_widget.dart';
import 'package:zambl_weather/views/components/city_item.dart';
import 'package:zambl_weather/widgets/tip.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavouritePage();
}

class _FavouritePage extends State<FavouritePage> {
  final sharedPreferences = SharedPreferencesController();
  final _serverController = ServerCommunicationController();

  void _loadDetails(String cityName) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DetailPage(cityName: cityName)));
  }

  /// Remove the city from the shared preference
  /// If set, the list of cities can also be directly updated (
  /// in the case of dismissible items)
  void _removeCity(String city) {
    setState((){
      sharedPreferences.remove(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Saved Cities",
        body: Center(
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
              ),
              const Tip(text: "Tip : Click on a item of the list to see the weather details")
            ],
          )
    ));
  }

  Widget _listOfCities(List<String> cityList) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: MediaQuery.of(context).size.height - 150,
      child: ListView.builder(
        itemCount: cityList.length,
        itemBuilder: (context, index) {
          final item = cityList[index];
          return Dismissible(
            key: ValueKey<String>(cityList[index]),
            onDismissed: (DismissDirection direction) {
              _removeCity(item);
            },
            child: FutureBuilder(
              future: Future.wait([
                _serverController.getCurrentWeather(item)
              ]),
              builder: (context, response) {
                if (response.connectionState == ConnectionState.done) {
                  if (response.data != null) {
                    final rep = (response.data as List<dynamic>);
                    return CityItem(cityName: item, response: rep[0], onClick: _loadDetails, onRemoveButton: _removeCity,);
                  }
                }
                return const EmptyWidget();
              },
            ),
          );
        },
      ),
    );
  }
}