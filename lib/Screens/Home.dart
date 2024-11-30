import 'package:flutter/material.dart';
import 'package:app/Screens/Login.dart';
import 'package:app/Screens/Register.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF6F7), // Background color
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 20),
              Column(
                children: [
                  // 3D Illustration Placeholder
                  SizedBox(
                    height: 250,
                    child: Image.asset(
                        'assets/images/Group.png'), // Add your illustration here
                  ),
                  SizedBox(height: 20),
                  // Title Text
                  Text(
                    'Ухаалаг Зарцуулж\nИлүү Хэмнэе',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(84, 19, 139, 123),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationPage()),
                        );
                      },
                      child: Text(
                        'Эхлэх',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Footer Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Add navigation logic for rights info
                        },
                        child: Text(
                          'Харилцагчийн Эрх Бий Юу?',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Text('|', style: TextStyle(color: Colors.black45)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'Нэвтрэх',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
