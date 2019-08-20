import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RevealCircle extends StatefulWidget {
  RevealCircle({Key key}) : super(key: key);

  _RevealCircleState createState() => _RevealCircleState();
}

class _RevealCircleState extends State<RevealCircle> {
  var screenHeight;
  var screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Center(
          child: Stack(
        children: <Widget>[
          ClipRect(
            child: CustomPaint(
              size: MediaQuery.of(context).size,
              painter: BigCirclePainter(),
            ),
          ),
          Positioned(
              top: screenHeight / 2,
              child: Container(
                height: screenHeight / 2,
                width: screenWidth,
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Center(child: Text("first")),
                    Theme(
                      data: Theme.of(context).copyWith(canvasColor: Colors.indigo),
                      child :DropdownButton(
                      value: 1,
                      onChanged: (newValue){
                        print(newValue);
                      },
                      items: [
                        DropdownMenuItem(
                          value: 1,
                          child: Text("first" ,style: TextStyle(color: Colors.white),),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text("second",style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),),
                  ],
                )),
              )),
        ],
      )),
    );
  }
}

//RaisedButton(
//   child: Text("Test"),
//   color: Colors.amber,
//   onPressed: () => {print("Hello World!!")},
// ),

class BigCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var painter = Paint();
    painter.color = Colors.indigo;
    painter.strokeWidth = 10;
    canvas.drawCircle(
        Offset(size.width / 2, size.height), size.width / 1.3, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
