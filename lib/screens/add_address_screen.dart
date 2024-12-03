import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _houseNumberController = TextEditingController();

  void _onSavePressed() {
    String city = _cityController.text;
    String street = _streetController.text;
    String houseNumber = _houseNumberController.text;

    if (city.isEmpty || street.isEmpty || houseNumber.isEmpty) {
      _showSnackBar('Пожалуйста, заполните все поля');
    } else {
      String address = 'г. $city, ул. $street, д. $houseNumber';
      _showSnackBar('Адрес сохранен: $address');
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
    _cityController.dispose();
    _streetController.dispose();
    _houseNumberController.dispose();
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
              controller: _cityController,
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