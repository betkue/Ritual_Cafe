import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(

  fillColor: Colors.white12,
  filled: true,
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
    colors: [Colors.white12, Colors.black],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1],
    tileMode: TileMode.clamp
);

/*var gard = new LinearGradient(
    colors: [Colors.white12, Colors.black],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp
);*/