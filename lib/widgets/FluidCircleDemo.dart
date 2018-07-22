import 'package:flutter/material.dart';
import 'dart:math';
import 'package:taste/utils/geom.dart';
import 'package:flutter/animation.dart';

class FluidCircleDemo extends StatefulWidget{

  @override
  FluidCircleState createState()=>new FluidCircleState();
}

class FluidCircleState extends State<FluidCircleDemo>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green,
        child: new CustomPaint(
          painter: new FluidCirclePainter(),
        )
      ),
    );
  }
}


class FluidCirclePainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    var center = new Offset(size.width/2, size.height/2);
    var p = new Paint();
    p.color = Colors.white;
    p.style = PaintingStyle.stroke;
    p.strokeWidth = 1.0;
    var r = min(size.width/2, size.height/2);
    r = r - 30.0;
    canvas.drawCircle(center, r, p);

    var linePaint = new Paint();
    p.color = Colors.grey;
    p.style = PaintingStyle.stroke;
    p.strokeWidth = 1.0;

    var pp = new Paint();
    p.color = Colors.pink;
    var waves = 8.0;
    var distance = 360.0 / waves;
    var angle = 0.0;
    var previousPoint;
    var firstPoint;
    var point;
    r += 15.0;
    for(var i = 0; i<waves; i++){
      double rad = Geom.toRadian(angle);
      point = new Offset(center.dx + (cos(rad) * r), center.dy+(sin(rad) * r));

      canvas.drawCircle(point, 2.0, pp);
      if(previousPoint != null){
        canvas.drawLine(previousPoint, point, linePaint);
      }

      angle = angle + distance;
      previousPoint = point;
      if(firstPoint == null)
        firstPoint = point;
    }

    canvas.drawLine(point, firstPoint, linePaint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }


}