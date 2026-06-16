import 'package:flutter/material.dart';

class LatihanToday extends StatefulWidget {
  const LatihanToday({super.key});

  @override
  State<LatihanToday> createState() => _LatihanTodayState();
}

class _LatihanTodayState extends State<LatihanToday> {
  Color color1 = Colors.red;
  Color colors2 = Colors.amber;
  Color targetColor = Colors.blue;
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Latihan Draggable, DragTarget, SizedBox, Material",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Draggable<Color>(
                data: color1,
                feedback: SizedBox(
                  width: 50,
                  height: 50,
                  child: Material(
                    // FIXED HERE: Using withValues instead of withOpacity
                    color: color1.withValues(alpha: 0.6),
                    shape: const StadiumBorder(),
                    elevation: 3,
                  ),
                ),
                childWhenDragging: const SizedBox(
                  width: 50,
                  height: 50,
                  child: Material(
                    color: Colors.black26,
                    shape: StadiumBorder(),
                    elevation: 0,
                  ),
                ),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Material(
                    color: color1,
                    shape: const StadiumBorder(),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),

          DragTarget<Color>(
            onWillAcceptWithDetails: (details) => true,
            onAcceptWithDetails: (details) {
              setState(() {
                isAccepted = true;
                targetColor = details.data;
              });
            },
            builder: (context, candidateData, rejectedData) {
              return (isAccepted)
                  ? SizedBox(
                      width: 100,
                      height: 100,
                      child: Material(
                        color: targetColor,
                        shape: const StadiumBorder(),
                        elevation: 3,
                      ),
                    )
                  : const SizedBox(
                      width: 100,
                      height: 100,
                      child: Material(
                        color: Colors.black26,
                        shape: StadiumBorder(),
                        elevation: 3,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
