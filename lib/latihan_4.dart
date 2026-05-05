import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: LatihanScreen4(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class LatihanScreen4 extends StatefulWidget {
  const LatihanScreen4({super.key});

  @override
  State<LatihanScreen4> createState() => _LatihanScreenState4();
}

class _LatihanScreenState4 extends State<LatihanScreen4> {
  // Index untuk mengontrol halaman bawah (BottomNavigationBar)
  int _selectedIndex = 0;

  // Fungsi untuk berpindah menu bawah
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Definisi kategori untuk Tab Bar di bagian atas
    final List<String> categories = ['Default', 'Good'];

    // List yang menampung tampilan utama aplikasi
    final List<Widget> _pages = [
      // HALAMAN 1: Library (Berisi Tab Bar + Grid Manga)
      DefaultTabController(
        length: categories.length,
        child: Scaffold(
          backgroundColor: const Color(0xFF0F171E),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0F171E),
            elevation: 0,
            title: const Text(
              'Library',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.filter_list, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
            ],
            // Menu Tab kategori diletakkan di bagian bottom AppBar
            bottom: TabBar(
              isScrollable: false,
              indicatorColor: Colors.blueAccent,
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.grey,
              tabs: categories.map((cat) => Tab(text: cat)).toList(),
            ),
          ),
          // TabBarView menampilkan konten berdasarkan tab yang dipilih
          body: TabBarView(
            children: [
              const LibraryGrid(categoryName: 'Default'),
              const LibraryGrid(categoryName: 'Good'),
            ],
          ),
        ),
      ),

      // HALAMAN 2: Profile (Halaman contoh kosong)
      const Scaffold(
        backgroundColor: Color(0xFF0F171E),
        body: Center(
          child: Text(
            'User Profile Screen',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    ];

    return Scaffold(
      // Menampilkan halaman sesuai index yang dipilih di bawah
      body: _pages[_selectedIndex],
      
      // Navigasi Utama di bagian bawah layar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }
}

// --- WIDGET UNTUK TAMPILAN GRID MANGA ---
// Pastikan kurung kurawal pembuka { berada setelah nama class
class LibraryGrid extends StatelessWidget {
  final String categoryName;
  
  // Constructor untuk menerima data kategori dari halaman utama
  const LibraryGrid({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,           // 2 Kolom menyamping
        childAspectRatio: 0.68,      // Rasio tegak untuk cover manga
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 6, // Contoh menampilkan 6 item
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8), // Pojok kotak melengkung
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Gambar Cover (Menggunakan Picsum dengan seed agar gambar unik)
              Image.network(
                'https://picsum.photos/seed/${categoryName}_$index/300/450',
                fit: BoxFit.cover,
              ),

              // 2. Layer Gradient (Gelap di bawah agar teks putih terbaca jelas)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                    stops: [0.6, 1.0],
                  ),
                ),
              ),

              // 3. Teks Judul Manga
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Text(
                  '$categoryName Manga $index',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),

              // 4. Badge Angka (Misalnya jumlah chapter) di kiri atas
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${(index + 1) * 12}',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  } // Penutup Widget build
} // Penutup Class LibraryGrid