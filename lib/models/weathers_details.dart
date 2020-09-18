class WeatherDetails {
  List<Weather> weather;
  Main main;
  String name;

  WeatherDetails({this.main, this.weather, this.name});

  WeatherDetails.fromJson(Map<String, dynamic> tojson) {
    if (tojson["weather"] != null) {
      weather = List<Weather>();
      tojson["weather"].forEach((e) {
        weather.add(Weather.fromJson(e));
      });
    }

    main = tojson["main"] != null ? Main.fromJson(tojson["main"]) : null;
    name = tojson["name"];
  }
}

class Weather {
  String main;
  String description;

  Weather({this.main, this.description});

  Weather.fromJson(Map<String, dynamic> tojson) {
    main = tojson["main"] != null ? tojson["main"] : null;
    description = tojson["description"] != null ? tojson["description"] : null;
  }

  Map<String, dynamic> toMap() =>
      {"main": this.main, "description": this.description};
}

class Main {
  double temp;
  double feels_like;
  double temp_max;
  double temp_min;

  Main.fromJson(Map<String, dynamic> tojson) {
    temp = tojson["temp"] != null ? tojson["temp"] : null;
    feels_like = tojson["feels_like"] != null ? tojson["feels_like"] : null;
    temp_max = tojson["temp_max"] != null ? tojson["temp_max"] : null;
    temp_min = tojson["temp_min"] != null ? tojson["temp_min"] : null;
  }

  Map<String, dynamic> toMap() => {
        "temp": this.temp,
        "temp_max": this.temp_max,
        "temp_min": this.temp_min,
        "feels_like": this.feels_like
      };
}
