import 'package:flutter/material.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  List<String> listTugas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latihan CRUD"),
        backgroundColor: Colors.purpleAccent,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: listTugas.isEmpty
          ? Center(child: Text("Belum ada tugas"))
          : ListView.builder(
              itemCount: listTugas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listTugas[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        // trailing fungsinya untuk menaruh wiget di ujung kanan
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            listTugas[index] =
                                "${listTugas[index]} (Diperbarui)";
                          });
                        },
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            listTugas.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //set layar
            listTugas.add("Tugas Baru ${listTugas.length + 1}");
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
