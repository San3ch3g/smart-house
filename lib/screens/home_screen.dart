import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_house/screens/main_room_screen.dart';
import 'package:smart_house/screens/device_screen.dart';
import 'package:smart_house/screens/users_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _address = 'г. Омск, ул. Ленина, д. 24'; // Значение по умолчанию

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadAddress(); // Загружаем адрес при инициализации
  }

  // Метод для загрузки адреса из локальной памяти
  Future<void> _loadAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAddress = prefs.getString('address');
    if (savedAddress != null) {
      setState(() {
        _address = savedAddress; // Обновляем адрес
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Твой дом',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              _address, // Используем загруженный адрес
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color(0xFF0B50A0),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/edit_profile');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[400],
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          tabs: [
            Tab(text: 'Комнаты'),
            Tab(text: 'Устройства'),
            Tab(text: 'Пользователи'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MainRoomScreen(),
          DevicesScreen(),
          UsersScreen(),
        ],
      ),
    );
  }
}