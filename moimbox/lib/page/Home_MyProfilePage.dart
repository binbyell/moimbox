import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeeting.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/class/ClassMyProfile.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/page/Home_MyProfile_Correction.dart';
import 'package:moimbox/page/MeetingPage.dart';
import 'package:moimbox/page/SplashScreen.dart';
import 'package:moimbox/tempP.dart';
import 'package:moimbox/view/PreviewMeetingItem.dart';
import 'package:moimbox/view/PreviewMyProfile.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _myProfilePage createState() => _myProfilePage();
}

class _myProfilePage extends State<MyProfilePage> {

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPackageInfo();
  }
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    /// Dialog 버튼 있는 토스트 toast
    void FlutterDialog(BuildContext context) {
      showDialog(
          context: context,
          //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: Column(
                children: const <Widget>[
                  Text("정말 회원탈퇴 하시겠습니까?"),
                ],
              ),
              //
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "회원탈퇴 하게 된다면, 내가 가입된 모임에서 탈퇴처리 됩니다. 또한, 내가 쓴 게시글은 모두 삭제되며, 내가 개설한 모임 역시 삭제됩니다. 구독중인 프리미엄권은 자동으로 취소되지만, 환불은 되지 않습니다.",
                  ),
                ],
              ),
              actions: <Widget>[
                SizedBox(
                  width: _device_width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        /// 탈퇴 하지않기
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: 262,
                          height: 56,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50)
                              ),
                              color: Color(0xff2e2c76)
                          ),
                          child: const Center(
                            child: Text(
                                "탈퇴 하지않기",
                                style: TextStyle(
                                    color:  Color(0xffffffff),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "NotoSansKR",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 20.0
                                ),
                                textAlign: TextAlign.center
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          /// 회원탈퇴 코드
                          withdrawal().then((value){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) =>SplashScreen()));
                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: 262,
                            height: 56,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50)
                                ),
                                color: Color(0xffff0000)
                            ),
                            child: const Center(
                              child: Text(
                                  "탈퇴 하기",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansKR",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 20.0
                                  ),
                                  textAlign: TextAlign.center
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          });
    }

    return Scaffold(
      body: Container(
        width: _device_width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyProfilePreview(myProfileItem: metaMyProfileItem,),
              /// 버전 정보
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "버전 정보",
                      style: appTextStyle(14),
                    ),
                    Text(
                        _packageInfo.version,
                      style: const TextStyle(color: ColorsForApp.colorForDisabled),
                    )
                  ],
                ),
              ),
              Container(
                  width: _device_width,
                  height: 1,
                  decoration: appLineDecoration
              ),
              /// 프로필 수정
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>CorrectionProfile()));
                },
                child: Container(
                  width: _device_width,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text(
                    "프로필 수정",
                    style: appTextStyle(14),
                  ),
                ),
              ),
              Container(
                  width: _device_width,
                  height: 1,
                  decoration: appLineDecoration
              ),
              /// 공지사항 / 이벤트
              InkWell(
                onTap: (){
                  openUrl("https://moimbox.com/%ea%b3%b5%ec%a7%80%ec%82%ac%ed%95%ad/");
                },
                child: Container(
                  width: _device_width,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text(
                    "공지사항 / 이벤트",
                    style: appTextStyle(14),
                  ),
                ),
              ),
              Container(
                  width: _device_width,
                  height: 1,
                  decoration: appLineDecoration
              ),
              /// 고객센터
              InkWell(
                onTap: (){
                  openUrl("https://moimbox.com/send-mail/");
                },
                child: Container(
                  width: _device_width,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text(
                    "고객센터",
                    style: appTextStyle(14),
                  ),
                ),
              ),
              Container(
                  width: _device_width,
                  height: 1,
                  decoration: appLineDecoration
              ),
              /// 회원 탈퇴
              InkWell(
                onTap: (){
                  FlutterDialog(context);
                },
                child: Container(
                  width: _device_width,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text(
                    "회원 탈퇴",
                    style: appTextStyle(14),
                  ),
                ),
              ),
              Container(
                  width: _device_width,
                  height: 1,
                  decoration: appLineDecoration
              ),
            ],
          ),
        ),
      )
    );

  }
}