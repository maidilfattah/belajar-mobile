import 'package:flutter/material.dart';

class LatihanScreen2 extends StatefulWidget {
  const LatihanScreen2({super.key});

  @override
  State<LatihanScreen2> createState() => _LatihanScreenState2();
}

class _LatihanScreenState2 extends State<LatihanScreen2> {
  //int _counter = 0; //counter value
  int _selectedIndex = 0; // track selected bottom menu

  // fungsi untuk bottom navigation tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //fungsi untuk mengubah isi body berdasarkan tab
  Widget _getBody() {
    if (_selectedIndex == 0) {
      //menu 1
      return Center(
        child: Text(
          'Menu 1 Screen', //tampilan counter value
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      // menu 2
      return const Center(
        child: Text(
          'Menu 2 Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //top
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Latihan_2'),
      ),
      // body berubah tergantung menu yang dipilih
      body: _getBody(),

      /*      //tampilan tutton hanya di menu 1
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.pink,
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
*/
      // bottom BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Active tab
        onTap: _onItemTapped, //handle tab
        selectedItemColor: Colors.pink,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Menu1'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Menu2'),
        ],
      ),
    );
  }
}
