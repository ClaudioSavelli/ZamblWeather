import 'package:flutter/material.dart';
import 'package:zambl_weather/controllers/shared_preferences_controller.dart';
import 'package:zambl_weather/models/server/current_weather_response.dart';
import 'package:zambl_weather/widgets/empty_widget.dart';

/// Widget used to show the current weather with an add button (for the favorite)
class CurrentWeatherBloc extends StatefulWidget {
  final CurrentWeatherResponse? response;
  final VoidCallback? onSaveClick;
  const CurrentWeatherBloc({Key? key, required this.response, this.onSaveClick}) : super(key: key);

  @override
  State<CurrentWeatherBloc> createState() => _CurrentWeatherBlocState();
}

class _CurrentWeatherBlocState extends State<CurrentWeatherBloc> {
  @override
  Widget build(BuildContext context) {
    if (widget.response != null) {
      return Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height/2.5,
          width: MediaQuery.of(context).size.width - 100,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.response!.city,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30),
              ),
              Image.network(widget.response!.weather.iconUrl),
              Text(
                widget.response!.weather.description,
                style: const TextStyle(fontSize: 20),),
              Text(
                widget.response!.temp.toString(),
                style: const TextStyle(fontSize: 20),),
              _SaveButton()
            ],
          ),
        )
      );
    }
    return const Text("No result for now");
  }

  Widget _SaveButton() {
    if (widget.onSaveClick != null) {
      return FutureBuilder<List<String>?>(
        future: SharedPreferencesController().get(),
        builder: (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && widget.response != null) {
              // If the city is already saved
              if (snapshot.data!.contains(widget.response!.city)) {
                return const Text("This city is already saved");
              } else {
                // If the city can be saved
                return ElevatedButton(
                    onPressed: widget.onSaveClick,
                    child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 15)
                    )
                );
              }
            }
          }
          return const EmptyWidget();
        },
      );
    }
    return const EmptyWidget();
  }
}