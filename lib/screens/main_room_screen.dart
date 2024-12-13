import 'package:flutter/material.dart';
import 'package:smart_house/server/server.dart'; // Импорт SupabaseService
import 'package:shared_preferences/shared_preferences.dart'; // Для получения houseid

class MainRoomScreen extends StatefulWidget {
  @override
  _MainRoomScreenState createState() => _MainRoomScreenState();
}

class _MainRoomScreenState extends State<MainRoomScreen> {
  final SupabaseService _supabaseService = SupabaseService();
  List<Map<String, dynamic>> _rooms = [];
  String? _houseId;

  // Карта изображений для типов комнат
  final Map<String, String> _roomImages = {
    'Гостиная': 'assets/living_room_type_image.png',
    'Кухня': 'assets/kitchen_type_image.png',
    'Ванная': 'assets/bathroom_type_image.png',
    'Кабинет': 'assets/cabinet_type_image.png',
    'Спальня': 'assets/bedroom_type_image.png',
    'Зал': 'assets/hall_type_image.png',
  };

  @override
  void initState() {
    super.initState();
    _loadHouseId();
  }

  Future<void> _loadHouseId() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('houseId');
    if (houseId != null) {
      setState(() {
        _houseId = houseId;
      });
      _fetchRooms(houseId);
    } else {
      print('Ошибка: houseId не найден в локальном хранилище');
    }
  }

  Future<void> _fetchRooms(String houseId) async {
    try {
      final rooms = await _supabaseService.getRoomsByHouseId(houseId);
      setState(() {
        _rooms = rooms;
      });
    } catch (error) {
      print('Ошибка при получении комнат: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _rooms.isEmpty
                ? Center(
              child: Text(
                'Комнаты не найдены',
                style: TextStyle(fontSize: 18),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                final room = _rooms[index];
                final roomName = room['roomname'] as String;
                final roomTypeId = room['roomtypeid'] as String;

                // Получаем имя типа комнаты по roomtypeid
                return FutureBuilder<String?>(
                  future: _supabaseService.getRoomTypeNameById(roomTypeId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Ошибка: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('Тип комнаты не найден'));
                    } else {
                      final roomTypeName = snapshot.data!;
                      final imagePath = _roomImages[roomTypeName] ?? 'assets/default_room_image.png';

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildRoomButton(roomName, imagePath),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_room');
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(0xFF0B50A0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildRoomButton(String roomName, String imagePath) {
    return Container(
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF0B50A0), width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          print('Выбрана комната: $roomName');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0B50A0),
          textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xFF0B50A0),
                BlendMode.srcIn,
              ),
              child: Image.asset(
                imagePath,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.0),
            Text(roomName),
          ],
        ),
      ),
    );
  }
}