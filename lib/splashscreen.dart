import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bubble Trouble",
                style: TextStyle(fontFamily: 'PressStart', color: Colors.deepPurple,fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
