class ForecastModel {
  int dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Rain rain;
  Sys sys;
  // String dtTxt;
  DateTime dtTxt;

  ForecastModel({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.rain,
    required this.sys,
    required this.dtTxt,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      dtTxt: DateTime.parse(json['dt_txt']),
      // dtTxt: json['dt_txt'],
      main: Main.fromJson(json['main']),
      pop: json['pop']?.toDouble() ?? 0.0,
      rain: json['rain'] != null
          ? Rain.fromJson(json['rain'])
          : Rain(the3H: 0.0), // Default Rain instance
      sys: Sys.fromJson(json['sys']),
      visibility: json['visibility'],
      weather: (json['weather'] as List)
          .map((data) => Weather.fromJson(data))
          .toList(),
      wind: Wind.fromJson(json['wind']),
    );
  }
}

class Clouds {
  int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'].toDouble(),
    );
  }
}

class Rain {
  double the3H;

  Rain({required this.the3H});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      the3H: json['1h'] != null ? json['1h'].toDouble() : 0.0,
    );
  }
}

class Sys {
  String pod;

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json['pod'],
    );
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
      gust: json['gust'] != null ? json['gust'].toDouble() : 0.0,
    );
  }
}



// import 'dart:convert';

// import 'package:rz_test/model/weather_model.dart';

// ForecastModel forecastModelFromJson(String str) =>
//     ForecastModel.fromJson(json.decode(str));

// String forecastModelToJson(ForecastModel data) => json.encode(data.toJson());

// class ForecastModel {
//   City city;
//   String cod;
//   double message;
//   int cnt;
//   List<ForecastList> list;

//   ForecastModel({
//     required this.city,
//     required this.cod,
//     required this.message,
//     required this.cnt,
//     required this.list,
//   });

//   factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
//         city: City.fromJson(json["city"]),
//         cod: json["cod"],
//         message: json["message"]?.toDouble(),
//         cnt: json["cnt"],
//         list: List<ForecastList>.from(
//             json["list"].map((x) => ForecastList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "city": city.toJson(),
//         "cod": cod,
//         "message": message,
//         "cnt": cnt,
//         "list": List<dynamic>.from(list.map((x) => x.toJson())),
//       };
// }

// class City {
//   int id;
//   String name;
//   Coord coord;
//   String country;
//   int population;
//   int timezone;
//   int sunrise;
//   int sunset;

//   City({
//     required this.id,
//     required this.name,
//     required this.coord,
//     required this.country,
//     required this.population,
//     required this.timezone,
//     required this.sunrise,
//     required this.sunset,
//   });

//   factory City.fromJson(Map<String, dynamic> json) => City(
//         id: json["id"],
//         name: json["name"],
//         coord: Coord.fromJson(json["coord"]),
//         country: json["country"],
//         population: json["population"],
//         timezone: json["timezone"],
//         sunrise: json["sunrise"],
//         sunset: json["sunset"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "coord": coord.toJson(),
//         "country": country,
//         "population": population,
//         "timezone": timezone,
//         "sunrise": sunrise,
//         "sunset": sunset,
//       };
// }

// class Coord {
//   double lon;
//   double lat;

//   Coord({
//     required this.lon,
//     required this.lat,
//   });

//   factory Coord.fromJson(Map<String, dynamic> json) => Coord(
//         lon: json["lon"]?.toDouble(),
//         lat: json["lat"]?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "lon": lon,
//         "lat": lat,
//       };
// }

// class ForecastList {
//   int dt;
//   Main main;
//   List<Weather> weather;
//   Clouds clouds;
//   Wind wind;
//   int visibility;
//   double pop;
//   Rain? rain;
//   Sys sys;
//   String dtTxt;

//   ForecastList({
//     required this.dt,
//     required this.main,
//     required this.weather,
//     required this.clouds,
//     required this.wind,
//     required this.visibility,
//     required this.pop,
//     this.rain,
//     required this.sys,
//     required this.dtTxt,
//   });

//   factory ForecastList.fromJson(Map<String, dynamic> json) => ForecastList(
//         dt: json["dt"],
//         main: Main.fromJson(json["main"]),
//         weather:
//             List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
//         clouds: Clouds.fromJson(json["clouds"]),
//         wind: Wind.fromJson(json["wind"]),
//         visibility: json["visibility"],
//         pop: json["pop"]?.toDouble(),
//         rain: json["rain"] != null ? Rain.fromJson(json["rain"]) : null,
//         sys: Sys.fromJson(json["sys"]),
//         dtTxt: json["dt_txt"],
//       );

//   Map<String, dynamic> toJson() => {
//         "dt": dt,
//         "main": main.toJson(),
//         "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
//         "clouds": clouds.toJson(),
//         "wind": wind.toJson(),
//         "visibility": visibility,
//         "pop": pop,
//         "rain": rain?.toJson(),
//         "sys": sys.toJson(),
//         "dt_txt": dtTxt,
//       };
// }

// //model generated by app.quicktype.io
