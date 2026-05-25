import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LatihanlocalsScreen extends StatefulWidget {
  const LatihanlocalsScreen({super.key});

  @override
  State<LatihanlocalsScreen> createState() => _LatihanlocalsScreenState();
}

class _LatihanlocalsScreenState extends State<LatihanlocalsScreen> {
  List<String> listTugas = [];
  @override
  void initState() {
    super.initState();
    muatData(); // memanggil fungsi muat data waktu apk terbuka
  }

  Future<void> muatData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listTugas = prefs.getStringList('tugas_key') ?? [];
    });
  }

  Future<void> simpanData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tugas_key', listTugas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latihan Local Storage"),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),

      body: listTugas.isEmpty
          ? Center(
              child: Text(
                "Belum ada tugas",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: listTugas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    listTugas[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            listTugas[index] =
                                "${listTugas[index]}(Diperbarui)";
                          });
                          await simpanData();
                        },
                        icon: Icon(Icons.edit, color: Colors.black),
                      ),

                      IconButton(
                        onPressed: () async {
                          setState(() {
                            listTugas.removeAt(index);
                          });
                          await simpanData();
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          setState(() {
            listTugas.add("Tugas Baru ${listTugas.length + 1}");
          });
          await simpanData();
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
