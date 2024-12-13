import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_house/server/server.dart'; // Импорт SupabaseService

class AddRoomScreen extends StatefulWidget {
  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _roomNameController = TextEditingController();
  String _selectedRoomType = 'Гостиная'; // Выбранный тип комнаты
  Map<String, String> _roomTypes = {}; // Карта типов комнат (название -> id)
  final SupabaseService _supabaseService = SupabaseService();
  String? _houseId; // ID дома

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
    _loadHouseId(); // Загружаем houseId из локального хранилища
    _fetchRoomTypes(); // Получаем типы комнат из базы данных
  }

  // Метод для загрузки houseId из локального хранилища
  Future<void> _loadHouseId() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('houseId');
    if (houseId != null) {
      setState(() {
        _houseId = houseId;
      });
    } else {
      print('Ошибка: houseId не найден в локальном хранилище');
    }
  }

  // Метод для получения типов комнат из базы данных
  Future<void> _fetchRoomTypes() async {
    try {
      final roomTypes = await _supabaseService.getRoomTypes();
      setState(() {
        // Создаем карту типов комнат (название -> id)
        _roomTypes = {
          for (var roomType in roomTypes)
            roomType['roomtypename']: roomType['id']
        };
      });
    } catch (error) {
      print('Ошибка при получении типов комнат: $error');
    }
  }

  // Метод для сохранения комнаты в базе данных
  Future<void> _onSavePressed() async {
    String roomName = _roomNameController.text;
    String roomType = _selectedRoomType;

    if (roomName.isEmpty) {
      _showSnackBar('Пожалуйста, введите название комнаты');
      return;
    }

    if (_houseId == null) {
      _showSnackBar('Ошибка: houseId не найден');
      return;
    }

    // Получаем id типа комнаты по его названию
    final roomTypeId = _roomTypes[roomType];

    if (roomTypeId == null) {
      _showSnackBar('Ошибка: тип комнаты не найден');
      return;
    }

    try {
      // Создаем комнату в базе данных
      await _supabaseService.createRoom(
        houseId: _houseId!,
        roomName: roomName,
        roomTypeId: roomTypeId,
      );

      _showSnackBar('Комната успешно создана: $roomName');
      Navigator.pop(context); // Возвращаемся на предыдущий экран
    } catch (error) {
      _showSnackBar('Ошибка при создании комнаты: $error');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Добавить комнату',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        backgroundColor: Color(0xFF0B50A0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Название комнаты',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _roomNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите название комнаты',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Выбрать тип',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: _roomTypes.keys.map((roomType) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedRoomType = roomType;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedRoomType == roomType ? Color(0xFF0B50A0) : Color(0xFF94949B),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(8.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        _roomImages[roomType]!,
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 4.0),
                      Text(roomType),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onSavePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0B50A0),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text('Сохранить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}