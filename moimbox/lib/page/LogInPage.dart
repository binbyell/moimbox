import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moimbox/function/googleLogin.dart';
import 'package:moimbox/page/SignUp.dart';
import 'package:moimbox/page/_Home.dart';

import '../data/data.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPage createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(left: 30),
          child: Text("로그인", style: appBarTitleTextStyle,),
        ),
        backgroundColor: ColorsForApp.appBarColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        child: Stack(
            alignment: Alignment.center,
            children: [
              /// 카카오톡으로 로그인하기 그림자
              PositionedDirectional(
                top: _device_height * 0.363,
                child:
                Container(
                    width: _device_width * 0.85,
                    height: _device_height * 0.057,
                    decoration: const BoxDecoration(
                        color: Color(0x4debda17)
                    )
                ),
              ),
              /// 구글으로 로그인하기 그림자
              PositionedDirectional(
                top: _device_height * 0.459,
                child:Container(
                  width: _device_width * 0.85,
                  height: _device_height * 0.057,
                  decoration: const BoxDecoration(
                    color: Color(0x4dd24738),
                  ),
                ),

              ),
              /// 이거 윗쪽 싹다 블러처리
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
              /// 우리 동네 모임 한 상자,
              PositionedDirectional(
                top: _device_height * 0.11,
                child: const Text(
                    "우리 동네 모임 한 상자,",
                    style: TextStyle(
                        color:  ColorsForApp.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSansKR",
                        fontStyle:  FontStyle.normal,
                        fontSize: 14.0,
                        decoration: TextDecoration.none
                    ),
                    textAlign: TextAlign.center
                ),
              ),
              /// 모임박스
              PositionedDirectional(
                top: _device_height * 0.137,
                child:
                const Text(
                    "모임박스",
                    style: TextStyle(
                        color: ColorsForApp.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: "NotoSansKR",
                        fontStyle:  FontStyle.normal,
                        fontSize: 45.0,
                        decoration: TextDecoration.none
                    ),
                    textAlign: TextAlign.left
                ),
              ),

              /// 카카오톡으로 로그인하기
              PositionedDirectional(
                top: _device_height * 0.334,
                child:InkWell(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "준비중입니다.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: ColorsForApp.black,
                        textColor: ColorsForApp.inactiveColor,
                        fontSize: 16.0
                    );
                  },
                  child: Container(
                    width: _device_width * 0.903,
                    height: _device_height * 0.075,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)
                        ),
                        color: Color(0xffffeb00)
                    ),
                    child: const Center(
                      child: Text(
                          "카카오톡으로 로그인하기",
                          style: TextStyle(
                              color: ColorsForApp.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: "NotoSansKR",
                              fontStyle:  FontStyle.normal,
                              fontSize: 17.0,
                              decoration: TextDecoration.none
                          ),
                          textAlign: TextAlign.center
                      ),
                    ),
                  ),
                )
              ),
              /// 구글으로 로그인하기
              PositionedDirectional(
                top: _device_height * 0.431,
                child: InkWell(
                  child: Container(
                    width: _device_width * 0.903,
                    height: _device_height * 0.075,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)
                        ),
                        color: Color(0xffe24939)
                    ),
                    child: const Center(
                      child: Text(
                          "구글으로 로그인하기",
                          style: TextStyle(
                              color: ColorsForApp.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: "NotoSansKR",
                              fontStyle:  FontStyle.normal,
                              fontSize: 17.0,
                              decoration: TextDecoration.none
                          ),
                          textAlign: TextAlign.center
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>SignUp()));
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}