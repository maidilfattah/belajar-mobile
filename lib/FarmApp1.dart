import 'package:flutter/material.dart';

class Farmapp1Screen extends StatefulWidget {
  const Farmapp1Screen({super.key});

  @override
  State<Farmapp1Screen> createState() => _Farmapp1ScreenState();
}

class _Farmapp1ScreenState extends State<Farmapp1Screen> {
  @override
  Widget build(BuildContext context) {
    var stack = Stack(
      clipBehavior: Clip.none, // Biar daun nggak kepotong
      children: [
        // 1. Kotak Oranye (Taruh di paling bawah Stack)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12, // Jarak kanan-kiri di dalam kotak
              vertical: 10, // Jarak atas-bawah di dalam kotak
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
            // Membungkus teks dengan Center agar angka 2 tepat di tengah
            child: const Center(
              child: Text(
                "2",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        // 2. Icon Daun (Taruh di atas kotak)
        const Positioned(
          top: 0,
          right: 4, // Mengatur posisi daun di sebelah kanan atas kotak
          child: Icon(Icons.spa, color: Colors.white, size: 22),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: const Color(0xFF128C4F), // Warna hijau yang mirip asli
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Teks "Farm"
            const Text(
              "Farm",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),

            // Wadah Stack (Ukurannya diperbesar agar kotak oranye bebas melebar)
            SizedBox(
              width: 55, // Dinaikkan dari 40 agar muat kotak yang melebar
              height: 60, // Menyediakan ruang vertikal untuk daun di atas
              child: stack,
            ),
            const SizedBox(width: 8),

            // Teks "Table"
            const Text(
              "Table",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
