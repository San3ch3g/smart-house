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
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bzzqvauwcgfarujkbhdl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6enF2YXV3Y2dmYXJ1amtiaGRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMxMjM5NjEsImV4cCI6MjA0ODY5OTk2MX0.dOhwLseSUc0shJDmbyl1-ArpIUDrWDyGapP0lbhjMso',
  );

  runApp(MyApp());
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
        '/main_room': (context) => HomeScreen(), // Замените на HomePageScreen
        '/users': (context) => HomeScreen(),    // Замените на HomePageScreen
        '/devices': (context) => HomeScreen(),  // Замените на HomePageScreen
        '/add_room': (context) => AddRoomScreen(),
        '/add_device': (context) => AddDeviceScreen(),
        '/add_user': (context) => AddUserScreen(),
        '/edit_profile': (context) => ProfileScreen()
      },
    );
  }
}