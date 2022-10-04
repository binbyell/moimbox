

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/class/ClassMeeting_Post.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/page/MeetingPage_PostPage.dart';
import 'package:moimbox/view/PreviewPost.dart';

class MeetingPage_Gallery extends StatefulWidget {

  MeetingItem meetingItem;

  MeetingPage_Gallery({Key? key, required this.meetingItem}): super(key: key);

  @override
  _postList createState() => _postList();
}

class _postList extends State<MeetingPage_Gallery> {

  @override
  Widget build(BuildContext context) {

    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(_device_width * 0.038),
        child: FutureBuilder(
          future: FirebaseStorage.instance.ref().child("Meeting").child(widget.meetingItem.id!).child('Post').listAll(),
          builder: (BuildContext context, AsyncSnapshot<ListResult> snapshot){
            //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            }
            //error가 발생하게 될 경우 반환하게 되는 부분
            else if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.all(_device_width * 0.038),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              );
            }
            // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
            else {
              if(snapshot.data!.items.isEmpty){
                return Center(
                    child: Image.asset("images/nullImage.png", fit: BoxFit.fill,)
                );
              }
              else{
                print("snapshot : ${snapshot.data!.items[0]}");
                return GridView.builder(
                    itemCount: snapshot.data!.items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                      childAspectRatio: 1 / 1, //item 의 가로 2, 세로 1 의 비율
                      mainAxisSpacing: _device_width * 0.019, //수평 Padding
                      crossAxisSpacing: _device_width * 0.019, //수직 Padding
                    ),
                    itemBuilder: (BuildContext context, int index){
                      String fullPath = snapshot.data!.items[index].fullPath;
                      return FutureBuilder(
                          future: FirebaseStorage.instance.ref(fullPath).getDownloadURL(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if (snapshot.hasData == false) {
                              return CircularProgressIndicator();
                            }
                            else if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Error: ${snapshot.error}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              );
                            }
                            else{
                              return SizedBox(
                                width: 130,
                                height: 130,
                                child: Image.network(snapshot.data, fit: BoxFit.fill,),
                              );
                            }
                          }
                      );
                    }
                );
              }
            }
          },
        ),
      ),
    );
  }
}