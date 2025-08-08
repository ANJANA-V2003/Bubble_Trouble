import 'package:flutter/cupertino.dart';

class Purplecharacter extends StatelessWidget {
  const Purplecharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Image.asset('assets/images/purple_body_square.png'),
          Positioned(
            top: 12,
            left: 10,
            child: Image.asset(
              'assets/images/facial_part_eye_open.png',
              width: 15,
            ),
          ),Positioned(
            top: 12,
            left: 35,
            child: Image.asset(
              'assets/images/facial_part_eye_open.png',
              width: 15,
            ),
          ),
          Positioned(
            top: 8,
            left: 4,
            child: Image.asset(
              'assets/images/facial_part_eyebrow_d.png',
              width: 25,
            ),
          ),
          Positioned(
            top: 8,
            left: 30,
            child: Image.asset(
              'assets/images/facial_part_eyebrow_d.png',
              width: 25,
            ),
          ),
          Positioned(
            bottom: 15,
            left: 18,
            child: Image.asset(
              'assets/images/facial_part_mouth_angry.png',
              width: 25,
            ),
          ),
        ],
      ),
    );
  }
}
