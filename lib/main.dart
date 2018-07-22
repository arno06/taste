import
'package:flutter/material.dart';
import 'widgets/FluidCircleDemo.dart';
import 'widgets/MatrixSimulator.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MatrixSimulator()
    );
  }
}