import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loadding extends StatefulWidget {
  const Loadding({ Key key }) : super(key: key);

  @override
  _LoaddingState createState() => _LoaddingState();
}

class _LoaddingState extends State<Loadding> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      child: const Center(
          child:SpinKitHourGlass(
            color: Colors.green,
            size: 50.0,
          )
      ),
    );
  }
}