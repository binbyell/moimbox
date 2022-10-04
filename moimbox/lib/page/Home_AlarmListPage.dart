
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassAlarm.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/page/MeetingPage.dart';
import 'package:moimbox/view/PreviewAlarm.dart';

class AlarmListPage extends StatefulWidget {
  @override
  _alarmListPage createState() => _alarmListPage();
}

class _alarmListPage extends State<AlarmListPage> {

  AlarmItem previewItem = AlarmItem(
      type: AlarmTag.comment,
      pageType: AlarmPageTag.post,
      time: DateTime.now(),
    meetingId: '1qa9zs1as4LrnLADt2yd',
    postId: 'kZOPdNIEdduSqQySca72',
    noticeId: 'cNWdeGY7FNdNQM9v168m',
  );

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: _device_width,
        height: _device_height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Account").doc(metaMyProfileItem.uid).collection("Alarm").orderBy("DATE", descending: true).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              /// fj
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              if(snapshot.data == null){
                return Text("Loading");
              }
              if(snapshot.data!.size == 0){
                return const SizedBox(
                  height: 500,
                  child: Center(
                    child: Text(""),
                  ),
                );
              }
              return ListView(
                shrinkWrap: true,
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map myAlarmDoc = document.data() as Map;
                  print("myAlarmDoc $myAlarmDoc");
                  AlarmItem alarmItem = getAlarmItemFromMyAlarmDoc(myAlarmDoc);
                  return AlarmPreview(alarmItem: alarmItem);
                }).toList(),
              );
            },
          ),
        )
        // SingleChildScrollView(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       AlarmPreview(
        //         alarmItem: previewItem,
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}