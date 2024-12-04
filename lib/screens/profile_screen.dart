import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameController = TextEditingController(text: 'test-user');
  final _emailController = TextEditingController(text: 'someemail@mail.ru');
  final _addressController = TextEditingController(text: 'г. Омск, ул. Ленина, д. 24');
  final _passwordController = TextEditingController(text: 'qwerty123');

  bool _isEditing = false;

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    print('Профиль сохранен:');
    print('Имя пользователя: ${_usernameController.text}');
    print('Электронная почта: ${_emailController.text}');
    print('Адрес: ${_addressController.text}');
    print('Пароль: ${_passwordController.text}');

    _toggleEditMode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Личный кабинет',
          style: TextStyle(color: Colors.white),
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
            Center(
              child: Text(
                'Профиль',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('assets/profile_image.png'),
              ),
            ),
            SizedBox(height: 16.0),
            _buildProfileField('Имя пользователя', _usernameController),
            SizedBox(height: 16.0),
            _buildProfileField('Электронная почта', _emailController),
            SizedBox(height: 16.0),
            _buildProfileField('Адрес', _addressController),
            SizedBox(height: 16.0),
            _buildProfileField('Пароль', _passwordController),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isEditing ? _saveProfile : _toggleEditMode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isEditing ? Colors.green : Color(0xFF0B50A0),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text(_isEditing ? 'Сохранить' : 'Редактировать'),
                ),
                if (_isEditing)
                  ElevatedButton(
                    onPressed: _toggleEditMode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Отмена'),
                  ),
                if (!_isEditing)
                  ElevatedButton(
                    onPressed: () {
                      print('Нажата кнопка "Выйти"');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Выйти'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        TextField(
          controller: controller,
          enabled: _isEditing,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: label,
          ),
        ),
      ],
    );
  }
}
