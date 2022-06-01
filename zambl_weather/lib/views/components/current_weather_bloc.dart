import 'package:flutter/material.dart';
import 'package:zambl_weather/models/server/current_weather_response.dart';
import 'package:zambl_weather/widgets/empty_widget.dart';

/// Widget used to show the current weather with an add button (for the favorite)
class CurrentWeatherBloc extends StatelessWidget {
  final CurrentWeatherResponse? response;
  final VoidCallback? onAddClick;
  const CurrentWeatherBloc({Key? key, required this.response, this.onAddClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (response != null) {
      return Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width - 50,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                response!.city,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30),
              ),
              Image.network(response!.weather.iconUrl),
              Text(
                response!.weather.description,
                style: const TextStyle(fontSize: 20),),
              Text(
                response!.temp.toString(),
                style: const TextStyle(fontSize: 20),),
              //IconButton(onPressed: onAddClick, icon: const Icon(Icons.add))
              _AddButton()
            ],
          ),
        )
      );
    }
    return const Text("No result for now");
  }

  Widget _AddButton() {
    if (onAddClick != null) {
      return ElevatedButton(onPressed: onAddClick, child: const Text("Save", style: TextStyle(fontSize: 15)));
    }
    return const EmptyWidget();
  }
}