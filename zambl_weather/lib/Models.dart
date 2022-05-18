class ServerResponse {
  final String city;
  final Weather weather;
  final Temperature temp;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weather.icon}@2x.png';
  }

  ServerResponse({required this.city, required this.weather, required this.temp});

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    final city = json['name'];

    final weatherJson = json['weather'][0];
    final weather = Weather.fromJson(weatherJson);

    final tempJson = json['main'];
    final temp = Temperature.fromJson(tempJson);

    return ServerResponse(city : city, weather : weather, temp : temp);
  }
}

class Weather {
  final String description;
  final String icon;

  Weather({required this.description, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return Weather(description: description, icon: icon);
  }
}

class Temperature {
  final double temperature;

  Temperature({required this.temperature});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return Temperature(temperature: temperature);
  }
}