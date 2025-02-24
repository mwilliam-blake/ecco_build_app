part of 'weather_bloc.dart';

@immutable
abstract class WeatherState { }

class getWeatherinitial extends WeatherState { }
class getLoadingState extends WeatherState { }
class getLoadedState extends WeatherState {
  DataModel dData;
  getLoadedState({required this.dData});
}
class WeatherErrorState extends WeatherState {
  String errorMsg;
  WeatherErrorState({required this.errorMsg});
}