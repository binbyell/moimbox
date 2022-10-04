import 'package:flutter/material.dart';

class ViewMember extends StatefulWidget {
  @override
  _viewMember createState() => _viewMember();
}

class _viewMember extends State<ViewMember> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    return Stack(children: [
      // Ellipse 40
      PositionedDirectional(
        top: 7,
        start: 24,
        child:
        Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
                color: const Color(0xffc4c4c4)
            )
        ),
      ),
      // 프로필
      PositionedDirectional(
        top: 17,
        start: 28,
        child:
        Text(
            "프로필",
            style: const TextStyle(
                color:  const Color(0xff797979),
                fontWeight: FontWeight.w500,
                fontFamily: "NotoSansKR",
                fontStyle:  FontStyle.normal,
                fontSize: 11.0
            ),
            textAlign: TextAlign.left
        ),
      ),
      // 닉네임
      PositionedDirectional(
        top: 17,
        start: 87,
        child:
        Text(
            "닉네임",
            style: const TextStyle(
                color:  const Color(0xff797979),
                fontWeight: FontWeight.w500,
                fontFamily: "NotoSansKR",
                fontStyle:  FontStyle.normal,
                fontSize: 14.0
            ),
            textAlign: TextAlign.left
        ),
      ),
      // Rectangle 1950
      PositionedDirectional(
        top: 0,
        start: 0,
        child:
        Container(
            width: 414,
            height: 54,
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0x00f4f4f4),
                    width: 1
                ),
                color: const Color(0x00ffffff)
            )
        ),
      )
    ]);
  }
}