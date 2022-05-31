class Temperature {
  final double temperature;

  Temperature({required this.temperature});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    var temperature = json['temp'];
    // If there is a int in the json instead of a float
    // Create an exception without this code
    if (temperature.runtimeType == int) {
      temperature = (temperature as int).toDouble();
    }
    return Temperature(temperature: temperature);
  }

  @override
  String toString() {
    return temperature.toString() + " °C";
  }
}