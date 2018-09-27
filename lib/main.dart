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
  int rootposition = 15;
  int rotationint = 0;
  List<int> boxes2 = [];

  @override
  void initState() {
    paddingtop = 100.0;
    paddingbottom = 100.0;

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
                      color: boxes2.contains(index) ?
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

                },
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  setState(() {
                    refreshboxes2(Movement.up);
                  });

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
                },
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  setState(() {
                    refreshboxes2(Movement.right);
                  });

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