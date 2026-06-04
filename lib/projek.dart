import 'dart:convert'; // Diperlukan untuk konversi JSON (jsonEncode & jsonDecode)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProjekNote Dark',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.purpleAccent,
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const ProjekNote(),
    );
  }
}

class TargetBelajar {
  String judul;
  bool isSelesai;

  TargetBelajar({required this.judul, this.isSelesai = false});

  // Mengubah objek TargetBelajar menjadi Map (agar bisa diubah ke JSON)
  Map<String, dynamic> toMap() {
    return {'judul': judul, 'isSelesai': isSelesai};
  }

  // Mengubah Map kembali menjadi objek TargetBelajar (saat load dari JSON)
  factory TargetBelajar.fromMap(Map<String, dynamic> map) {
    return TargetBelajar(judul: map['judul'], isSelesai: map['isSelesai']);
  }
}

class ProjekNote extends StatefulWidget {
  const ProjekNote({super.key});

  @override
  State<ProjekNote> createState() => _ProjekNoteState();
}

class _ProjekNoteState extends State<ProjekNote> {
  int _level = 1;
  int _currentExp = 0;
  final int _expPerLevel = 100;
  final int _hadiahExp = 25;

  List<TargetBelajar> _daftarTarget = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // ==================== LOGIKA LOCAL STORAGE ====================

  // Fungsi untuk memuat data dari SharedPreferences
  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _level = prefs.getInt('level') ?? 1;
      _currentExp = prefs.getInt('currentExp') ?? 0;

      // Ambil string JSON daftar target
      String? targetJson = prefs.getString('daftarTarget');
      if (targetJson != null) {
        List<dynamic> mapList = jsonDecode(targetJson);
        _daftarTarget = mapList
            .map((map) => TargetBelajar.fromMap(map))
            .toList();
      } else {
        // Data default jika aplikasi baru pertama kali diinstal
        _daftarTarget = [
          TargetBelajar(judul: "Belajar Dart 30 Menit"),
          TargetBelajar(judul: "Nonton Tutorial Flutter"),
        ];
      }
    });
  }

  // Fungsi untuk menyimpan data ke SharedPreferences
  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('level', _level);
    await prefs.setInt('currentExp', _currentExp);

    // Mengubah List<TargetBelajar> menjadi String JSON
    List<Map<String, dynamic>> mapList = _daftarTarget
        .map((item) => item.toMap())
        .toList();
    String targetJson = jsonEncode(mapList);
    await prefs.setString('daftarTarget', targetJson);
  }

  // ==============================================================

  int get _jumlahTugasSelesai {
    return _daftarTarget.where((target) => target.isSelesai).length;
  }

  void _tambahTarget() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        if (_daftarTarget.length >= 5) {
          _daftarTarget.removeAt(0);
        }
        _daftarTarget.add(TargetBelajar(judul: _textController.text));
        _saveData(); // <--- Simpan perubahan data
      });
      _textController.clear();
    }
  }

  void _toggleTarget(int index) {
    setState(() {
      _daftarTarget[index].isSelesai = !_daftarTarget[index].isSelesai;

      if (_daftarTarget[index].isSelesai) {
        _currentExp += _hadiahExp;

        if (_currentExp >= _expPerLevel) {
          _level++;
          _currentExp -= _expPerLevel;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '🎉 SELAMAT! Kamu naik ke Level $_level! 🎉',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.purple,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        _currentExp -= _hadiahExp;
        if (_currentExp < 0) {
          if (_level > 1) {
            _level--;
            _currentExp = _expPerLevel + _currentExp;
          } else {
            _currentExp = 0;
          }
        }
      }
      _saveData(); // <--- Simpan perubahan data
    });
  }

  void _hapusTarget(int index) {
    setState(() {
      if (_daftarTarget[index].isSelesai && _currentExp >= _hadiahExp) {
        _currentExp -= _hadiahExp;
      }
      _daftarTarget.removeAt(index);
      _saveData(); // <--- Simpan perubahan data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PROJEKNOTE',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ==================== PANEL GAMIFIKASI & STATISTIK ====================
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.purpleAccent,
                      child: Text(
                        'LV $_level',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'PROGRESS MISI',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                '$_currentExp / $_expPerLevel EXP',
                                style: const TextStyle(
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: _currentExp / _expPerLevel,
                            backgroundColor: Colors.grey[800],
                            color: Colors.purpleAccent,
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(color: Colors.white10, height: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.greenAccent,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Misi Selesai: $_jumlahTugasSelesai / ${_daftarTarget.length}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.layers_outlined,
                          color: Colors.white38,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Slot Riwayat: ${_daftarTarget.length}/5',
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ==================== INPUT TARGET BARU ====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Tambah misi baru...',
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF1E1E1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _tambahTarget,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.add, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ==================== DAFTAR MISI BELAJAR ====================
          Expanded(
            child: _daftarTarget.isEmpty
                ? const Center(
                    child: Text(
                      'Semua misi bersih. Siap tambah baru? 🚀',
                      style: TextStyle(color: Colors.white38),
                    ),
                  )
                : ListView.builder(
                    itemCount: _daftarTarget.length,
                    itemBuilder: (context, index) {
                      final item = _daftarTarget[index];
                      return Card(
                        color: const Color(0xFF1E1E1E),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: item.isSelesai
                                ? Colors.purpleAccent.withValues(alpha: 0.3)
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        elevation: 0,
                        child: ListTile(
                          leading: Checkbox(
                            value: item.isSelesai,
                            activeColor: Colors.purpleAccent,
                            checkColor: Colors.black,
                            onChanged: (value) => _toggleTarget(index),
                          ),
                          title: Text(
                            item.judul,
                            style: TextStyle(
                              decoration: item.isSelesai
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: item.isSelesai
                                  ? Colors.white38
                                  : Colors.white,
                              fontWeight: item.isSelesai
                                  ? FontWeight.normal
                                  : FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white38,
                              size: 20,
                            ),
                            onPressed: () => _hapusTarget(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
