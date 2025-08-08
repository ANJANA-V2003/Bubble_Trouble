import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {

  final double ballX;
  final double ballY;
  const MyBall({
    required this.ballX,
    required this.ballY,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Stack(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade800],
                center: Alignment(-0.5, -0.5),
                radius: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade900.withOpacity(0.6),
                  offset: Offset(3, 3),
                  blurRadius: 6
                )
              ]
            ),
          ),

          // shine highlight for 3D effect
          Positioned(
            top: 6,
              left: 6,
              child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.4)
            ),
          ))
        ]
      ),
    );
  }
}
