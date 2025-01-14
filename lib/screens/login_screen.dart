import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_house/server/server.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final SupabaseService _supabaseService = SupabaseService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        // Вход пользователя
        final AuthResponse response = await _supabaseService.loginUser(
          email: email,
          password: password,
        );

        if (response.user != null) {
          // Сохранение userId (UUID) в локальное хранилище
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', response.user!.id);

          // Переход к следующему экрану (например, главному экрану)
          Navigator.pushReplacementNamed(context, '/main_room');
        } else {
          _showSnackBar('Ошибка при входе: Пользователь не найден');
        }
      } catch (error) {
        _showSnackBar('Ошибка при входе: $error');
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/background_image.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF30CCE1).withOpacity(0.8),
                  Color(0xFF30CCE1).withOpacity(0.6),
                  Color(0xFF30CCE1).withOpacity(0.4),
                  Color(0xFF30CCE1).withOpacity(0.2),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/login_image.png',
                  height: 200,
                ),
                SizedBox(height: 24.0),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF30CCE1).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Электронная почта',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите вашу электронную почту';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите ваш пароль';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF984E4F),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Войти'),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/registration');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF2A2A37),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Регистрация'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}