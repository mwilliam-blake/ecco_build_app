import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../dashboard.dart';
import '../../navigation_provider.dart';
import 'bloc/news_bloc.dart';
import 'data/api/api_library.dart';

void main() {
  /* runApp(BlocProvider(
    create: (context) => ExpenseBloc(db: DBHelper.getInstance()),
    child: splash_screen(),
  )); */
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => NewsBloc(apiHelper: ApiHelper()),
      ),
      ChangeNotifierProvider(create: (context) => NavigationProvider(),)
    ],
    child: splash_screen(),
  ));
}

class splash_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecco Build",
      debugShowCheckedModeBanner: false,
      home: splashScreen(),
    );
  }
}

class splashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _splashstate();
}


class _splashstate extends State<splashScreen> {
  @override

  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),() async{

      Widget navigateTo = dashboard();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => navigateTo,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/splash.png",
        fit: BoxFit.fitWidth,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}

