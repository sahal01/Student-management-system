import 'package:flutter/material.dart';

class DecorationWidget{

  gradientDecoration(){
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF131313),
          Color(0xFF131313),
          Color(0xFF131313),
          Color(0xFF131313),






        ],
        begin: FractionalOffset(1, 1,),
        end: FractionalOffset(1.5, 0.0),
        stops: [0.0, 0.0,3,.5],
        tileMode: TileMode.mirror,
      ),
    );
  }


}