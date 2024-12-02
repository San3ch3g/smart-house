import 'package:flutter/material.dart';
import 'package:smart_house/screens/create_pin_screen.dart';
import 'package:smart_house/screens/home_screen.dart';
import 'package:smart_house/screens/login_screen.dart';
import 'package:smart_house/screens/registration_screen.dart';
import 'screens/splash_screen.dart'; // Импортируем SplashScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CreatePinScreen(), // Используем SplashScreen в качестве домашнего экрана
    );
  }
}