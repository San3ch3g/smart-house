import 'package:flutter/material.dart';

class AddRoomScreen extends StatefulWidget {
  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _roomNameController = TextEditingController();
  String _selectedRoomType = 'Гостиная';

  final Map<String, String> _roomTypes = {
    'Гостиная': 'assets/living_room_type_image.png',
    'Кухня': 'assets/kitchen_type_image.png',
    'Ванная': 'assets/bathroom_type_image.png',
    'Кабинет': 'assets/cabinet_type_image.png',
    'Спальня': 'assets/bedroom_type_image.png',
    'Зал': 'assets/hall_type_image.png',
  };

  void _onSavePressed() {
    String roomName = _roomNameController.text;
    String roomType = _selectedRoomType;

    if (roomName.isEmpty) {
      _showSnackBar('Пожалуйста, введите название комнаты');
    } else {
      _showSnackBar('Комната сохранена: $roomName, тип: $roomType');
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
            style: TextStyle(fontSize: 14, color: Colors.white)
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
                        _roomTypes[roomType]!,
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
