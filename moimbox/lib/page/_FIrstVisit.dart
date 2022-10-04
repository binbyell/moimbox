import 'package:flutter/material.dart';
import 'package:moimbox/page/SplashScreen.dart';
import 'package:moimbox/tempP.dart';

import '../data/data.dart';

class FirstVisit extends StatefulWidget {
  @override
  _firstVisit createState() => _firstVisit();
}

class _firstVisit extends State<FirstVisit> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    return SplashScreen();
  }
}