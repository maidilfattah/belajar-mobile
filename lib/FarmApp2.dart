import 'package:flutter/material.dart';

class Farmapp2Screen extends StatefulWidget {
  const Farmapp2Screen({super.key});

  @override
  State<Farmapp2Screen> createState() => _Farmapp2ScreenState();
}

class _Farmapp2ScreenState extends State<Farmapp2Screen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: SafeArea(
                  bottom: false,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: Image.network(
                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=1000',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              Expanded(flex: 3, child: Container()),

              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height:
                      MediaQuery.of(context).size.height *
                      0.45, //ambil 45% dari layar
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(screenWidth * 0.5, 60),
                      topRight: Radius.elliptical(screenWidth * 0.5, 60),
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Farm",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),

                            child: const Text(
                              "2",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Text(
                            "Table",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Connect directly with farmers and Consumers.\nFresh produce, fair prices and a thriving Community.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
