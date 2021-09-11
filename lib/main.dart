import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hisaab/theme.dart';
import 'screens/khata_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kTheme,
      home: MainScreen(),
      // AnimatedSplashScreen(
      //   splash: 'assets/something.jpg',
      //   nextScreen: MainScreen(),
      //   duration: 3000,
      //   splashTransition: SplashTransition.fadeTransition,
      // ),
    );
  }
}
