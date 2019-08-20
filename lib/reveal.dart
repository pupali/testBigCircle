import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RevealCircle extends StatefulWidget {

  bool show = true;

  RevealCircle(this.show);


  _RevealCircleState createState() => _RevealCircleState();
}

class _RevealCircleState extends State<RevealCircle> with TickerProviderStateMixin {
  var screenHeight;
  var screenWidth;
  Animation animationTween;
  Animation reverseTween;
  double fraction;
  AnimationController controller;
  AnimationController rController;
  Animation rAnimation;


  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationTween = Tween<double>(begin: 0, end: 1).animate(controller)..addListener((){
      setState(() {
         fraction = animationTween.value;
      });
    });

    rController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    rAnimation = Tween<double>(end: 0, begin: 1).animate(rController)..addListener(() {
      setState(() {
       fraction =  rAnimation.value;
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.show){
      controller.forward();
    }else{
      controller.reverse();
    }
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Center(
          child: Stack(
        children: <Widget>[
          ClipRect(
            child: CustomPaint(
              size: MediaQuery.of(context).size,
              painter: BigCirclePainter(fraction),
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
  double fraction;
  
  BigCirclePainter(this.fraction);

  @override
  void paint(Canvas canvas, Size size) {
    var painter = Paint();
    painter.color = Colors.indigo;
    painter.strokeWidth = 10;
    canvas.drawCircle(
        Offset(size.width / 2, size.height), size.width / 1.3 * fraction, painter);
  }

  @override
  bool shouldRepaint(BigCirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
