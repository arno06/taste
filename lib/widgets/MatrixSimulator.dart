import 'package:flutter/material.dart';

class MatrixSimulator extends StatefulWidget{

  @override
  State createState() {
    return new MatrixSimulatorState();
  }
}

class MatrixSimulatorState extends State<MatrixSimulator>{

  List<Widget> ledMatrix;

  List<int> valueMatrix;

  int rows = 32;

  MatrixSimulatorState(){
    this.valueMatrix = <int>[];
    for(int i = 0; i<this.rows;i++){
      this.valueMatrix.add(0);
    }
  }

  void matrixLedStateChanged(int rowIndex, int value, bool active){
    int v = this.valueMatrix.elementAt(rowIndex);
    if(active){
      v += value;
    }else{
      v -= value;
    }
    setState(() {
      this.valueMatrix[rowIndex] = v;
    });
  }

  @override
  Widget build(BuildContext context) {

    this.ledMatrix = <Widget>[];
    List<int> values = <int>[1,2,4,8,16,32,64,128];

    for(int k = 0; k<values.length;k++){
      ledMatrix.add(new Text(values.elementAt(k).toString()));
    }
    ledMatrix.add(new Text(""));

    for(int j = 0; j<this.rows;j++){
      Widget widget;
      for (int i = 0; i<9; i++){
        if(i==8){
          widget = new Text(this.valueMatrix.elementAt(j).toString());
        }
        else{
          widget = new MatrixLed(onStateChanged: this.matrixLedStateChanged, ledValue: values[i], rowIndex: j, active:this.valueMatrix[j]&values[i]==values[i]);
        }
        this.ledMatrix.add(widget);
      }
    }

    return new Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: new Container(
        padding: const EdgeInsets.only(left:5.0, right:5.0, top:30.0),
        child: new CustomScrollView(
          primary: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverGrid.count(
                crossAxisSpacing: 0.0,
                crossAxisCount: 9,
                children: this.ledMatrix,
              ),
            ),
          ],
        ),
      )
    );
  }
}

class MatrixLed extends StatefulWidget{

  MatrixLed({this.onStateChanged, this.rowIndex, this.ledValue, this.active});

  void Function(int row, int value, bool active) onStateChanged;
  int rowIndex;
  int ledValue;
  bool active;

  @override
  State createState() {
    return new MatrixLedState(this.onStateChanged, this.rowIndex, this.ledValue, this.active);
  }
}

class MatrixLedState extends State<MatrixLed>{

  MatrixLedState(this.onStateChanged, this.rowIndex, this.ledValue, this.active);

  void Function(int row, int value, bool active) onStateChanged;
  int rowIndex;
  int ledValue;

  bool active = false;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        setState(() {
          this.active = !this.active;
          this.onStateChanged(this.rowIndex, this.ledValue, this.active);
        });
      },
      child: new Container(
        color: new Color(this.active?0xFFFF0000:0xFFFFFFFF),
      ),
    );
  }
}