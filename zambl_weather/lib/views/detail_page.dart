import 'package:flutter/material.dart';
import 'package:zambl_weather/widgets/app_scaffold.dart';

class DetailPage extends StatefulWidget {
  final String cityName;
  const DetailPage({Key? key, required this.cityName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Center(
          child: Column(
            children: [],
          ),
        )
    );
  }
}