import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  const AppScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ZamblWeather"), automaticallyImplyLeading: true,),
      body: body,
    );
  }
}