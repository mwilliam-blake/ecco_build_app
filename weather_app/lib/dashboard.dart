import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as apiClient;
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/weather_model.dart';

class dashboard extends StatefulWidget{
  const dashboard({super.key});
  @override
  State<StatefulWidget> createState()  => _dashboard_page();

}

class _dashboard_page extends State<dashboard> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(getWeatherEvent());
  }

  /* Future<MainModel?> getWeather() async {
    /// api client call
    String url = "https://api.openweathermap.org/data/2.5/weather?lat=13.0012&lon=80.2565&appid=fb4bef7f16f526f467657cb8d61bac3e";

    apiClient.Response res = await apiClient.get(Uri.parse(url));

    if(res.statusCode==200){
      ///all okay
      DataModel mData = DataModel.fromJson(jsonDecode(res.body));
      return mData.main;

    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  } */

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if(state is getLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(state is WeatherErrorState) {
                return Center(
                  child: Text("${state.errorMsg}"),
                );
              }
              else if(state is getLoadedState) {
                var mdataModel = state.dData;
                return Text("${mdataModel.main.temp}");
              }
              return Container();
            }
        ),
          /* FutureBuilder(
            future: getWeather(),
            builder: (_, snap){
              if(snap.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }

              if(snap.hasError){
                return Center(child: Text("${snap.error}"),);
              }
              print(snap.data!.temp);
              if(snap.hasData){ print(snap.data!.temp);
                return snap.data!.temp!=null ? snap.data!.temp!=null? Column(
                        children: [
                                 snap.data!.temp!= null ? Text("Weather: ${snap.data!.temp}") : Container(),
                                 Text(snap.data!.feels_like!=null ? "${snap.data!.feels_like}":"No Data"),
                                 Text(snap.data!.temp_min!=null ? "${snap.data!.temp_min}":"No Data"),
                                 Text(snap.data!.temp_max!=null? "${snap.data!.temp_max}":"No Data"),

                        ],
                      ) : Center(child: Text('No Quotes found!!'),) : Container();
              }

              return Container();

            }) */
    );
  }
  
}