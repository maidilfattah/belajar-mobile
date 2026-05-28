import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LatihanLayout extends StatefulWidget {
  const LatihanLayout({super.key});

  @override
  State<LatihanLayout> createState() => _LatihanLayoutState();
}

class _LatihanLayoutState extends State<LatihanLayout> {
  List<String> myNotes = []; //variabel untunk menyimpan data

  @override
  void initState() {
    super.initState();
    _loadNotes(); // mengambil data saat open
  }

  //fungsi ambil data dari local storage
  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      myNotes = prefs.getStringList("kumpulan_catatan") ?? [];
    });
  }

  //fungsi untuk menambah catatan baru
  Future<void> _addNote(String newNote) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      myNotes.add(newNote);
    });
    await prefs.setStringList("kumpulan_catatan", myNotes);
  }

  Future<void> _deleteNote(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      myNotes.removeAt(index);
    });
    await prefs.setStringList("kumpulan_catatan", myNotes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Note")),

      body: ListView.builder(
        itemCount: myNotes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(myNotes[index]),
                ),
                IconButton(
                  onPressed: () {
                    _deleteNote(index);
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNote("Catatan baru");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
