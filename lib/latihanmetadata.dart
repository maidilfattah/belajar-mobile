import 'package:flutter/material.dart';

//custom metadata
class Todo {
  final String nama;
  final String pesan;

  //wajib const
  const Todo({required this.nama, required this.pesan});
}

//FUNGSI UTAMA UNTUK MENJALANKAN APLIKASI
void main() {
  runApp(const MaterialApp(home: LatihanMetaData()));
}

class LatihanMetaData extends StatefulWidget {
  const LatihanMetaData({super.key});

  @override
  State<LatihanMetaData> createState() => _LatihanMetaDataState();
}

class _LatihanMetaDataState extends State<LatihanMetaData> {
  int _counter = 0;

  //MENEMPELKAN CUSTOM METADATA
  @Todo(nama: "Aidil", pesan: "Tolong tambahkan agar angka tidak minus")
  void _kurangiAngka() {
    setState(() {
      _counter--;
    });
  }

  @Deprecated("Pakai fungsi baru")
  void _fungsiMasaLalu() {
    debugPrint("Fungsi ini udah tua");
  }

  @override
  Widget build(BuildContext context) {
    _fungsiMasaLalu();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Belajar Metadata"),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Angka sekarang:", style: TextStyle(fontSize: 18)),
            Text(
              "$_counter",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //buttom fungsi untuk  memanggil meta data
                ElevatedButton(
                  onPressed: _kurangiAngka,
                  child: const Text("Kurang (-)"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  child: const Text("Tambah (+)"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
