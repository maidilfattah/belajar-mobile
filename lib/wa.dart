import 'package:flutter/material.dart';

class WaScreen extends StatefulWidget {
  const WaScreen({super.key});

  @override
  State<WaScreen> createState() => _WaScreenState();
}

class _WaScreenState extends State<WaScreen> {
  Widget _buildChatTile({
    required String name,
    required String message,
    required String time,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.grey,
        child: Icon(Icons.person, size: 38),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
      trailing: Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
      onTap: () {}, //aksi ketika chat diclick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        titleSpacing: 0,
        title: const Text(
          "WhatsApp",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              "hallo aidil",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildChatTile(
                  name: "Hasbi",
                  message: "siap, otw",
                  time: "10.30",
                ),
                _buildChatTile(
                  name: "Siti",
                  message: "Terima kasih",
                  time: "09.15",
                ),
                _buildChatTile(
                  name: "Grup Keluarga",
                  message: "Ayah: Jangan lupa makan siang",
                  time: "07.00",
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        child: Icon(Icons.chat, color: Colors.black),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, //label tidak bergeser
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: "Update"),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: "Communities",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_outlined),
            label: "Calls",
          ),
        ],
      ),
    );
  }
}
