
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/page/MeetingPage_MeetingManagement_ChangeMeeting.dart';
import 'package:moimbox/page/MeetingPage_Memberlist.dart';
import 'package:moimbox/tempP.dart';
import 'package:moimbox/view/ListItem.dart';

class MeetingManagementPage extends StatefulWidget {

  final MeetingItem meetingItem;

  MeetingManagementPage({Key? key, required this.meetingItem}): super(key: key);

  @override
  _meetingManagementPage createState() => _meetingManagementPage();
}

class _meetingManagementPage extends State<MeetingManagementPage> {

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
      body: Column(
        children: [
          makeListItem(
            context:context, text: '모임 수정하기',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => MeetingChangePage(meetingItem: widget.meetingItem))
              );},
          ),
          makeListItem(
            context:context, text: '모임 업그레이드',
            onTap: () {
              appToast("준비중입니다.");
            },
          ),
          makeListItem(
            context:context, text: '모임 멤버 리스트',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => MeetingMemberListPage(meetingItem: widget.meetingItem, isOwner: widget.meetingItem.onerUid == metaMyProfileItem.uid,))
              );},
          ),
          makeListItem(context:context, text: '모임 삭제', onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => TempPage(temporaryName: "모임 삭제"))
            );
          }, needBorder: false)
        ],
      ),
    );
  }
}