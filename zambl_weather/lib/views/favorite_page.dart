import 'package:flutter/material.dart';
import 'package:zambl_weather/controllers/shared_preferences_controller.dart';
import 'package:zambl_weather/widgets/app_scaffold.dart';
import 'package:zambl_weather/widgets/components/city_item.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoritePage();
}

class _FavoritePage extends State<FavoritePage> {
  final sharedPreferences = SharedPreferencesController();

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
                    print(cityList);
                    return ListView.builder(
                      itemCount: cityList.length,
                      itemBuilder: (context, index) {
                        final item = cityList[index];

                        return ListTile(title: Text(item),);
                      },
                    );
                  }
                }
                return const SizedBox.shrink();
              }
            )
          ],
        )
    ));
  }
}