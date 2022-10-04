import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/function/googleLogin.dart';
import 'package:moimbox/page/LogInPage.dart';
import 'package:moimbox/page/_Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  bool isLogIn = false;

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    return Material(
      child: InkWell(
        onTap: (){
          signInWithGoogle().then((value){
            if(value.runtimeType == bool){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>Home())
              );
            }
            else{
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => LogInPage())
              );
            }
          }).catchError((onError){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => LogInPage())
            );
          });
        },
        child:  Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/splash_screen.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            /// 우리 동네 모임 한 상자,
            Container(
              margin: EdgeInsets.only(top: _device_height * 0.23,),
              child: const Text(
                  "우리 동네 모임 한 상자,",
                  style: TextStyle(
                      color:  Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                      fontFamily: "NotoSansKR",
                      fontStyle:  FontStyle.normal,
                      fontSize: 14.0,
                      decoration: TextDecoration.none
                  ),
                  textAlign: TextAlign.center
              ),
            ),
            /// 모임박스
            Container(
              margin: const EdgeInsets.only(top: 7),
              child: const Text(
                  "모임박스",
                  style: TextStyle(
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                      fontFamily: "NotoSansKR",
                      fontStyle:  FontStyle.normal,
                      fontSize: 65.0,
                      decoration: TextDecoration.none
                  ),
                  textAlign: TextAlign.center
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: _device_height * 0.5,
                bottom: _device_height * 0.04
              ),
              width: _device_width * 0.84,
              child: const Text(
                  "모임 즐기러 가기!",
                  style: TextStyle(
                      color:  Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                      fontFamily: "NotoSansKR",
                      fontStyle:  FontStyle.normal,
                      fontSize: 14.0,
                      decoration: TextDecoration.none
                  ),
                  textAlign: TextAlign.left
              ),
            ),
            // 하단 선
            Container(
                width: _device_width * 0.84,
                height: 5,
                decoration: const BoxDecoration(
                    color: Color(0xffffffff)
                )
            )
          ]),
        ),
      ),
    );
  }
}