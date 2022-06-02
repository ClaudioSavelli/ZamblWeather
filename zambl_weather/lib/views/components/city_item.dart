import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zambl_weather/models/server/current_weather_response.dart';

class CityItem extends StatelessWidget {
  final String cityName;
  final CurrentWeatherResponse response;
  final Function(String)? onClick;
  final Function(String)? onRemoveButton;
  const CityItem({Key? key, required this.cityName, this.onClick, required this.response, this.onRemoveButton}) : super(key: key);

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
                trailing: Container(
                  width: 105,
                  child: Row(
                    children: [
                      Text(response.temp.toString()),
                      IconButton(
                          onPressed: () {
                            if (onRemoveButton != null) {
                              onRemoveButton!(cityName);
                            }
                          },
                          icon: const Icon(Icons.delete_outline)
                      )
                    ],
                  ),
                ),
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