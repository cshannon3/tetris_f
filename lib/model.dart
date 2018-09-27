class TetrisShape {
  final String shapename;
  final List<List<int>> positions;

  TetrisShape({this.shapename, this.positions});
}
 // Making the 0 position farthest left, the 1 position farthest right, the 2 postion highest, 3 position lowest, and 4+ others
final linepositions = [[-10, 10, 0, 20],[-1, 2, 0, 2]];
final Tpositions = [[ -1, 1, 0, 10],[ -1, 0, -10, 10], [ -1, 1, -10, 0],[ 0, 1, -10, 10]];
final Zpositions = [[-1, -9, -10, 0],[0, 1, -10, 11]];
final Lpositions = [[-10, 1, 0, -20], [0, 2, 1,  10], [-1, 0, 10, 20],[-2, 0, -1, -10]];
final littleLpositions = [[0, 1, 0, -10],[0, 1, 0, 10],[ -1, 0, 10, 0], [ -1, 0, 0, -10]];
final squarepositions =  [[0, -9, -10, 1]];
// shape possibilities
 /*
 Line poss relative to center 1 standing [-10, 0, 10, 20]
                                  2 laying [-1, 0, 1, 2]
  Box T    one down [ -1, 0, 1, 10]
            one up [ -1, 0, 1, -10]
            -I [ -1, 0, 10, -1]
            I- [ 0, 1, 10, -10]
   zig Z  flat 1 [-1, 0, -10, -9]
          up 1 [0, -10, 1, 11]
    L    up L [0, 1, -10, -20]
        side down [0, 1, 2, 10]
        down [-1, 0, 10, 20]
        side up [-2, -1, 0, -10]

   little L  up [0, -10, 1]
            2 [0, 1, 10]
            3[ -1, 0, 10]
            4 [ -1, 0, -10]
    square  only [0, 1, -10, -9]





  */

