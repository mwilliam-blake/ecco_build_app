class DataModel{
  int? dt;
  int? visibility;
  String? base;
  List<WeatherModel>? weather;
  CoordModel? coordModel;
  MainModel main;
  WindModel? wind;
  CloudsModel? clouds;
  SysModel? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;


  DataModel({required this.dt, required this.visibility, required this.base, required this.weather, required this.coordModel, required this.main, required this.wind, required this.clouds, required this.sys, required this.timezone, required this.id, required this.name, required this.cod});

  factory DataModel.fromJson(Map<String, dynamic> json){

    List<WeatherModel> WeatherList = [];

    for(Map<String, dynamic> eachQuote in json['weather']){
      WeatherModel mQuote = WeatherModel.fromJson(eachQuote);
      WeatherList.add(mQuote);
    }

    return DataModel(
        dt: json['dt'],
        visibility: json['visibility'],
        base: json['base'],
        coordModel: CoordModel.fromJson(json['coord']),
        main: MainModel.fromJson(json['main']),
        wind: WindModel.fromJson(json['wind']),
        clouds: CloudsModel.fromJson(json['clouds']),
        sys: SysModel.fromJson(json['sys']),
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod'],
        weather: WeatherList);
  }


}

class WeatherModel {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherModel({required this.id, required this.main, required this.description, required this.icon});

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']);
  }
}

class CoordModel {
  num? lon;
  num? lat;

  CoordModel({required this.lon, required this.lat});

  factory CoordModel.fromJson(Map<String, dynamic> json){
    return CoordModel(
        lon: json['lon'],
        lat: json['lat']);
  }
}

class CloudsModel {
  int? all;

  CloudsModel({required this.all});

  factory CloudsModel.fromJson(Map<String, dynamic> json){
    return CloudsModel(
        all: json['all']);
  }
}

class WindModel {
  num? speed;
  int? deg;

  WindModel({required this.speed, required this.deg});

  factory WindModel.fromJson(Map<String, dynamic> json){
    return WindModel(
        speed: json['speed'],
        deg: json['deg']);
  }
}

class MainModel {
  num? temp;
  num? feels_like;
  num? temp_min;
  num? temp_max;
  int? pressure;
  int? humidity;
  int? sea_level;
  int? grnd_level;

  MainModel({required this.temp, required this.feels_like, required this.temp_min, required this.temp_max, required this.pressure, required this.humidity, required this.sea_level, required this.grnd_level});

  factory MainModel.fromJson(Map<String, dynamic> json){
    return MainModel(
        temp: json['temp'],
        feels_like: json['feels_like'],
        temp_min: json['temp_min'],
        temp_max: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        sea_level: json['sea_level'],
        grnd_level: json['grnd_level']);
  }
}

class SysModel {
  int? type;
  int? id ;
  String? country;
  int? sunrise;
  int? sunset;

  SysModel({required this.type, required this.id, required this.country, required this.sunrise, required this.sunset});

  factory SysModel.fromJson(Map<String, dynamic> json){
    return SysModel(
        type: json['type'],
        id: json['id'],
        country: json['country'],
        sunrise: json['sunrise'],
        sunset: json['sunset']);
  }
}