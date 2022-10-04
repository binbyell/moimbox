import 'package:flutter/material.dart';

class TempPage extends StatefulWidget {

  final String temporaryName;
  TempPage({Key? key, required this.temporaryName}): super(key: key);

  @override
  _tempPage createState() => _tempPage();
}

class _tempPage extends State<TempPage> {

  @override
  Widget build(BuildContext context) {

    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Text(
          widget.temporaryName.toString()
        ),
      ),
    );
  }
}