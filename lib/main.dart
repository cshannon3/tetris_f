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
  List<int> taken = [];
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
    paddingbottom = 100.0;
    Random random = new Random();
    currentShapePositions = shapepositions[random.nextInt(shapepositions.length-1)];
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
            currentShapePositions[rotationint].forEach((v) {
              if (!landed && taken.contains(v+currentrootposition)){
                landed = true;
                nextbox();
              }
            });

        if (!landed && currentShapePositions[rotationint][3]+currentrootposition >109){
          boxes2 = [];
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
    setState(() {
      taken.addAll(boxes2);
      List<int> checkrepeats = [];
      boxes2.forEach((val) {
        if(!checkrepeats.contains(val)) {
          filledboxesperrow[(val / 10).toInt()] += 1;
          checkrepeats.add(val);
        }
        if (filledboxesperrow[(val/10).toInt()] ==10) {
          eraserow(filledboxesperrow[(val/10).toInt()]);
          print((val/10).toInt());
        }
      });
      print(filledboxesperrow);
      currentrootposition = initrootposition;
      rotationint = 0;
    });
  }

  eraserow(int rownum){
    filledboxesperrow.removeAt(rownum+1);
    filledboxesperrow.insert(0, 0);
    List<int> newtaken = [];
    taken.forEach((i){
      if ((i/10).toInt() < rownum+1) {
        newtaken.add(i + 10);
      }else if ((i/10).toInt() > rownum+1){
        newtaken.add(i);
      }
    });
    setState(() {
      taken = newtaken;
    print(taken);
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
                       : taken.contains(index) ?
                        Colors.green :
                      Colors.grey,
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text(
                        '$index',
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





class boardTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}
