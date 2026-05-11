import 'package:flutter/material.dart';

class WaContact extends StatefulWidget {
  const WaContact({super.key});

  @override
  State<WaContact> createState() => _WaContactState();
}

class _WaContactState extends State<WaContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0, //untuk bayngan
        //untuk icon kembali (leading buat icon ciri mentok)
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),

        titleSpacing: 0, //untuk sapasi jarak setelah dan sebelum judul

        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey),
            ),

            SizedBox(width: 10), //jarak 10px diantara foto dan nama kontak

            Text(
              "Budi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        //icon sebelah kanan
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(12), //kiri kanan atas bawah padding 12px
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // text dari sebelah awal/kiri
          children: [
            //chat bagian kiri
            Align(
              alignment: Alignment.centerLeft,

              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Text("halo, lagi apa?", style: TextStyle(fontSize: 16)),
              ),
            ),

            SizedBox(height: 10),

            //chat kanan
            Align(
              alignment: Alignment.centerRight,

              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Text(
                  "lagi belajar nih bang",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
