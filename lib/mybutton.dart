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
    this.color}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(16),
          backgroundColor: color ?? Colors.grey[300],
          shadowColor: Colors.black54,
          elevation: 6,
        ),
        child: Icon(
          icon,
          color: Colors.black87,
          size: 24,
        ),
      );
    // return GestureDetector(
    //   onTap: function,
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(10),
    //     child: Container(
    //       color: Colors.grey[100],
    //       width: 50,
    //       height: 50,
    //       child: Center(child:Icon(icon)),
    //     ),
    //   ),
    // );
  }
}
