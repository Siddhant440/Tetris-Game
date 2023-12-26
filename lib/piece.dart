import 'package:flutter/services.dart';
import 'package:tetris/board.dart';
import 'values.dart';

class Piece {
  Tetro type;

  Piece({required this.type});

  List <int> position = [];

  //color of piece
  Color get color {
    return tetroColor[type] ?? const Color(0xFFFFFFFF);
  }

  void initializePiece() {
    switch (type) {
      case Tetro.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetro.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetro.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetro.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetro.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      case Tetro.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetro.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position [i] += rowLen;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position [i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position [i] += 1;
        }
        break;
      default:
    }
  }

  //rotation of pieces
  int rotationState = 1;

  void rotatePiece() {
    List<int> newPosition = [];

    //rotation of pieces
    switch (type){
      case Tetro.L:
        switch (rotationState){
          case 0:
            newPosition = [
              position[1] - rowLen,
              position[1],
              position[1] + rowLen,
              position[1] + rowLen + 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)){
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
              break;

          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLen - 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLen,
              position[1],
              position[1] - rowLen,
              position[1] - rowLen - 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] - rowLen + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetro.J:
        switch (rotationState){
          case 0:
            newPosition = [
              position[1] - rowLen,
              position[1],
              position[1] + rowLen,
              position[1] + rowLen - 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)){
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - rowLen - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLen,
              position[1],
              position[1] - rowLen,
              position[1] - rowLen + 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLen + 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetro.O:
       // O has no rotation
        break;

      case Tetro.Z:
        switch (rotationState){
          case 0:
            newPosition = [
              position[0] + rowLen - 2,
              position[1],
              position[2] + rowLen - 1,
              position[3] + 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)){
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[0] - rowLen + 2,
              position[1],
              position[2] - rowLen + 1,
              position[3] - 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[0] + rowLen - 2,
              position[1],
              position[2] + rowLen - 1,
              position[3] + 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[0] - rowLen + 2,
              position[1],
              position[2] - rowLen + 1,
              position[3] - 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetro.I:
        switch (rotationState){
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)){
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - rowLen,
              position[1],
              position[1] + rowLen,
              position[1] + 2 * rowLen,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] + rowLen,
              position[1],
              position[1] - rowLen,
              position[1] - 2 * rowLen,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetro.S:
        switch (rotationState){
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLen - 1,
              position[1] + rowLen,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)){
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[0] - rowLen,
              position[0],
              position[0] + 1,
              position[0] + rowLen + 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLen - 1,
              position[1] + rowLen,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[0] - rowLen,
              position[0],
              position[0] + 1,
              position[0] + rowLen + 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetro.T:
        switch (rotationState){
          case 0:
            newPosition = [
              position[2] - rowLen,
              position[2],
              position[2] + 1,
              position[2] + rowLen,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)){
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLen,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] - rowLen,
              position[1] - 1,
              position[1],
              position[1] + rowLen,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[2] - rowLen,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            //checks the position is a valid move
            if(piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update rotation
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        default:
    }
  }

  //check valid position
bool positionIsValid(int position){
    int row = (position / rowLen).floor();
    int col = (position % rowLen);

    if (row < 0 || col < 0 || gameBoard[row][col] != null){
      return false;
    }

    else{
      return true;
    }
}
  //piece position
    bool piecePositionIsValid(List<int>piecePosition){
        bool firstColOccupied = false;
        bool lastColOccupied = false;

        for(int pos in piecePosition){
          if (!positionIsValid(pos)){
            return false;
          }
          //get the col of position
          int col = pos % rowLen;
          //check if the 1st or last col is occupied
          if (col==0){
            firstColOccupied = true;
          }
          if (col == rowLen - 1){
            lastColOccupied = true;
          }
        }
        return !(firstColOccupied && lastColOccupied);
    }
}