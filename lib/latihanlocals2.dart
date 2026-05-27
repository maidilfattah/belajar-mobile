import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LatihanlocalsScreen2 extends StatefulWidget {
  const LatihanlocalsScreen2({super.key});

  @override
  State<LatihanlocalsScreen2> createState() => _LatihanlocalsScreen2State();
}

//state logic
class _LatihanlocalsScreen2State extends State<LatihanlocalsScreen2> {
  //variabel data
  List<String> listTugas = []; //tempat menampung list
  final TextEditingController _tugasController =
      TextEditingController(); // input text diolog

  //aktif saat baru open apk
  @override
  void initState() {
    super.initState();
    muatData(); // untuk ambil data
  }

  //aktif saat apk tutup
  @override
  void dispose() {
    _tugasController.dispose(); //hapus controller
    super.dispose();
  }

  //operasi crud ke local

  Future<void> muatData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //mengambil list
      listTugas = prefs.getStringList('tugas_key') ?? [];
    });
  }

  //Menyipan perubahan data
  Future<void> simpanData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //menyimpan list ke dalam key
    await prefs.setStringList('tugas_key', listTugas);
  }

  void _tampilkanDialogTugas({int? index}) {
    final bool isEdit = index != null;

    _tugasController.text = isEdit ? listTugas[index] : "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? "Ubah Tugas" : "Tambah Tugas"),
          content: TextField(
            controller: _tugasController,
            decoration: const InputDecoration(
              hintText: "Masukkan nama tugas...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            //tombol batal
            TextButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal", style: TextStyle(color: Colors.white)),
            ),

            //tombol konfir
            ElevatedButton(
              onPressed: () async {
                if (_tugasController.text.trim().isEmpty) return;

                setState(() {
                  if (isEdit) {
                    listTugas[index] = _tugasController.text;
                  } else {
                    listTugas.add(_tugasController.text);
                  }
                });

                await simpanData();
                _tugasController.clear();

                //mounted untuk memastikan widget masih ada sebelum tutup dialog
                if (mounted) Navigator.pop(context);
              },
              child: Text(
                isEdit ? "Simpan" : "Tambah",
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latihan Local Storage"),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),

      body: listTugas.isEmpty
          ? const Center(
              child: Text(
                "Belum ada tugas",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: listTugas.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ListTile(
                    title: Text(
                      listTugas[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _tampilkanDialogTugas(index: index),
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),

                        IconButton(
                          onPressed: () async {
                            setState(() {
                              listTugas.removeAt(index);
                            });

                            await simpanData();
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => _tampilkanDialogTugas(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
