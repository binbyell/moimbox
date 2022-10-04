import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moimbox/class/ClassMeeting.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/class/ClassMeeting_Notice.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/page/MeetingPage_Home.dart';
import 'package:moimbox/tempP.dart';

class MakeNoticePage extends StatefulWidget {

  MeetingItem meetingItem;

  MakeNoticePage({Key? key, required this.meetingItem}): super(key: key);

  @override
  _makeNoticePage createState() => _makeNoticePage();
}

class _makeNoticePage extends State<MakeNoticePage> {

  String title = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    Container _line = Container(
        margin: EdgeInsets.symmetric(vertical: _device_height * 0.005),
        width: _device_width,
        height: 1,
        decoration: BoxDecoration(
            color: const Color(0xffc4c4c4)
        )
    );

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
                  Text("모임을 개설하시겠습니까?"),
                ],
              ),
              //
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "세부 내용은 언제든지 수정할 수 있습니다. 기본 모임은 최대 20명까지 모집할 수 있습니다. 모임 업그레이드로 더욱 많은 인원을 수용할 수 있습니다!",
                  ),
                ],
              ),
              actions: <Widget>[
                SizedBox(
                  width: _device_width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// 모임 개설하기
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          /// do something
                        },
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
                                "모임 개설하기",
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
                      /// 돌아가기
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          /// do something
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: 262,
                            height: 56,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50)
                                ),
                                color: Color(0xff8A8A8A)
                            ),
                            child: const Center(
                              child: Text(
                                  "돌아가기",
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
      appBar: AppBar(
        title: Text("공지 쓰기", style: appBarTitleTextStyle,),
        backgroundColor: ColorsForApp.appBarColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsForApp.black,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            child: Text(
              "완료",
              style: TextStyle(
                color: (title.isNotEmpty && content.isNotEmpty)?ColorsForApp.activeColor:ColorsForApp.inactiveColor
              ),
            ),
            onPressed: (){
              if(title.isEmpty){
                appToast("공지 제목이 비어 있습니다.");
              }
              else if(content.isEmpty){
                appToast("공지 내용이 비어 있습니다.");
              }
              else if(title.isNotEmpty && content.isNotEmpty){
                NoticeItem t = NoticeItem(
                  time: DateTime.now(),
                  onerUid: metaMyProfileItem.uid!,
                  title: title,
                  contents: content,
                );
                String meetingId = widget.meetingItem.id!;
                addMeetingNotice(t, meetingId);
                Navigator.pop(context);
              }

            },
          )
        ],
      ),

      body: Container(
          width: _device_width,
          padding: const EdgeInsets.fromLTRB(20,0,20,0),
          child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    /// 제목을 입력해주세요.
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _device_height * 0.01),
                      width: _device_width,
                      height: _device_height * 0.064,
                      child: TextField(
                        onChanged: (text){
                          title = text;
                        },
                        onSubmitted: (text){
                          title = text;
                        },
                        keyboardType: TextInputType.name,
                        maxLength: 16,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[ 0-9|ㅏ-ㅣ|ㄱ-ㅎ|가-힣|ㆍ|ᆢa-zA-Z]")),
                        ],
                        decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(horizontal: _device_width * 0.05, vertical: _device_height * 0.01),
                            border: InputBorder.none,
                            hintText: "제목을 입력해주세요.",
                            hintStyle: const TextStyle(
                                color: ColorsForApp.hintTextColor
                            )
                        ),
                      ),
                    ),
                    _line,
                    /// 모임에 대해 설명해 주세요.
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _device_height * 0.01),
                      width: 374,
                      // height: 126,
                      child: TextField(
                        onChanged: (text){
                          content = text;
                        },
                        onSubmitted: (text){
                          content = text;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: 25,
                        maxLength: 50,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: _device_width * 0.05),
                            border: InputBorder.none,
                            hintText: "내용을 입력해주세요.",
                            hintStyle: const TextStyle(
                                color: ColorsForApp.hintTextColor
                            )
                        ),
                      ),
                    ),

                  ],
                ),
              )
          )
      ),
    );
  }
}