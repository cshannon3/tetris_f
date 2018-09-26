import 'package:flutter/material.dart';

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



  @override
  void initState() {
    paddingtop = 100.0;
    paddingbottom = 100.0;
    highlightedboxes = [11,21,31];

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
                      color: highlightedboxes.contains(index)? Colors.green: Colors.grey,
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
                  List<int> newboxpositions = [];
                  highlightedboxes.forEach((boxval) {
                    if (hitleft || (boxval-1)%10 == 0 ){
                      hitleft = true;
                    } else {
                      newboxpositions.add(boxval-1);
                    }
                  });
                  if (!hitleft) {
                    setState(() {
                      highlightedboxes = newboxpositions;
                    });
                  }
                },
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
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

                    if (highlightedboxes[1] -highlightedboxes[0]>1 ){
                    highlightedboxes[0] = highlightedboxes[1] -1;
                    highlightedboxes[2] = highlightedboxes[1]+1;
                  }else{
                    highlightedboxes[0] = highlightedboxes[1] -10;
                    highlightedboxes[2] = highlightedboxes[1]+10;
                  }
                    });

                },
                color: Colors.green,
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
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
                      highlightedboxes = newboxpositions;
                    });
                  }
                },
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
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
