import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mymissile extends StatelessWidget {
  final missileX;
  // final missileY;
  final height;
  final missileSize;// can be changes from home page

  Mymissile({
    this.missileSize,
    this.missileX,
    // this.missileY,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        alignment: Alignment(missileX, 1),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          width: 20,
          height: height+missileSize,
          child: Stack(alignment: Alignment.bottomCenter,
          children: [

            Positioned(child: Container(
              width: 4,
              height: height,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.6),
                    blurRadius: 8,
                    spreadRadius: 1
                  )
                ]
              ),
            )),

            // the missile is positioned so tat it follows with the red trail
            Positioned(
              top: 0,
                child:
                Image.asset(
                    'assets/images/spaceMissiles_010.png',
                height: missileSize,
                fit: BoxFit.contain,) )



          ],),
          // width: 4,
          // height: height,

        ),
      );

  }
}
