import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  const AppScaffold({Key? key, required this.body, this.title = "ZamblWeather"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: true,
      ),
      resizeToAvoidBottomInset: false,
      body: body,
    );
  }
}