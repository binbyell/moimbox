
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeetingApply.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/page/MeetingPage_ApplyVIewPage.dart';
import 'package:moimbox/tempP.dart';
import 'package:moimbox/view/ListItem.dart';
import 'package:moimbox/view/PreviewMeetingApply.dart';
import 'package:moimbox/view/ProfileImageAndNickNameFromUID.dart';

class MeetingAppliedListPage extends StatefulWidget {

  final MeetingItem meetingItem;
  final bool isOwner;

  MeetingAppliedListPage({Key? key, required this.meetingItem, required this.isOwner}): super(key: key);

  @override
  _meetingAppliedListPage createState() => _meetingAppliedListPage();
}

class _meetingAppliedListPage extends State<MeetingAppliedListPage> {

  @override
  Widget build(BuildContext context) {

    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '모임 관리 및 설정',
            style: appBarTitleTextStyle,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ColorsForApp.black,
            ),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: ColorsForApp.appBarColor,
        ),
        body: Container(
          decoration: const BoxDecoration(color: ColorsForApp.white),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: _device_width * 0.058, vertical: _device_height * 0.022),
                child: Row(
                  children: [
                    Icon(Icons.person, color: ColorsForApp.narrationText, size: 24,),
                    Text(widget.meetingItem.peopleAppliedList.length.toString())
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemCount: widget.meetingItem.peopleAppliedList.length,
                itemBuilder: (BuildContext context, int index){
                  return MeetingApplyPreview(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>MeetingApplyViewPage(
                              meetingItem: widget.meetingItem, meetingApplyItem: getApplyItemFromMap(widget.meetingItem.peopleAppliedList[index]), index:index)
                      )
                      );
                    },
                    meetingApplyItem: getApplyItemFromMap(widget.meetingItem.peopleAppliedList[index]),
                  );
                },
              ),)
              // for (dynamic uid in widget.meetingItem.peopleAppliedList)

              //   widget.isOwner
              //       ? InkWell(
              //     onLongPress: (){
              //       print("ON LONG PRESS");
              //       /// DO SOMETHING
              //     },
              //     child: SizedBox(
              //       width: _device_width,
              //       height: _device_height * 0.073,
              //       child: ProfileImageAndNickNameFromUID(uid: uid.toString()),
              //     ),
              //   )
              //       : SizedBox(
              //     width: _device_width,
              //     height: _device_height * 0.073,
              //     child: ProfileImageAndNickNameFromUID(uid: uid.toString()),
              //   )
              // Text(uid.toString())
            ],
          ),
        )
    );
  }
}