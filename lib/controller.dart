import 'package:flutter/material.dart';
import 'package:tetris_f/shared.dart';

class Controller extends StatelessWidget {

  final Function(Movement) move;

  Controller({
    this.move
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 70.0,
      width: double.infinity,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              move(Movement.left);
            },
            iconSize: 40.0,
          ),
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () {
              move(Movement.up);

            },
            color: Colors.green,
            iconSize: 40.0,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              move(Movement.rotate);
            },
            color: Colors.green,
            iconSize: 40.0,
          ),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () {move(Movement.down);
            },
            iconSize: 40.0,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              move(Movement.right);
            },
            iconSize: 40.0,
          ),
        ],
      ),
    );
  }
}
