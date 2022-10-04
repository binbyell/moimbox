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
import 'package:moimbox/page/MeetingPage_AppliedList.dart';
import 'package:moimbox/page/MeetingPage_Home.dart';
import 'package:moimbox/tempP.dart';

class MeetingApplyViewPage extends StatefulWidget {

  MeetingItem meetingItem;
  MeetingApplyItem meetingApplyItem;
  int index;

  MeetingApplyViewPage({Key? key, required this.meetingItem ,required this.meetingApplyItem, required this.index}): super(key: key);

  @override
  _meetingApplyViewPage createState() => _meetingApplyViewPage();
}

class _meetingApplyViewPage extends State<MeetingApplyViewPage> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    double _this_width = _device_width;
    double _this_height = _device_height * 0.119;

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
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: _this_width,
            height: _this_height,
            child: Stack(children: [
              // (본인 닉)님께서 신청한 모임에서 신청을 수락했습니다.
              PositionedDirectional(
                  top: _this_height * 0.182,
                  start: _this_width * 0.039,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w700,
                                fontFamily: "NotoSansKR",
                                fontStyle:  FontStyle.normal,
                                fontSize: 14.0
                            ),
                            text: "${widget.meetingApplyItem.onerNick}님께서\n신청한 모임에서 신청을 수락했습니다.",
                          )
                      ),
                      SizedBox(height: _this_height * 0.075,),
                      RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Color(0xff797979),
                                fontWeight: FontWeight.w400,
                                fontFamily: "NotoSansKR",
                                fontStyle:  FontStyle.normal,
                                fontSize: 12.0
                            ),
                            text: widget.meetingApplyItem.contents,
                          )
                      ),
                    ],
                  )
              ),
              PositionedDirectional(
                top: _this_height * 0.182,
                end: _this_width * 0.039,
                child: RichText(
                    maxLines: 2,
                    text: TextSpan(
                      style: const TextStyle(
                          color: Color(0xff797979),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: 12.0
                      ),
                      text: dateFormat.format(widget.meetingApplyItem.time!),
                    )
                ),
              ),
            ]),
          ),
          Container(
            width: _device_width,
            height: _device_height * 0.1,
            decoration: const BoxDecoration(
                color: ColorsForApp.white,
                border: Border(top: BorderSide(color: Color(0xffEEEEEE), width: 1))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    print("======");
                    print(widget.meetingItem.peopleAppliedList);
                    print(widget.meetingItem.peopleAppliedList.removeAt(widget.index));
                    dropMeetingApply(widget.meetingItem, widget.meetingApplyItem);
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>MeetingAppliedListPage(meetingItem: widget.meetingItem, isOwner: widget.meetingItem.onerUid == metaMyProfileItem.uid,)));

                    /// alarm
                    if(widget.meetingApplyItem.onerUid != metaMyProfileItem.uid){
                      AlarmItem alarmItem = AlarmItem(
                        type: AlarmTag.decline,
                        pageType: AlarmPageTag.meeting,
                        time: DateTime.now(),
                        contents: "${widget.meetingItem.title}\n${widget.meetingItem.intro}",
                        meetingId: widget.meetingItem.id!,
                        nick: metaMyProfileItem.nickname,
                      );
                      setAlarm(alarmItem, widget.meetingApplyItem.onerUid);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.364,
                    height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.065,
                    decoration: const BoxDecoration(
                      color: ColorsForApp.inactiveColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                    ),
                    child: const Center(
                      child: Text(
                          "거절",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w500,
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
                    print("======");
                    print(widget.meetingItem.peopleAppliedList);
                    print(widget.meetingItem.peopleAppliedList.removeAt(widget.index));
                    dropMeetingApply(widget.meetingItem, widget.meetingApplyItem);

                    widget.meetingItem.peopleUidList = widget.meetingItem.peopleUidList + [widget.meetingApplyItem.onerUid];

                    joinApply(widget.meetingItem, widget.meetingApplyItem);

                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>MeetingAppliedListPage(meetingItem: widget.meetingItem, isOwner: widget.meetingItem.onerUid == metaMyProfileItem.uid,)));

                    /// alarm
                    if(widget.meetingApplyItem.onerUid != metaMyProfileItem.uid){
                      AlarmItem alarmItem = AlarmItem(
                        type: AlarmTag.join,
                        pageType: AlarmPageTag.meeting,
                        time: DateTime.now(),
                        contents: "${widget.meetingItem.title}\n${widget.meetingItem.intro}",
                        meetingId: widget.meetingItem.id!,
                        nick: metaMyProfileItem.nickname,
                      );
                      setAlarm(alarmItem, widget.meetingApplyItem.onerUid);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.364,
                    height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.065,
                    decoration: const BoxDecoration(
                      color: ColorsForApp.meetingStateNoting,
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                    ),
                    child: const Center(
                      child: Text(
                          "수락",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w500,
                              fontFamily: "NotoSansKR",
                              fontStyle:  FontStyle.normal,
                              fontSize: 20.0
                          ),
                          textAlign: TextAlign.center
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}