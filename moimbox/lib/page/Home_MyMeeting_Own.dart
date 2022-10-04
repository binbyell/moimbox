

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeeting.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/page/MeetingPage.dart';
import 'package:moimbox/view/PreviewMeetingItem.dart';

class MyOwnMeeting extends StatefulWidget {

  final Stream<QuerySnapshot> stream;
  MyOwnMeeting({Key? key, required this.stream}): super(key: key);

  @override
  _testStream createState() => _testStream();
}

class _testStream extends State<MyOwnMeeting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder(
          stream: widget.stream,
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
              return Container(
                height: 500,
                child: Center(
                  child: Text("등록한 모임이 없어요"),
                ),
              );
            }
            return ListView(
              shrinkWrap: true,
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map myOwnMeetingDoc = document.data() as Map;

                return FutureBuilder(
                  future: FirebaseFirestore.instance.collection("Meeting").doc(myOwnMeetingDoc['ID']).get(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                      if (snapshot.hasData == false) {
                        return CircularProgressIndicator();
                      }
                      //error가 발생하게 될 경우 반환하게 되는 부분
                      else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }
                      // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                      else {
                        print("snapshot.data : ${snapshot.data['PEOPLE_UID_LIST']}");
                        MeetingItem previewItem = getMeetingItemFromSnapShot(snapshot);
                        return MeetingItemPreview(
                          testParameter: previewItem,
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => MeetingPage(meetingState: previewItem.getMeetingState(), meetingItem: previewItem,))
                            );
                          },
                        );
                      }
                    }
                );
                //   Container(
                //   height: 100,
                //   width: 400,
                //   child: Column(
                //     children: [
                //       Text("temp['COL03']"),
                //       Text("temp['COL04']"),
                //     ],
                //   ),
                // );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
