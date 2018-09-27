import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris_f/controller.dart';
import 'package:tetris_f/shared.dart';
import 'model.dart';
import 'dart:math';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
      appBar: new AppBar(
    ),
    body: new MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double paddingtop;
  double paddingbottom;
  int initrootposition = 15;
  int rotationint = 0;
  List<int> boxes2 = [];
  List<List<int>> taken2 = List.generate(12, (i) => []);
  List<int> filledboxesperrow = new List<int>.generate(12, (i) => 0 );
  List<List<int>> currentShapePositions;
  int currentrootposition;
  Timer timer;
  Stopwatch stopwatch = Stopwatch();
  @override
  void initState() {
    paddingtop = 100.0;
    print(filledboxesperrow);
    List<int> r = [1,5,7,3,4,8];
    r..sort((a,b) => b.compareTo(a));
    print(r);
    paddingbottom = 100.0;
    Random random = new Random();
    currentShapePositions = shapepositions[random.nextInt(shapepositions.length)];
    currentrootposition = initrootposition;
    refreshboxes2(Movement.init);
    timer?.cancel(); // cancel old timer if it exists
    //Start new timer
    timer = Timer.periodic(Duration(seconds:  1), (Timer timer){
      setState(() {
        refreshboxes2(Movement.down);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  refreshboxes2(Movement m) {
    switch (m) {
      case (Movement.right):
        if ((currentShapePositions[rotationint][1]+currentrootposition+1)%10 !=0 ){
          currentrootposition +=1;
        }
        break;
      case (Movement.left):
        if ((currentShapePositions[rotationint][0]+currentrootposition)%10 !=0 ){
          currentrootposition -=1;
        }
        break;
      case (Movement.up):
        if ((currentShapePositions[rotationint][2]+currentrootposition-10)>0 ){
          currentrootposition -=10;
        }
        break;
      case (Movement.down):
        if ((currentShapePositions[rotationint][3]+currentrootposition+10) <120 ){
          currentrootposition +=10;
            bool landed = false;
          setState(() {
            currentShapePositions[rotationint].forEach((v) {
              if (!landed && taken2[((v + currentrootposition) / 10).floor()].contains((v + currentrootposition) % 10)) {
                print("hi 1");
                landed = true;
                nextbox();
              }
            });
          });
        if (!landed && currentShapePositions[rotationint][3]+currentrootposition >109){
          boxes2 = [];
          print("hi 2");
          setState(() {
            currentShapePositions[rotationint].forEach((val) {
              boxes2.add(val + currentrootposition);
            });
          });
          nextbox();
        }
        }
        break;
      case (Movement.rotate):
        int newrotationint = 0;
        if (currentShapePositions.length> rotationint+1) {
          newrotationint = rotationint+1;
        }
        if ((currentShapePositions[newrotationint][0]+currentrootposition+1)%10 != 0
            && (currentShapePositions[newrotationint][1]+currentrootposition)%10 !=0 ){
            setState(() {
              rotationint = newrotationint;
            });
        }
        break;
      default:
        break;
    }
    boxes2 = [];
    setState(() {
      currentShapePositions[rotationint].forEach((val) {
        boxes2.add(val + currentrootposition);
      });
    });
  }


  nextbox() {
    Random random = new Random();
    currentShapePositions = shapepositions[random.nextInt(shapepositions.length-1)];

      List<int> checkrepeats = [];
      List<int> erasetheserows = [];
      boxes2.forEach((val) {
        taken2[(val/10).floor()].add(val%10);
        if(!checkrepeats.contains(val)) {
          filledboxesperrow[(val / 10).floor()] += 1;
          checkrepeats.add(val);
          if (filledboxesperrow[(val / 10).floor()] == 10) {
            erasetheserows.add((val / 10).floor());
            print((val / 10).floor());
          }
        }
      });
    setState(() {
      if (erasetheserows.isNotEmpty) eraserows(erasetheserows);
      currentrootposition = initrootposition;
      rotationint = 0;
    });
  }

  eraserows(List<int> rownums){
    print("ROw nums");
    print(rownums);
    setState(() {
        filledboxesperrow.removeRange(rownums.first, rownums.last);
        filledboxesperrow.insertAll(0, List.generate(rownums.length, (i) =>0));
        //taken2.removeRange(rownums.first, rownums.last);
        rownums.sort((a,b) => b.compareTo(a));
        rownums.forEach((rownum) {
          taken2.removeAt(rownum);
        });
        

        taken2.insertAll(0, List.generate(rownums.length, (i) =>[]));
        print(taken2);

    });
  }
  @override
  Widget build(BuildContext context) {
    return  new Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blue,
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
              // _buildLanes(),
              GridView.count(
                  crossAxisCount: 10,
                children: List.generate(120, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: boxes2.contains(index) ?
                        Colors.red
                       : taken2[(index/10).floor()].contains(index%10) ?
                        Colors.green :
                      Colors.grey,
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text(
                        '${index}',
                      ),
                    ),
                  );
                })
              )

            ]
            ),
        ),
          ),
        ),
        Controller(move: (m) {
          setState(() {
            refreshboxes2(m);
          });
        }, ),
      ],
    );
  }
}
