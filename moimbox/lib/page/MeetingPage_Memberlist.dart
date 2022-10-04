
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/tempP.dart';
import 'package:moimbox/view/ListItem.dart';
import 'package:moimbox/view/ProfileImageAndNickNameFromUID.dart';

class MeetingMemberListPage extends StatefulWidget {

  final MeetingItem meetingItem;
  final bool isOwner;

  MeetingMemberListPage({Key? key, required this.meetingItem, required this.isOwner}): super(key: key);

  @override
  _meetingMemberListPage createState() => _meetingMemberListPage();
}

class _meetingMemberListPage extends State<MeetingMemberListPage> {

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
        margin: EdgeInsets.only(left: _device_width * 0.058),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: _device_height * 0.022),
              child: Row(
                children: [
                  Icon(Icons.person, color: ColorsForApp.narrationText, size: 24,),
                  Text(widget.meetingItem.peopleUidList.length.toString())
                ],
              ),
            ),
            for (dynamic uid in widget.meetingItem.peopleUidList)
              widget.isOwner
                  ? InkWell(
                        onLongPress: (){
                          print("ON LONG PRESS");
                          /// DO SOMETHING
                        },
                        child: SizedBox(
                          width: _device_width,
                          height: _device_height * 0.073,
                          child: ProfileImageAndNickNameFromUID(uid: uid.toString()),
                        ),
                      )
                  : SizedBox(
                        width: _device_width,
                        height: _device_height * 0.073,
                        child: ProfileImageAndNickNameFromUID(uid: uid.toString()),
                      )
            // Text(uid.toString())
          ],
        ),
      )
    );
  }
}