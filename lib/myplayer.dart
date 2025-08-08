import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component/purplecharacter.dart';
//
// class MyPlayer extends StatelessWidget {
//   final playerX;
//
//    MyPlayer({this.playerX});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       // -1 left & top , +1 right & bottom,0 & 0 centre
//       alignment: Alignment(playerX, 1), // for the player to move the x co-ordinate should be not hard-coded
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Container(
//           color: Colors.deepPurple,
//           height: 50,
//           width: 50,
//         ),
//       ),
//     );
//   }
// }

class MyPlayer extends StatelessWidget {
  final double playerX;
  final bool isFiring;

  const MyPlayer({
    required this.playerX,
    this.isFiring = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(playerX, 1),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: isFiring ? [Colors.redAccent, Colors.orangeAccent] : [Colors.deepPurple, Colors.purpleAccent],
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 4,
              spreadRadius: 2,
            ),
            if (isFiring)
              BoxShadow(
                color: Colors.redAccent.withOpacity(0.6),
                blurRadius: 12,
                spreadRadius: 2,
              ),
          ],
        ),
        child: const Purplecharacter(),
      ),
    );
  }
}

