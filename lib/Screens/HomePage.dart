import 'package:app/Screens/Addexpense.dart';
import 'package:app/Screens/CardDetails.dart';
import 'package:app/Screens/Dashboard.dart';
import 'package:app/Screens/MainPage.dart';
import 'package:app/Widgets/bottomnav.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    Mainpage(),
    AddExpensePage(),
    DashboardPage(),
    CardDetailsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _screens[_selectedIndex], // Display selected screen
      bottomNavigationBar: const Bottom(),
    );
  }
}
