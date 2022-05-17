import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse extends Object {
    final String message;
    final String cod;
    final int count;

    @JsonKey(name: "list")
    final List<City> cities;

    BaseResponse(
        this.message,
        this.cod,
        this.count,
        this.cities,
        );

    factory BaseResponse.fromJson(Map<String, dynamic> json) {
      // TODO: implement fromJson
      throw UnimplementedError();
    }
}

class City extends Object{
  final int id;
  final String name;
  final Coord coord;
  final Main main;
  final int dt;
  final Wind wind;
  final Rain rain;
  final Clouds clouds;
  final List<Weather> weather;

  City(
      this.id,
      this.name,
      this.coord,
      this.main,
      this.dt,
      this.wind,
      this.rain,
      this.clouds,
      this.weather,
      );
  factory City.fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}

@JsonSerializable()
class Coord extends Object {
  Coord();
  factory Coord.fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

}

@JsonSerializable()
class Main extends Object {
  Main();
  factory Main.fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

}

@JsonSerializable()
class Wind extends Object {
  Wind();
  factory Wind.fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

}

@JsonSerializable()
class Rain extends Object {
  Rain();
  factory Rain.fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

}

@JsonSerializable()
class Clouds extends Object {
  Clouds();
  factory Clouds.fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

}

@JsonSerializable()
class Weather extends Object {
  Weather();
  factory Weather.fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

}