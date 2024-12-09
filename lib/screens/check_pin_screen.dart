import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckPinScreen extends StatefulWidget {
  @override
  _CheckPinScreenState createState() => _CheckPinScreenState();
}

class _CheckPinScreenState extends State<CheckPinScreen> {
  final _pinController = TextEditingController();
  List<bool> _pinFilled = [false, false, false, false];

  void _onNumberPressed(String number) {
    if (_pinController.text.length < 4) {
      setState(() {
        _pinController.text += number;
        _pinFilled[_pinController.text.length - 1] = true;
      });
    }
  }

  void _onDeletePressed() {
    if (_pinController.text.isNotEmpty) {
      setState(() {
        _pinFilled[_pinController.text.length - 1] = false;
        _pinController.text = _pinController.text.substring(0, _pinController.text.length - 1);
      });
    }
  }

  void _onCheckPressed() async {
    if (_pinController.text.length == 4) {
      final prefs = await SharedPreferences.getInstance();
      final savedPin = prefs.getString('pin');
      if (savedPin != null && _pinController.text == savedPin) {
        _showSnackBar('PIN-код верный');
        Navigator.pushReplacementNamed(context, '/main_room');
      } else {
        _showSnackBar('Неверный PIN-код');
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
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Проверка PIN-кода'),
      ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _pinFilled[index] ? Colors.black : Colors.black.withOpacity(0.2),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 24.0),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF30CCE1).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    children: List.generate(12, (index) {
                      if (index == 9) {
                        return Container();
                      } else if (index == 10) {
                        return _buildNumberButton('0');
                      } else if (index == 11) {
                        return _buildDeleteButton();
                      } else {
                        return _buildNumberButton((index + 1).toString());
                      }
                    }),
                  ),
                ),
                SizedBox(height: 24.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: _onCheckPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF984E4F),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Проверить PIN-код'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextButton(
          onPressed: () => _onNumberPressed(number),
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            padding: EdgeInsets.all(8.0),
          ),
          child: Text(number),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextButton(
          onPressed: _onDeletePressed,
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            padding: EdgeInsets.all(8.0),
          ),
          child: Icon(Icons.backspace),
        ),
      ),
    );
  }
}