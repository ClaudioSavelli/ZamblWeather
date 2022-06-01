import 'package:flutter/material.dart';

class Tip extends StatelessWidget {
  final String text;
  const Tip({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 15, color: Colors.blueGrey),);
  }
}