import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_first_tetris/piece.dart';
import 'package:my_first_tetris/piece_controller.dart';
import 'package:my_first_tetris/pixel.dart';
import 'package:my_first_tetris/position.dart';
import 'package:my_first_tetris/values.dart';

List<List<Tetromino?>> gameBoard =
    List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class TetrisGameBoard extends StatefulWidget {
  const TetrisGameBoard({super.key});

  @override
  State<TetrisGameBoard> createState() => _TetrisGameBoardState();
}

class _TetrisGameBoardState extends State<TetrisGameBoard> {
  int currentScore = 0;
  int rotationState = 1;
  late PieceController pieceController = PieceController(gameBoard: gameBoard);
  Piece currentPiece = Piece(type: Tetromino.T);

  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame() {
    gameBoard =
        List.generate(colLength, (i) => List.generate(rowLength, (j) => null));
    currentScore = 0;
    rotationState = 1;
    pieceController = PieceController(gameBoard: gameBoard);
    currentPiece = pieceController.createNewPiece();

    Duration frameRate = const Duration(milliseconds: gameSpeedMs);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        if (isGameOver()) {
          timer.cancel();
          showGameOverDialog();
        }
        clearLines();
        checkLanding();
        pieceController.movePiece(Direction.down, currentPiece);
      });
    });
  }

  //check for collision in a future position
  //return true -> there is a collision
  //return false -> there is no collision
  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      Position position = currentPiece.position[i].convertPosition();
      int col = position.col;
      int row = position.row;

      if (direction == Direction.left) {
        row -= 1;
      } else if (direction == Direction.right) {
        row += 1;
      } else if (direction == Direction.down) {
        col += 1;
      }

      if (col >= colLength || row < 0 || row >= rowLength) {
        return true;
      }

      if (col >= 0 &&
          col < colLength &&
          row >= 0 &&
          row < rowLength &&
          gameBoard[col][row] != null) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        Position position = currentPiece.position[i].convertPosition();
        int col = position.col;
        int row = position.row;

        if (col >= 0 && col < colLength && row >= 0 && row < rowLength) {
          gameBoard[col][row] = currentPiece.type;
        }
      }

      rotationState = 1;
      currentPiece = pieceController.createNewPiece();
    }
  }

  void clearLines() {
    for (int col = colLength - 1; col >= 0; col--) {
      bool isFullRow = true;

      for (int row = 0; row < rowLength; row++) {
        if (gameBoard[col][row] == null) {
          isFullRow = false;
          break;
        }
      }

      if (isFullRow) {
        for (int c = col; c > 0; c--) {
          gameBoard[c] = List.from(gameBoard[c - 1]);
        }

        gameBoard[0] = List.generate(colLength, (index) => null);
        currentScore += 100;
      }
    }
  }

  bool isGameOver() {
    for (int row = 0; row < rowLength; row++) {
      if (gameBoard[0][row] != null) {
        return true;
      }
    }
    return false;
  }

  void showGameOverDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
                title: const Text('Game Over'),
                content: Text('Your score is $currentScore'),
                actions: [
                  TextButton(
                      onPressed: () {
                        startGame();
                        Navigator.pop(context);
                      },
                      child: const Text('Play Again'))
                ]));
  }

  void onPressMoveButton(Direction direction) {
    debugPrint('direction: ${direction.name}');
    debugPrint('[movePiece]isCollision?: ${checkCollision(direction)}');
    if (!checkCollision(direction)) {
      setState(() {
        pieceController.movePiece(direction, currentPiece);
      });
    }
  }

  void onPressRotateButton() {
    setState(() {
      rotationState = pieceController.rotatePiece(currentPiece, rotationState);
    });
  }

  void onDragHorizontal(DragUpdateDetails details) {
    var criticalDelta = details.delta.dx / criticalOffset;
    debugPrint("critical delta x: $criticalDelta");
    debugPrint("critical delta abs: ${criticalDelta.abs()}");

    if (criticalDelta.abs() > 0) {
      Direction direction;

      if (criticalDelta > 0) {
        direction = Direction.right;
      } else {
        direction = Direction.left;
      }

      debugPrint("direction : $direction");

      for (int i = 0; i < criticalDelta.abs(); i++) {
        onPressMoveButton(direction);
      }
    }
  }

  void onDragVertical(DragUpdateDetails details) {
    var criticalDelta = details.delta.dy / criticalOffset;
    debugPrint("critical delta y: $criticalDelta");
    debugPrint("critical delta abs: ${criticalDelta.abs()}");

    if (criticalDelta > 0) {
      Direction direction = Direction.down;

      debugPrint("direction : $direction");

      for (int i = 0; i < criticalDelta.abs(); i++) {
        onPressMoveButton(direction);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Text(
                  'Score : ${currentScore.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onPressRotateButton();
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    onDragHorizontal(details);
                  },
                  onVerticalDragUpdate: (details) {
                    onDragVertical(details);
                  },
                  child: GridView.builder(
                      itemCount: rowLength * colLength,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: rowLength),
                      itemBuilder: (context, index) {
                        Position position = index.convertPosition();
                        int row = position.row;
                        int col = position.col;

                        if (currentPiece.position.contains(index)) {
                          return Pixel(color: Colors.yellow, child: index);
                        } else if (gameBoard[col][row] != null) {
                          final Tetromino? tetrominoType = gameBoard[col][row];
                          return Pixel(
                              color: tetrominoColors[tetrominoType], child: '');
                        } else {
                          return Pixel(color: Colors.grey[900], child: index);
                        }
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
