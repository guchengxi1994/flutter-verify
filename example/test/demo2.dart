// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaveBackgroundPage(),
    ),
  );
}

class WaveBackgroundPage extends StatefulWidget {
  const WaveBackgroundPage({super.key});

  @override
  _WaveBackgroundPageState createState() => _WaveBackgroundPageState();
}

class _WaveBackgroundPageState extends State<WaveBackgroundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: 100,
              child: ClipPath(
                clipper: WaveShape(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ClipPath(
                clipper: BottomWaveShape(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text('Body Content')],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WaveShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var p = Path();
    p.lineTo(0, 0);
    p.cubicTo(width * 1 / 2, 0, width * 2 / 4, height, width, height);
    p.lineTo(width, 0);
    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class BottomWaveShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var p = Path();
    p.lineTo(0, 0);
    p.cubicTo(width * 1 / 2, 0, width * 2 / 4, height, width, height);
    p.lineTo(0, height);
    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
