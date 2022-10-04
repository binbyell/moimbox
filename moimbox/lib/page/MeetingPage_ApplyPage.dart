import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moimbox/class/ClassAlarm.dart';
import 'package:moimbox/class/ClassMeeting.dart';
import 'package:moimbox/class/ClassMeetingApply.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/class/ClassMeeting_Notice.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/page/MeetingPage_Home.dart';
import 'package:moimbox/tempP.dart';

class MeetingApplyPage extends StatefulWidget {

  MeetingItem meetingItem;

  MeetingApplyPage({Key? key, required this.meetingItem}): super(key: key);

  @override
  _meetingApplyPage createState() => _meetingApplyPage();
}

class _meetingApplyPage extends State<MeetingApplyPage> {

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
        title: Text(widget.meetingItem.title, style: appBarTitleTextStyle,),
        backgroundColor: ColorsForApp.appBarColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsForApp.black,
          ),
          onPressed: (){
            Navigator.of(context).pop();
            setState((){});
          },
        ),
        actions: [
          TextButton(
            child: Text(
              "신청하기",
              style: TextStyle(
                  color: (content.isNotEmpty)?ColorsForApp.activeColor:ColorsForApp.inactiveColor
              ),
            ),
            onPressed: (){
              if(content.isEmpty){
                appToast("내용이 비어 있습니다.");
              }
              else if(content.isNotEmpty){
                MeetingApplyItem meetingApplyItem = MeetingApplyItem(
                  onerUid: metaMyProfileItem.uid!,
                  onerNick: metaMyProfileItem.nickname,
                  time: DateTime.now(),
                  contents: content
                );

                setState((){
                  widget.meetingItem.peopleAppliedList = widget.meetingItem.peopleAppliedList + [meetingApplyItem.toApplyMap()];
                });
                print('widget.meetingItem.peopleAppliedList : ${widget.meetingItem.peopleAppliedList}');
                updateMeetingApply(widget.meetingItem, meetingApplyItem);

                /// alarm
                if(widget.meetingItem.onerUid != metaMyProfileItem.uid){
                  AlarmItem alarmItem = AlarmItem(
                    type: AlarmTag.apply,
                    pageType: AlarmPageTag.meeting,
                    time: DateTime.now(),
                    contents: content,
                    meetingId: widget.meetingItem.id!,
                    nick: metaMyProfileItem.nickname,
                  );
                  setAlarm(alarmItem, widget.meetingItem.onerUid);
                }

                Navigator.pop(context);
                setState((){});
              }

            },
          )
        ],
      ),

      body: Container(
          width: _device_width,
          padding: EdgeInsets.symmetric(horizontal: _device_width * 0.038),
          child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: _device_height * 0.022,),
                    /// 모임에 대해 설명해 주세요.
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _device_height * 0.01),
                      width: _device_width * 0.922,
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
                            hintText: " * 모임 가입 신청시 개인정보에 유의하시길 바랍니다.\n\n"
                                "모임에 참여하시는 여러분도 모임 사람들에 대해 잘 모르듯이, 모임에 참여하고 있는 사람들도 여러분에 대해서 잘 몰라요!\n"
                                "서로 쉽게 다가갈 수 있게 간단한 자기소개를 부탁드려요~",
                            hintStyle: const TextStyle(
                                color: ColorsForApp.hintTextColor,
                              fontSize: 15
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