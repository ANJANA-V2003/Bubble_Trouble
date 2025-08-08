import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback function;
  final Color ? color;

  const MyButton({
    Key?key,
    required this.icon,
    required this.function,
    this.color
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Material(
        shape: const CircleBorder(),
        elevation: 10,
        color: Colors.transparent,
        child: InkWell(
          onTap: function,
          customBorder: const CircleBorder(),
          splashColor: Colors.white24,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  (color ?? Colors.grey).withOpacity(0.9),
                  (color ?? Colors.grey[700]!) // darker edge
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(2, 4),
                  blurRadius: 6,
                )
              ],
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ),
      );
      // ElevatedButton(
      //   onPressed: function,
      //   style: ElevatedButton.styleFrom(
      //     shape: CircleBorder(),
      //     padding: EdgeInsets.all(16),
      //     backgroundColor: color ?? Colors.grey[300],
      //     shadowColor: Colors.black54,
      //     elevation: 6,
      //   ),
      //   child: Icon(
      //     icon,
      //     color: Colors.black87,
      //     size: 24,
      //   ),
      // );

  }
}
