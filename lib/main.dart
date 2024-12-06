import 'package:flutter/material.dart';
import 'package:smart_house/screens/add_address_screen.dart';
import 'package:smart_house/screens/add_device_screen.dart';
import 'package:smart_house/screens/add_room_screen.dart';
import 'package:smart_house/screens/add_user_screen.dart';
import 'package:smart_house/screens/check_pin_screen.dart';
import 'package:smart_house/screens/create_pin_screen.dart';
import 'package:smart_house/screens/device_screen.dart';
import 'package:smart_house/screens/home_screen.dart';
import 'package:smart_house/screens/login_screen.dart';
import 'package:smart_house/screens/main_room_screen.dart';
import 'package:smart_house/screens/profile_screen.dart';
import 'package:smart_house/screens/registration_screen.dart';
import 'package:smart_house/screens/users_screen.dart';
import 'screens/splash_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/registration': (context) => RegistrationScreen(),
        '/create_pin': (context) => CreatePinScreen(),
        '/check_pin': (context) => CheckPinScreen(),
        '/add_address': (context) => AddAddressScreen(),
        '/main_room': (context) => MainRoomScreen(),
        '/users': (context) => UsersScreen(),
        '/devices': (context) => DevicesScreen(),
        '/add_room': (context) => AddRoomScreen(),
        '/add_device': (context) => AddDeviceScreen(),
        '/add_user': (context) => AddUserScreen(),
        '/edit_profile': (context) => ProfileScreen()
      },
    );
  }
}