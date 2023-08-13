import 'package:flutter/material.dart';
import 'package:my_first_tetris/piece.dart';
import 'package:my_first_tetris/pixel.dart';
import 'package:my_first_tetris/position.dart';
import 'package:my_first_tetris/values.dart';

import 'game_board.dart';

class TetrisGameScreen extends StatefulWidget {
  Piece currentPiece;

  TetrisGameScreen({super.key, required this.currentPiece});

  @override
  State<TetrisGameScreen> createState() => _TetrisGameScreenState();
}

class _TetrisGameScreenState extends State<TetrisGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          itemCount: rowLength * colLength,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowLength),
          itemBuilder: (context, index) {
            Position position = index.convertPosition();
            int row = position.row;
            int col = position.col;

            if (widget.currentPiece.position.contains(index)) {
              return Pixel(color: Colors.yellow, child: index);
            } else if (gameBoard[col][row] != null) {
              final Tetromino? tetrominoType = gameBoard[col][row];
              return Pixel(color: tetrominoColors[tetrominoType], child: '');
            } else {
              return Pixel(color: Colors.grey[900], child: index);
            }
          }),
    );
  }
}
