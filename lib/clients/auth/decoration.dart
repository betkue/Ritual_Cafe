import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
var textInputDecoration = InputDecoration(

  fillColor: Color.fromRGBO(44, 51,61, 1),
  filled: true,
  hintStyle: TextStyle(
    color: Colors.blueGrey
  ),
  border: OutlineInputBorder(borderRadius:
      BorderRadius.all(Radius.circular(10.0))),
  contentPadding: EdgeInsets.all(12),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.red,width: 1),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.red,width: 1),
  ),
  focusedBorder:OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.grey,width: 1),
  ),
);


var gard = new LinearGradient(
  //colors: [ Color.fromRGBO(86, 89, 95, 0.2),Color.fromRGBO(15, 18, 25, 0.2)],
  //  colors: [ Color.fromRGBO(15, 18, 25, 1),Color.fromRGBO(44, 51,61, 0.2)],
  colors: [ Color.fromRGBO(82, 92, 113, 0.6),Color.fromRGBO(15, 18, 25, 0.2)],//Color.fromRGBO(86, 89, 95, 0.2

    begin: Alignment(-1.0, 0.0),
    end: Alignment(1.0, 0.0,),
     transform: GradientRotation(math.pi /6),
    //stops: [0, 0.5],
    //tileMode: TileMode.clamp
);

/*var gard = new LinearGradient(
  //colors: [ Color.fromRGBO(86, 89, 95, 0.2),Color.fromRGBO(15, 18, 25, 0.2)],
    colors: [ Color.fromRGBO(44, 51,61, 0.2),Color.fromRGBO(15, 18, 25, 1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 0.5],
    tileMode: TileMode.clamp
);
);*/