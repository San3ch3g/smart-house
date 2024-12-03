import 'package:flutter/material.dart';

class AddDeviceScreen extends StatefulWidget {
  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final _deviceNameController = TextEditingController();
  final _deviceIdController = TextEditingController();
  final _roomNameController = TextEditingController();
  String _selectedDeviceType = 'Лампа';

  final Map<String, String> _deviceTypes = {
    'Лампа': 'assets/lamp_type_image.png',
    'Кондиционер': 'assets/air_conditioner_type.png',
    'Тостер': 'assets/toaster_type_image.png',
    'Жалюзи': 'assets/window_shutter_type_image.png',
    'Кофеварка': 'assets/coffee_maker_type_image.png',
  };

  void _onSavePressed() {
    String deviceName = _deviceNameController.text;
    String deviceId = _deviceIdController.text;
    String roomName = _roomNameController.text;
    String deviceType = _selectedDeviceType;

    if (deviceName.isEmpty || deviceId.isEmpty || roomName.isEmpty) {
      _showSnackBar('Пожалуйста, заполните все поля');
    } else {
      _showSnackBar('Устройство сохранено: $deviceName, ID: $deviceId, Комната: $roomName, Тип: $deviceType');
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
    _deviceNameController.dispose();
    _deviceIdController.dispose();
    _roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить устройство',
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
              'Название устройства',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _deviceNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите название устройства',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Идентификатор устройства',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _deviceIdController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите идентификатор устройства',
              ),
            ),
            SizedBox(height: 16.0),
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
              'Выбрать устройство',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: _deviceTypes.keys.map((deviceType) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedDeviceType = deviceType;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedDeviceType == deviceType ? Color(0xFF0B50A0) : Color(0xFF94949B),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        _deviceTypes[deviceType]!,
                        width: 60.0,
                        height: 60.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8.0),
                      Text(deviceType),
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
