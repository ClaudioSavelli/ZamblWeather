import 'package:flutter/material.dart';
import 'package:zambl_weather/controllers/server_communication_controller.dart';
import 'package:zambl_weather/controllers/shared_preferences_controller.dart';
import 'package:zambl_weather/models/server/current_weather_response.dart';
import 'package:zambl_weather/views/components/current_weather_bloc.dart';
import 'package:zambl_weather/views/favourite_page.dart';
import 'package:zambl_weather/widgets/app_scaffold.dart';

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
    const snackbar = SnackBar(content: Text("Searching"));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    final response = await _serverController.getCurrentWeather(_cityTextController.text);
    ScaffoldMessenger.of(context).clearSnackBars();
    setState(() => _response = response);
  }

  void _saveCity() {
    const snackbar = SnackBar(content: Text("City saved"));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    sharedPreferences.save(_response!.city.toString());
  }

  void _goToFavoritePage() {
    Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => const FavouritePage()));
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
          OutlinedButton(onPressed: _search, child: const Text("Search", style: TextStyle(fontSize: 15))),
          CurrentWeatherBloc(response: _response, onAddClick: _saveCity,),
          OutlinedButton(onPressed: _goToFavoritePage, child: const Text("Go to saved cities", style: TextStyle(fontSize: 20),))
        ],
      ),
    ));
  }

}