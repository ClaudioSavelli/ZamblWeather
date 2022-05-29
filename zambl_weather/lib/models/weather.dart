class Weather {
  final String description;
  final String icon;

  Weather({required this.description, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return Weather(description: description, icon: icon);
  }

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  }

}