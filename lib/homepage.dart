import 'dart:async';
import 'dart:math';

import 'package:bubble_trouble/myball.dart';
import 'package:bubble_trouble/mybutton.dart';
import 'package:bubble_trouble/myplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'mymissile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

enum direction{LEFT,RIGHT} // it's just the list of direction we need

class _HomepageState extends State<Homepage> {

  Timer? gameLoopTimer;
  // game state
  bool gameStarted = false;

  // Player starts with 3 lives
  int lives = 3;

  // score variable
  int score=0;

  // player variables
   static  double playerX =0;

  // missile variables
  double missileX = playerX; // to keep missile with the player
  double missileHeight = 10;
  double missileSize =20;
  bool midShot = false;

  // ball variables
   double ballX = 0.5;
   double ballY = 1;
   var ballDirection = direction.LEFT;

   void startGame(){
     gameStarted =true;
     double time=0;
     double height=0;
     double velocity =60; // how strong jump is
    gameLoopTimer=Timer.periodic(Duration(milliseconds: 10), (timer) {
      // quadratic equation that models a bounce (upside down parabola)
      height = -5 * time * time + velocity * time;

      // if ball reaches the ground, reset the jump
      if(height<0){
        time =0;
      }

      // update the new ball position
      setState(() {
        ballY = heightToPosition(height);
      });


      // if the ball hits the left wall, then change direction to right
      if(ballX - 0.005 < -1){
        ballDirection = direction.RIGHT;
      }

      // if the ball hits the right wall, then change direction to left
      else if(ballX + 0.005 > 1){
        ballDirection = direction.LEFT;
      }

      // move the ball in the correct direction
      if(ballDirection == direction.LEFT){
        setState(() {
          ballX -= 0.005;
        });
      }
      else if(ballDirection == direction.RIGHT){
        setState(() {
          ballX += 0.005;
        });
      }

      // check if ball hits the player
      if(playerDies()){
        timer.cancel();
       // _showDialog();
       gameStarted = false; // reset game state on death
      }

      // keep the time going!
      time += 0.1;

    });
   }
   
   void _showDialog(){
     showDialog(
       context: context,
       barrierDismissible: false,
       builder: ( BuildContext context) {
       return AlertDialog(shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20),
       ),
         backgroundColor: Colors.purpleAccent[600],
         title: Column(
           children: [
             Icon(Icons.sentiment_dissatisfied_outlined,
             color: Colors.redAccent,
                 size: 50,),
             SizedBox(height: 10,),
             Text(
               'GAME OVER',
               style: TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.bold,
                 letterSpacing: 2
               ),
             ),
             SizedBox(height: 10,),
             Divider(
               color: Colors.white38,
             ),
             SizedBox(height: 10,),
             Text(
                 'Your Score:$score',
             style: TextStyle(
               color: Colors.amber,
               fontSize: 20,
               fontWeight: FontWeight.w600
             ),)
           ],
         ),
         actionsAlignment: MainAxisAlignment.center,
         actions: [
          ElevatedButton.icon(onPressed: () {
            Navigator.pop(context);
            resetGame();
          },
              icon: Icon(Icons.refresh,color: Colors.white,),
              label: Text(''
         'Play Again',
              style: TextStyle(
                color: Colors.white
              ),
              ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical:12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              )
            ),
          )
         ],
       );
     },);
   }

   // movements of the player
  void moveLeft(){
    setState(() {
      // to keep the player inside the screen
     if(playerX - 0.1 < -1){
       // do nothing
     }
     else{
       playerX -= 0.1; // playerX - 0.1
     }

     // only make the X co-ordinate the same when it isn't in the middle of a shot
    if(!midShot){
      missileX = playerX;
    }
    });
  }

  void moveRight(){
    setState(() {
      // to keep the player inside the screen
      if(playerX + 0.1 > 1){
        // do nothing
      }
      else{
        playerX += 0.1; // playerX - 0.1
      }

      // only make the X co-ordinate the same when it isn't in the middle of a shot
      if(!midShot){
        missileX = playerX;
      }
    });
  }

  void fireMissile(){
    if(midShot== false){
      Timer.periodic(Duration(milliseconds: 20),(timer){

        // shot fired
        midShot = true;

        // missile grows till it hits the top of the screen
        setState(() {
          missileHeight += 10;
        });

        // stop missile whn it hits the top of the screen
        if(missileHeight > MediaQuery.of(context).size.height * 3/4){
          resetMissile();
          timer .cancel();
        }

        // check if missile has hit the ball
        if(ballY > heightToPosition(missileHeight) &&
            (ballX - missileX).abs()< 0.03){
          resetMissile();
          // ballX = 5;
          timer.cancel();

          // score tracker
          setState(() {
            score +=1;
          });

          // respawn ball from random sides
          Future.delayed(Duration(milliseconds: 800),(){
            Random rand =Random();
            bool fromLeft = rand.nextBool();

            setState(() {
              ballX = fromLeft ? -0.9 :0.9;
              ballY=1;
              ballDirection = fromLeft ? direction.RIGHT : direction.LEFT;
            });
          });


        }
      });
    }
  }

  // converts height to a coordinate
  double heightToPosition(double height){
     double totalHeight = MediaQuery.of(context).size.height * 3/4;
     double position = 1 - 2 * height/totalHeight;
     return position;
  }

  void resetMissile(){
    missileX = playerX;
    missileHeight = 10;
    midShot = false;
  }

  bool playerDies(){
     // if the ball position & the player position
    // are the same, then player dies
    if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
      setState(() {
        lives--;
      });

      if (lives <= 0) {
        gameLoopTimer?.cancel();
        _showDialog();
        gameStarted = false;
        _showDialog();
      } else {
        // Respawn the ball after a short delay
        Future.delayed(Duration(milliseconds: 500), () {
          Random rand = Random();
          bool fromLeft = rand.nextBool();

          setState(() {
            ballX = fromLeft ? -0.9 : 0.9;
            ballY = 1;
            ballDirection = fromLeft ? direction.RIGHT : direction.LEFT;
          });
        });
      }

      return true;
    }

    return false;
    // if((ballX - playerX).abs()< 0.05 && ballY > 0.95){
    //   return true;
    // }
    // else{
    //   return false;
    // }
  }

  void resetGame(){
     gameLoopTimer?.cancel();
     setState(() {
       playerX=0;
       missileX = playerX;
       missileHeight =10;
       midShot = false;

       ballX = 0.5;
       ballY = 1;
       ballDirection = direction.LEFT;

       gameStarted = false;

       score=0;
       lives= 3;
     });
  }


  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
          moveLeft();
        }
        else if(event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
          moveRight();
        }

        if(event.isKeyPressed(LogicalKeyboardKey.space)){
          fireMissile();
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 60,vertical: 20),
            color: Colors.pink[100],
            child: Column(

              children: [
                SizedBox(height: 40,),
                Text(
                  " Bubble Trouble",
                  style: TextStyle(
                    fontFamily:'PressStart' ,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.deepPurple,
                  ),
                ),

              ],
            ),
          ),

          Expanded(
              flex: 3, // to make the screen in 3:1 ratio
              child: Container(
                color: Colors.pink[100],
                // character and other elements
                child: Center(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 20,
                        child: Row(
                          children: List.generate(3, (index) {
                            return Icon(
                              Icons.favorite_rounded,
                              color: index < lives ? Colors.redAccent : Colors.grey[400],
                              size: 28,
                            );
                          }),
                        ),
                      ),
                      MyBall(
                          ballX: ballX,
                          ballY: ballY
                      ),
                      Mymissile(
                        missileX: missileX,
                        height: missileHeight,
                        missileSize: missileSize,
                      ),
                      MyPlayer(
                        playerX: playerX,
                        isFiring: midShot,
                      ),

                      // score displays
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(padding: const EdgeInsets.only(top: 10.0,left: 180.0),
                        child: Text(
                          'Score:$score',
                        style: TextStyle(
                          fontFamily: 'PressStart',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Colors.white38
                            )
                          ]
                        ),),),
                      )
                    ],
                  ),),
             )
          ) ,
          Expanded(child: Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(!gameStarted)
                  MyButton(
                    function: startGame,
                    icon: Icons.play_arrow,
                  color: Colors.orangeAccent,),
                MyButton(
                  function: moveLeft,
                  icon: Icons.arrow_back,
                color: Colors.blueAccent,),
                MyButton(
                  function: fireMissile,
                  icon: Icons.arrow_upward,
                  color: Colors.redAccent,
                ),
                MyButton(
                  function: moveRight,
                  icon: Icons.arrow_forward,
                  color: Colors.greenAccent,
                ),
              ],
            ),
          )
          )
        ],
      ),
    );
  }
}
