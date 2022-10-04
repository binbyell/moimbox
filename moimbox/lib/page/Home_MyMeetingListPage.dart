import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeeting.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/page/Home_MyMeeting_Join.dart';
import 'package:moimbox/page/Home_MyMeeting_Own.dart';
import 'package:moimbox/page/MeetingPage.dart';
import 'package:moimbox/tempP.dart';
import 'package:moimbox/view/PreviewMeetingItem.dart';

class MyMeetingListPage extends StatefulWidget {
  @override
  _myMeetingListPage createState() => _myMeetingListPage();
}

class _myMeetingListPage extends State<MyMeetingListPage> {

  int _selectedPageIndex = 0;
  double topNaviHeight = 47;

  final List<Widget> _pageList = <Widget>[
    MyJoinedMeeting(
      stream: FirebaseFirestore.instance.collection("Account").doc(metaMyProfileItem.uid).collection("MyJoinedMeeting").orderBy("DATE", descending: true).snapshots(),
    ),
    MyOwnMeeting(
      stream: FirebaseFirestore.instance.collection("Account").doc(metaMyProfileItem.uid).collection("MyOwnMeeting").orderBy("DATE", descending: true).snapshots(),
    )
  ];

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// top navi
            Container(
              width: _device_width,
              height: _device_height * 0.069,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Container(
                      width: _device_width/2,
                      child: Column(
                        children: [
                          Container(
                            height: _device_height * 0.064,
                            child: Center(child: Text("가입한 모임", style: TextStyle(color: Color(0xff000000)),textAlign: TextAlign.center ),),
                          ),
                          Container(
                            height: _device_height * 0.005,
                            child: Visibility(child: Container(width: _device_width/2,color:const Color(0xff2e2c76)),visible: _selectedPageIndex == 0,),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      setState((){
                        {
                          _selectedPageIndex = 0;
                        }
                      });
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: _device_width/2,
                      child: Column(
                        children: [
                          Container(
                              height: _device_height * 0.064,
                              child: Container(child: Center(child: Text("개설한 모임", style: TextStyle(color: Color(0xff000000)),textAlign: TextAlign.center ),),)
                          ),
                          Container(
                              height: _device_height * 0.005,
                              child: Visibility(child: Container(width: _device_width/2,color:const Color(0xff2e2c76)),visible: _selectedPageIndex == 1,)
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      setState((){
                        {
                          _selectedPageIndex = 1;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Flexible(child: Container(
              child: IndexedStack(
                index: _selectedPageIndex,
                children: _pageList,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
