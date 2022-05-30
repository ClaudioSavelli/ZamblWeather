import 'package:flutter/material.dart';

class CityItem extends StatelessWidget {
  final String cityName;
  final Function(String)? onClick;
  const CityItem({Key? key, required this.cityName, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell (
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(cityName, style: const TextStyle(fontSize: 20),),
              ],
            ),
          ),
        ),
        onTap: () {
          if (onClick != null){
            onClick!(cityName);
          }},
      ),
    );
  }
}