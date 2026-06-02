import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class LatihanFileSharing extends StatefulWidget {
  const LatihanFileSharing({super.key});

  @override
  State<LatihanFileSharing> createState() => _LatihanFileSharingState();
}

class _LatihanFileSharingState extends State<LatihanFileSharing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR
      appBar: AppBar(
        title: const Text('Latihan File Sharing'),
        backgroundColor: Colors.yellow,
      ),

      //BODY
      body: Center(
        child: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () async {
                final box = context.findRenderObject() as RenderBox?;
                final Rect? sharePositionOrigin = box != null
                    ? box.localToGlobal(Offset.zero) & box.size
                    : null;

                await SharePlus.instance.share(
                  ShareParams(
                    text: "Hallo",
                    sharePositionOrigin: sharePositionOrigin, //safe
                  ),
                );
              },
              child: const Text("Share"),
            );
          },
        ),
      ),
    );
  }
}
