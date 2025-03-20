import 'dart:async';
import 'package:flutter/material.dart';
import '../../home.dart';
import '../login/login.dart';

void main() {
  runApp(splash_screen());
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

      Widget navigateTo = loginpage();

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
        "lib/domain/app/assets/images/splash.png",
        fit: BoxFit.fitWidth,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}

