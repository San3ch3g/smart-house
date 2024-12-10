import 'package:flutter/material.dart';

class DevicesScreen extends StatefulWidget {
  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final Map<String, bool> _devices = {
    'Лампа': false,
    'Кондиционер': false,
    'Тостер': false,
  };

  final Map<String, String> _deviceImages = {
    'Лампа': 'assets/lamp_type_image.png',
    'Кондиционер': 'assets/air_conditioner_type.png',
    'Тостер': 'assets/toaster_type_image.png',
  };

  void _onDeviceSwitchChanged(String deviceName, bool value) {
    setState(() {
      _devices[deviceName] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: _devices.keys.map((deviceName) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: _buildDeviceButton(deviceName, _devices[deviceName]!),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_device');
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(0xFF0B50A0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildCategoryButton(BuildContext context, String label) {
    return ElevatedButton(
      onPressed: () {
        if (label == 'Комнаты') {
          Navigator.pushNamed(context, '/main_room');
        } else if (label == 'Устройства') {
        } else if (label == 'Пользователь') {
          Navigator.pushNamed(context, '/users');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0B50A0),
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(label),
    );
  }

  Widget _buildDeviceButton(String deviceName, bool isOn) {
    return Container(
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF0B50A0), width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          print('Выбрано устройство: $deviceName');
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
                _deviceImages[deviceName]!,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.0),
            Text(deviceName),
            Switch(
              value: isOn,
              onChanged: (value) {
                _onDeviceSwitchChanged(deviceName, value);
              },
              activeColor: Color(0xFF0B50A0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}