import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'piece.dart';
import 'package:tetris/pixel.dart';
import 'values.dart';

List<List<Tetro?>> gameBoard = List.generate(
  colLen,
  (i) => List.generate(
    rowLen,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //grid dimensions

  //game score
  int currentScore = 0;
  bool gameOver = false;

  Piece currentPiece = Piece(type: Tetro.values[Random().nextInt(Tetro.values.length)]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    Duration frame = const Duration(milliseconds: 650);
    gameLoop(frame);
  }
  //game loop
  void gameLoop(Duration frame) {
    Timer.periodic(
      frame,
      (timer) {
        setState(() {
          clearLines();
          checkLanding();


          if(gameOver == true){
            timer.cancel();
            showGameOverDial();
          }

          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }
  //game over msg
  void showGameOverDial(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text('Game Over'),
      content: Text ("Your score is $currentScore"),
      actions: [
        TextButton(onPressed: (){
          resetGame();
          Navigator.pop(context);
        },
            child: Text('Play Again'))
      ]
    ));
  }

  void resetGame(){
    gameBoard = List.generate(
      colLen,
          (i) => List.generate(
        rowLen,
            (j) => null,
      ),
    );
    gameOver = false;
    currentScore = 0;

    createNewPiece();
    startGame();
  }
  //checking collision
  bool isCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLen).floor();
      int col = currentPiece.position[i] % rowLen;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colLen || col < 0 || col >= rowLen) {
        return true;
      } else if (col == 0 && gameBoard[row][col] != null) {
        // Check for overlap with shapes in the 0th column
        return true;
      } else if (col > 0 && row > 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (isCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLen).floor();
        int col = currentPiece.position[i] % rowLen;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random random = Random();

    Tetro randomType = Tetro.values[random.nextInt(Tetro.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if(isGameOver()){
      gameOver = true;
    }
  }
  //move left control
  void moveLeft(){
    if(!isCollision(Direction.left)){
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }
  //move right control
  void moveRight(){
    if(!isCollision(Direction.right)){
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }
  //move down control
  void moveDown(){
    if(!isCollision(Direction.down)){
      setState(() {
        currentPiece.movePiece(Direction.down);
      });
    }
  }
//rotation control
  void rotatePiece(){
    setState(() {
      currentPiece.rotatePiece();
    });
  }

 //clear lines
  void clearLines() {
    int linesCleared = 0;

    for (int row = colLen - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLen; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(rowLen, (index) => null);

        // Update the positions of the falling piece
        for (int i = 0; i < currentPiece.position.length; i++) {
          currentPiece.position[i] += rowLen;
        }

        linesCleared++;
      }
    }

    if (linesCleared > 0) {
      // Update score for each cleared line
      currentScore += linesCleared * 10;
    }
  }

  //game over
  bool isGameOver(){
    for (int col = 0; col < rowLen; col++){
      if(gameBoard[0][col] != null){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column (children: [
      Expanded(
        child: GridView.builder(
            itemCount: rowLen * colLen,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowLen),
            itemBuilder: (context, index) {
              //get row and column of each index
              int row = (index / rowLen).floor();
              int col = index % rowLen;

              //current piece
              if (currentPiece.position.contains(index)) {
                return Pixel(
                  color: currentPiece.color
                );
              }

              //landed pieces
              else if (gameBoard[row][col] != null) {
                final Tetro? tetroType = gameBoard[row][col];
                return Pixel(color: tetroColor[tetroType]);
              }
              //blank pixel
              else {
                return Pixel(
                  color: Colors.grey[900],

                );
              }
            }),

      ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tetris Game by Siddhant Bisht', style: const TextStyle(color: Colors.white)),
              Text('Score : $currentScore', style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
        //game score
        //game controls
        Padding(
          padding: const EdgeInsets.only(bottom:55.0, top: 50),
          child: Column(
            children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: IconButton(onPressed:  rotatePiece, color: Colors.redAccent,icon: const Icon(Icons.rotate_right,),iconSize: 30),

            ),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: moveLeft, color: Colors.cyan,icon: const Icon(Icons.arrow_circle_left_outlined),iconSize: 38),
                IconButton(onPressed: moveDown, color: Colors.cyan,icon: const Icon(Icons.arrow_circle_down_outlined),iconSize: 38),
                IconButton(onPressed: moveRight, color: Colors.cyan,icon: const Icon(Icons.arrow_circle_right_outlined),iconSize: 38),
              ],),
          ],)
        )
      ],)
    );
  }
}
