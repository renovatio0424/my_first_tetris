import 'package:my_first_tetris/values.dart';

class Position {
  var col;
  var row;

  Position({required this.col, required this.row});
}

extension PositionCreating on int {
  Position convertPosition() {
    int col = (this / rowLength).floor();
    int row = this % rowLength;

    return Position(col: col, row: row);
  }
}
