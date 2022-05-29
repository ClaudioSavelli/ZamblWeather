class Temperature {
  final double temperature;

  Temperature({required this.temperature});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return Temperature(temperature: temperature);
  }
}