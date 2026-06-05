import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal otomatis

// ==================== 1. MODEL DATA (MISI & CATATAN) ====================
class TargetBelajar {
  String judul;
  bool isSelesai;

  TargetBelajar({required this.judul, this.isSelesai = false});

  Map<String, dynamic> toMap() {
    return {'judul': judul, 'isSelesai': isSelesai};
  }

  factory TargetBelajar.fromMap(Map<String, dynamic> map) {
    return TargetBelajar(
      judul: map['judul'] ?? '',
      isSelesai: map['isSelesai'] ?? false,
    );
  }
}

class CatatanModel {
  String id;
  String judul;
  String isi;
  String tanggal;

  CatatanModel({
    required this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'judul': judul, 'isi': isi, 'tanggal': tanggal};
  }

  factory CatatanModel.fromMap(Map<String, dynamic> map) {
    return CatatanModel(
      id: map['id'] ?? '',
      judul: map['judul'] ?? '',
      isi: map['isi'] ?? '',
      tanggal: map['tanggal'] ?? '',
    );
  }
}

// ==================== 2. NAVIGASI UTAMA (WIDGET UTAMA) ====================
class ProjekNote extends StatefulWidget {
  const ProjekNote({super.key});

  @override
  State<ProjekNote> createState() => _ProjekNoteState();
}

class _ProjekNoteState extends State<ProjekNote> {
  int _currentIndex = 0;

  final List<Widget> _halaman = [
    const ProjekNoteCatatanList(),
    const ProjekNoteMisi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: _halaman[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: const Color(0xFF000000),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.description_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.description),
              ),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.assignment_turned_in_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.assignment_turned_in_rounded),
              ),
              label: 'Tasks',
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== TAB 1: HALAMAN MISI BELAJAR ====================
class ProjekNoteMisi extends StatefulWidget {
  const ProjekNoteMisi({super.key});

  @override
  State<ProjekNoteMisi> createState() => _ProjekNoteMisiState();
}

class _ProjekNoteMisiState extends State<ProjekNoteMisi> {
  int _level = 1;
  int _currentExp = 0;
  final int _expPerLevel = 100;
  final int _hadiahExp = 25;

  List<TargetBelajar> _daftarTarget = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMisiData();
  }

  void _loadMisiData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _level = prefs.getInt('level') ?? 1;
      _currentExp = prefs.getInt('currentExp') ?? 0;

      String? targetJson = prefs.getString('daftarTarget');
      if (targetJson != null) {
        List<dynamic> mapList = jsonDecode(targetJson);
        _daftarTarget = mapList
            .map((map) => TargetBelajar.fromMap(map))
            .toList();
      } else {
        _daftarTarget = [];
      }
    });
  }

  void _saveMisiData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('level', _level);
    await prefs.setInt('currentExp', _currentExp);

    List<Map<String, dynamic>> mapList = _daftarTarget
        .map((item) => item.toMap())
        .toList();
    await prefs.setString('daftarTarget', jsonEncode(mapList));
  }

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
        _saveMisiData();
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
                'SELAMAT! Kamu naik ke Level $_level! 🚀',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: const Color(0xFFF1A80A),
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
      _saveMisiData();
    });
  }

  void _hapusTarget(int index) {
    setState(() {
      if (_daftarTarget[index].isSelesai && _currentExp >= _hadiahExp) {
        _currentExp -= _hadiahExp;
      }
      _daftarTarget.removeAt(index);
      _saveMisiData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        // Icon settings di halaman task juga dihapus agar konsisten bersih
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: const Color(0xFFF1A80A),
                      child: Text(
                        'LV $_level',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
                                'PROGRESS LEVEL',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white54,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                '$_currentExp / $_expPerLevel EXP',
                                style: const TextStyle(
                                  color: Color(0xFFF1A80A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: _currentExp / _expPerLevel,
                            backgroundColor: Colors.white10,
                            color: const Color(0xFFF1A80A),
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.white10, height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selesai: $_jumlahTugasSelesai / ${_daftarTarget.length}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Slot Riwayat: ${_daftarTarget.length}/5',
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
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
                      hintStyle: const TextStyle(color: Colors.white24),
                      filled: true,
                      fillColor: const Color(0xFF1C1C1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _tambahTarget,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1A80A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Icon(Icons.add, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _daftarTarget.isEmpty
                ? const Center(
                    child: Text(
                      'Semua misi bersih. Siap tambah baru?',
                      style: TextStyle(color: Colors.white24),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _daftarTarget.length,
                    itemBuilder: (context, index) {
                      final item = _daftarTarget[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          leading: Checkbox(
                            value: item.isSelesai,
                            activeColor: const Color(0xFFF1A80A),
                            checkColor: Colors.black,
                            shape: const CircleBorder(),
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
                                  : FontWeight.w400,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white38,
                              size: 18,
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

// ==================== TAB 2: HALAMAN LIST UTAMA CATATAN ====================
class ProjekNoteCatatanList extends StatefulWidget {
  const ProjekNoteCatatanList({super.key});

  @override
  State<ProjekNoteCatatanList> createState() => _ProjekNoteCatatanListState();
}

class _ProjekNoteCatatanListState extends State<ProjekNoteCatatanList> {
  List<CatatanModel> _daftarCatatan = [];

  @override
  void initState() {
    super.initState();
    _loadSemuaCatatan();
  }

  void _loadSemuaCatatan() async {
    final prefs = await SharedPreferences.getInstance();
    String? catatanJson = prefs.getString('listCatatanData');
    if (catatanJson != null) {
      List<dynamic> mapList = jsonDecode(catatanJson);
      setState(() {
        _daftarCatatan = mapList
            .map((map) => CatatanModel.fromMap(map))
            .toList();
      });
    }
  }

  void _hapusCatatan(String id) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _daftarCatatan.removeWhere((item) => item.id == id);
    });
    List<Map<String, dynamic>> mapList = _daftarCatatan
        .map((item) => item.toMap())
        .toList();
    await prefs.setString('listCatatanData', jsonEncode(mapList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        // DICORET/DIHAPUS: Folder open & Settings Icon di bagian actions
      ),
      body: _daftarCatatan.isEmpty
          ? const Center(
              child: Text(
                'Belum ada catatan. Tekan + untuk membuat.',
                style: TextStyle(color: Colors.white24),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _daftarCatatan.length,
              itemBuilder: (context, index) {
                final note = _daftarCatatan[index];
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjekNoteEditor(catatan: note),
                      ),
                    );
                    _loadSemuaCatatan();
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: const Color(0xFF1C1C1E),
                        title: const Text(
                          'Hapus Catatan?',
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Batal',
                              style: TextStyle(color: Colors.white38),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _hapusCatatan(note.id);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Hapus',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.judul.isEmpty ? 'Tanpa Judul' : note.judul,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          note.isi.isEmpty
                              ? 'Tidak ada teks tambahan'
                              : note.isi,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          note.tanggal,
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF1A80A),
        foregroundColor: Colors.black,
        shape: const CircleBorder(),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProjekNoteEditor()),
          );
          _loadSemuaCatatan();
        },
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

// ==================== HALAMAN EDITOR/DETAIL CATATAN ====================
class ProjekNoteEditor extends StatefulWidget {
  final CatatanModel? catatan;

  const ProjekNoteEditor({super.key, this.catatan});

  @override
  State<ProjekNoteEditor> createState() => _ProjekNoteEditorState();
}

class _ProjekNoteEditorState extends State<ProjekNoteEditor> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _currentId = '';
  String _tanggalTeks = '';

  @override
  void initState() {
    super.initState();
    if (widget.catatan != null) {
      _currentId = widget.catatan!.id;
      _titleController.text = widget.catatan!.judul;
      _noteController.text = widget.catatan!.isi;
      _tanggalTeks = widget.catatan!.tanggal;
    } else {
      _currentId = DateTime.now().millisecondsSinceEpoch.toString();
      _tanggalTeks = DateFormat('MMMM dd, yyyy').format(DateTime.now());
    }
  }

  void _saveData() async {
    if (_titleController.text.isEmpty && _noteController.text.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    String? catatanJson = prefs.getString('listCatatanData');
    List<CatatanModel> listTemporer = [];

    if (catatanJson != null) {
      List<dynamic> mapList = jsonDecode(catatanJson);
      listTemporer = mapList.map((map) => CatatanModel.fromMap(map)).toList();
    }

    int indexLama = listTemporer.indexWhere((item) => item.id == _currentId);

    CatatanModel dataBaru = CatatanModel(
      id: _currentId,
      judul: _titleController.text,
      isi: _noteController.text,
      tanggal: _tanggalTeks,
    );

    if (indexLama != -1) {
      listTemporer[indexLama] = dataBaru;
    } else {
      listTemporer.insert(0, dataBaru);
    }

    List<Map<String, dynamic>> mapBaru = listTemporer
        .map((item) => item.toMap())
        .toList();
    await prefs.setString('listCatatanData', jsonEncode(mapBaru));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _saveData(); // Tetap auto-save ketika menekan tombol back biasa
            Navigator.pop(context);
          },
        ),
        actions: [
          // DICORET/DIHAPUS: Icon Share_outlined di bagian depan actions
          IconButton(
            icon: const Icon(Icons.check, color: Color(0xFFF1A80A), size: 28),
            onPressed: () {
              _saveData();
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: 'Judul Catatan',
                hintStyle: TextStyle(
                  color: Colors.white38,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
            ),
            Text(
              "$_tanggalTeks  |  ${_noteController.text.length} characters",
              style: const TextStyle(color: Colors.white38, fontSize: 13),
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.white10, height: 1),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _noteController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.6,
                ),
                onChanged: (text) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: 'Mulai ketik...',
                  hintStyle: TextStyle(color: Colors.white24),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
