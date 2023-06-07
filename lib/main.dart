import 'package:flutter/material.dart';
import 'package:weather_demo/screens/splash_screen.dart';

import 'model/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
