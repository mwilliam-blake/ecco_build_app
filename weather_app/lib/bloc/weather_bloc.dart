import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/weather_model.dart';

import '../data/api/api_library.dart';
import '../urls.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  ApiHelper apiHelper;
  WeatherBloc({required this.apiHelper}):super(getWeatherinitial()) {
    on<getWeatherEvent>((event,emit) async {
      emit(getLoadingState());

      var jsonres = await apiHelper.getApi(url: Urls.weatherApi);
      if(jsonres!=null) {
          var dDatares = DataModel.fromJson(jsonres);
          emit(getLoadedState(dData: dDatares));
      }
      else {
        emit(WeatherErrorState(errorMsg: "Something went wrong."));
      }
    });
  }
}