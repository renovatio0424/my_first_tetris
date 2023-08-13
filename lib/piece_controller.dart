import 'dart:math';

import 'package:my_first_tetris/piece.dart';
import 'package:my_first_tetris/values.dart';

class PieceController {
  List<List<Tetromino?>> gameBoard;

  PieceController({required this.gameBoard});

  Piece createNewPiece() {
    Random random = Random();
    Tetromino randomType =
        Tetromino.values[random.nextInt(Tetromino.values.length)];

    Piece newPiece = Piece(type: randomType);
    return newPiece;
  }

  void movePiece(Direction direction, Piece piece) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < piece.position.length; i++) {
          piece.position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < piece.position.length; i++) {
          piece.position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < piece.position.length; i++) {
          piece.position[i] += 1;
        }
        break;
      default:
    }
  }

  int rotatePiece(Piece piece, int rotationState) {
    List<int> newPosition = [];
    switch (piece.type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              piece.position[1] - rowLength,
              piece.position[1],
              piece.position[1] + rowLength,
              piece.position[1] + rowLength + 1,
            ];
            break;
          case 1:
            newPosition = [
              piece.position[1] - 1,
              piece.position[1],
              piece.position[1] + 1,
              piece.position[1] + rowLength - 1
            ];
            break;
          case 2:
            newPosition = [
              piece.position[1] + rowLength,
              piece.position[1],
              piece.position[1] - rowLength,
              piece.position[1] - rowLength - 1
            ];
            break;
          case 3:
            newPosition = [
              piece.position[1] - rowLength + 1,
              piece.position[1],
              piece.position[1] + 1,
              piece.position[1] - 1
            ];
            break;
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              piece.position[1] - rowLength,
              piece.position[1],
              piece.position[1] + rowLength,
              piece.position[1] + rowLength - 1
            ];
            break;
          case 1:
            newPosition = [
              piece.position[1] - rowLength - 1,
              piece.position[1],
              piece.position[1] - 1,
              piece.position[1] + 1
            ];
            break;
          case 2:
            newPosition = [
              piece.position[1] + rowLength,
              piece.position[1],
              piece.position[1] - rowLength,
              piece.position[1] - rowLength + 1
            ];
            break;
          case 3:
            newPosition = [
              piece.position[1] + 1,
              piece.position[1],
              piece.position[1] - 1,
              piece.position[1] + rowLength + 1
            ];
            break;
        }
        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              piece.position[1] - 1,
              piece.position[1],
              piece.position[1] + 1,
              piece.position[1] + 2
            ];
            break;
          case 1:
            newPosition = [
              piece.position[1] - rowLength,
              piece.position[1],
              piece.position[1] + rowLength,
              piece.position[1] + 2 * rowLength
            ];
            break;
          case 2:
            newPosition = [
              piece.position[1] + 1,
              piece.position[1],
              piece.position[1] - 1,
              piece.position[1] - 2
            ];
            break;
          case 3:
            newPosition = [
              piece.position[1] + rowLength,
              piece.position[1],
              piece.position[1] - rowLength,
              piece.position[1] - 2 * rowLength
            ];
            break;
        }
        break;
      case Tetromino.O:
        newPosition = piece.position;
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              piece.position[1],
              piece.position[1] + 1,
              piece.position[1] + rowLength - 1,
              piece.position[1] + rowLength
            ];
            break;
          case 1:
            newPosition = [
              piece.position[0] - rowLength,
              piece.position[0],
              piece.position[0] + 1,
              piece.position[0] + rowLength + 1
            ];
            break;
          case 2:
            newPosition = [
              piece.position[1],
              piece.position[1] + 1,
              piece.position[1] + rowLength - 1,
              piece.position[1] + rowLength
            ];
            break;
          case 3:
            newPosition = [
              piece.position[0] - rowLength,
              piece.position[0],
              piece.position[0] + 1,
              piece.position[0] + rowLength + 1
            ];
            break;
        }
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              piece.position[0] + rowLength - 2,
              piece.position[1],
              piece.position[2] + rowLength - 1,
              piece.position[3] + 1
            ];
            break;
          case 1:
            newPosition = [
              piece.position[0] - rowLength + 2,
              piece.position[1],
              piece.position[2] - rowLength + 1,
              piece.position[3] - 1
            ];
            break;
          case 2:
            newPosition = [
              piece.position[0] + rowLength - 2,
              piece.position[1],
              piece.position[2] + rowLength - 1,
              piece.position[3] + 1
            ];
            break;
          case 3:
            newPosition = [
              piece.position[0] - rowLength + 2,
              piece.position[1],
              piece.position[2] - rowLength + 1,
              piece.position[3] - 1
            ];
            break;
        }
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              piece.position[2] - rowLength,
              piece.position[2],
              piece.position[2] + 1,
              piece.position[2] + rowLength
            ];
            break;
          case 1:
            newPosition = [
              piece.position[1] - 1,
              piece.position[1],
              piece.position[1] + 1,
              piece.position[1] + rowLength
            ];
            break;
          case 2:
            newPosition = [
              piece.position[1] - rowLength,
              piece.position[1] - -1,
              piece.position[1],
              piece.position[1] + rowLength
            ];
            break;
          case 3:
            newPosition = [
              piece.position[2] - rowLength,
              piece.position[2] - 1,
              piece.position[2],
              piece.position[2] + 1
            ];
            break;
        }
        break;
      default:
    }
    if (_isValidPiecePosition(newPosition)) {
      piece.position = newPosition;
      rotationState = (rotationState + 1) % 4;
    }
    return rotationState;
  }

  bool _isValidPiecePosition(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!_isValidPosition(pos)) {
        return false;
      }

      int col = pos % rowLength;

      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    return !(firstColOccupied && lastColOccupied);
  }

  bool _isValidPosition(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }
}
