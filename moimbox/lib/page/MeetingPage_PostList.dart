
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/class/ClassMeeting_Post.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/page/MeetingPage_PostPage.dart';
import 'package:moimbox/tempP.dart';
import 'package:moimbox/view/PreviewPost.dart';

class MeetingPage_PostList extends StatefulWidget {

  MeetingItem meetingItem;

  MeetingPage_PostList({Key? key, required this.meetingItem}): super(key: key);

  @override
  _postList createState() => _postList();
}

class _postList extends State<MeetingPage_PostList> {

  @override
  Widget build(BuildContext context) {

    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Meeting").doc(widget.meetingItem.id).collection("Post").orderBy("DATE", descending: true).snapshots(),
          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
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
              return const Center(
                child: Text("등록된 글이 없어요"),
              );
            }
            return ListView(
              shrinkWrap: true,
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: _device_width * 0.039),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map myPostDoc = document.data() as Map;
                PostItem postItem = getPostItemFromNoticeDoc(myPostDoc);
                return Column(
                  children: [
                    PostPreview(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => PostPage(postItem: postItem, meetingId: widget.meetingItem.id!,)));
                      },
                      postItem: postItem,),
                    Container(height: 1,width:_device_width, color: Color(0xffEEEEEE),)
                  ],
                );
                // return NoticePreview(
                //     onTap: (){
                //       Navigator.of(context).push(
                //           MaterialPageRoute(
                //               builder: (context) => NoticePage(noticeItem: noticeItem, meetingId: widget.meetingItemPreviewItem.id!,)));
                //     },
                //     noticeItem: noticeItem
                // );
              }).toList(),
            );
          }
      ),
    );
  }
}