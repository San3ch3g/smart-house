import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_house/server/server.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _addressController = TextEditingController();
  final SupabaseService _supabaseService = SupabaseService();

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  void _loadAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedAddress = prefs.getString('address');
    if (savedAddress != null) {
      setState(() {
        _addressController.text = savedAddress;
      });
    }
  }

  void _onSavePressed() async {
    String address = _addressController.text;

    if (address.isEmpty) {
      _showSnackBar('Пожалуйста, заполните поле адреса');
    } else {
      // Сохраняем адрес в локальной памяти
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('address', address);

      final userId = prefs.getString('userId');

      if (userId != null) {
        try {
          await _supabaseService.createHouse(ownerId: userId, address: address);
          _showSnackBar('Адрес сохранен и дом зарегистрирован: $address');

          final houseId = await _supabaseService.getHouseIdByAddress(address);

          if (houseId != null) {
            await prefs.setString('houseId', houseId);
            _showSnackBar('House ID сохранен: $houseId');
          } else {
            _showSnackBar('Ошибка: house ID не найден');
          }

          Navigator.pushReplacementNamed(context, '/main_room');
        } catch (error) {
          _showSnackBar('Ошибка при создании дома: $error');
        }
      } else {
        _showSnackBar('Ошибка: пользователь не найден');
      }
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
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить адрес'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Добавьте адрес своего дома в формате:\nг. Название города, ул. Название улицы, д. Номер дома',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Адрес',
                border: OutlineInputBorder(),
              ),
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
                child: Text('Сохранить адрес'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}