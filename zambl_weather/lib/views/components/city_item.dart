import 'package:flutter/material.dart';
import 'package:zambl_weather/models/server/current_weather_response.dart';

class CityItem extends StatelessWidget {
  final String cityName;
  final CurrentWeatherResponse response;
  final Function(String)? onClick;
  const CityItem({Key? key, required this.cityName, this.onClick, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        child: InkWell (
            child: Card(
              child: ListTile(
                title: Text(cityName,),
                leading: Image.network(response.weather.iconUrl),
                subtitle: Text(response.weather.description),
                trailing: Text(response.temp.toString()),
              ),
            ),
          onTap: () {
            if (onClick != null){
              onClick!(cityName);
            }},
        ),
      ),
    );
  }
}