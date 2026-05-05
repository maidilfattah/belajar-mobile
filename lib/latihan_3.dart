import 'package:flutter/material.dart';

class LatihanScreen3 extends StatefulWidget {
  const LatihanScreen3({super.key});

  @override
  State<LatihanScreen3> createState() => _LatihanScreenState3();
}

class _LatihanScreenState3 extends State<LatihanScreen3> {
  int _selectedIndex = 0;

  //daftar tampilan tab
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        'Menu 1',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Menu 2',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan 3'),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.black,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Menu 1'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Menu 2'),
        ],
      ),
    );
  }
}
