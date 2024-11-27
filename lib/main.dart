import 'package:flutter/material.dart';
import 'package:app/Screens/Home.dart';
import 'package:app/Screens/Register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // Define routes
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/register': (context) => RegistrationPage(),
      },
    );
  }
}
