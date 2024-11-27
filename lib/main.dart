import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app/Screens/Home.dart';
import 'package:app/Screens/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
