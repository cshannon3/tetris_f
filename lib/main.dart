import 'package:flutter/material.dart';
import 'model.dart';
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
  List<int> highlightedboxes;
  bool hitbottom = false;
  bool hitleft = false;
  bool hitright = false;
  bool hittop = false;
  int rootposition = 15;
  int rotationint = 0;
  List<int> boxes2 = [];


  @override
  void initState() {
    paddingtop = 100.0;
    paddingbottom = 100.0;
    highlightedboxes = [11,21,31];

    refreshboxes2(Movement.init);
  }

  refreshboxes2(Movement m) {
    switch (m) {
      case (Movement.right):
        if ((Tpositions[rotationint][1]+rootposition+1)%10 !=0 ){
          rootposition +=1;
        }
        break;
      case (Movement.left):
        if ((Tpositions[rotationint][0]+rootposition)%10 !=0 ){
          rootposition -=1;
        }
        break;
      case (Movement.up):
        if ((Tpositions[rotationint][2]+rootposition-10)>0 ){
          rootposition -=10;
        }
        break;
      case (Movement.down):
        if ((Tpositions[rotationint][3]+rootposition+10) <120 ){
          rootposition +=10;
        }
        break;
      case (Movement.rotate):
        break;
      default:
        break;
    }
    boxes2 = [];
    setState(() {
      Tpositions[rotationint].forEach((val) {
        boxes2.add(val + rootposition);
      });
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
                      color: highlightedboxes.contains(index)
                          ? Colors.green
                          : boxes2.contains(index) ?
                        Colors.red
                       : Colors.grey,
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
        Container(
          height: 70.0,
          width: double.infinity,
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  setState(() {

                    refreshboxes2(Movement.left);
                  });
                  List<int> newboxpositions = [];
                  highlightedboxes.forEach((boxval) {
                    if (hitleft || (boxval)%10 == 0 ){
                      hitleft = true;
                    } else {
                      newboxpositions.add(boxval-1);
                    }
                  });
                  if (!hitleft) {
                    setState(() {
                      hitright = false;
                      highlightedboxes = newboxpositions;
                    });
                  }
                },
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  setState(() {
                    refreshboxes2(Movement.up);
                  });
                    List<int> newboxpositions = [];
                    highlightedboxes.forEach((boxval) {
                      if (hittop || boxval - 10 < 0){
                        hittop = true;
                      } else {
                        newboxpositions.add(boxval - 10);
                      }
                    });
                    if (!hittop) {
                      setState(() {
                        hitbottom = false;
                        highlightedboxes = newboxpositions;
                      });
                    }
                },
                color: Colors.green,
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    if (Tpositions.length> rotationint+1) {
                      rotationint+=1;
                    }else{
                      rotationint = 0;
                    }
                    refreshboxes2(Movement.rotate);
                  });
                  setState(() {
                    // going from standing to laying so top and bottom should become false
                    if (highlightedboxes[1] - highlightedboxes[0]>3 ){
                      if(!hitleft && !hitright){
    highlightedboxes[0] = highlightedboxes[1] - 1;
    highlightedboxes[2] = highlightedboxes[1] + 1;
    hittop = false; hitbottom = false;
    }
                  }else if (!hittop && !hitbottom){
                    highlightedboxes[0] = highlightedboxes[1] -10;
                    highlightedboxes[2] = highlightedboxes[1]+10;
                    hitleft = false; hitright = false;
                  }
                    });

                },
                color: Colors.green,
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  setState(() {
                    refreshboxes2(Movement.down);
                  });
                  List<int> newboxpositions = [];
                  highlightedboxes.forEach((boxval) {
                    if (hitbottom || boxval + 10 > 120){
                      hitbottom = true;
                    } else {
                      newboxpositions.add(boxval + 10);
                    }
                  });
                  if (!hitbottom) {
                    setState(() {
                      hittop = false;
                      highlightedboxes = newboxpositions;
                    });
                  }
                },
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  setState(() {
                    refreshboxes2(Movement.right);
                  });
                  List<int> newboxpositions = [];
                  highlightedboxes.forEach((boxval) {
                    if (hitright || (boxval+1)%10 == 0 ){
                      hitright = true;
                    } else {
                      newboxpositions.add(boxval+1);
                    }
                  });
                  if (!hitright) {
                    setState(() {
                      hitleft = false;
                      highlightedboxes = newboxpositions;
                    });
                  }
                },

                iconSize: 40.0,
              ),
            ],
          ),
        )
      ],
   
      
    );
  }
}


enum Movement {
  left,
  right,
  up,
  down,
  rotate,
  init,
}