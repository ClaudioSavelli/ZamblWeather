import 'package:flutter/material.dart';
import 'package:zambl_weather/controllers/server_communication_controller.dart';
import 'package:zambl_weather/controllers/shared_preferences_controller.dart';
import 'package:zambl_weather/models/server/current_weather_response.dart';
import 'package:zambl_weather/models/server/forecast_weather_response.dart';
import 'package:zambl_weather/views/favorite_page.dart';
import 'package:zambl_weather/widgets/app_scaffold.dart';
import 'package:zambl_weather/widgets/components/current_weather_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _cityTextController = TextEditingController();
  final _serverController = ServerCommunicationController();
  final sharedPreferences = SharedPreferencesController();
  CurrentWeatherResponse? _response;

  void _clearSearchBar() {
    setState(() {
      _cityTextController.clear();
    });
  }

  void _search() async {
    final forecast = await _serverController.getForecastWeather(_cityTextController.text);
    final response = await _serverController.getCurrentWeather(_cityTextController.text);
    setState(() => _response = response);
  }

  void _saveCity() {
    sharedPreferences.save(_response!.city.toString());
  }

  void _goToFavoritePage() {
    Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => const FavoritePage()));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(
      child: Column(
        children: [
          // Search text field
          TextField(
            controller: _cityTextController,
            maxLines: 1,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              _search();
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(onPressed: _clearSearchBar, icon: const Icon(Icons.clear)),
                hintText: "City name",
                label: const Text("City")
            ),
          ),
          OutlinedButton(onPressed: _search, child: const Text("Search")),
          CurrentWeatherBloc(response: _response, onAddClick: _saveCity,),
          OutlinedButton(onPressed: _goToFavoritePage, child: const Text("Favourite Cities"))
        ],
      ),
    ));
  }

}