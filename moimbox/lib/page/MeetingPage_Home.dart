
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeeting.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/class/ClassMeeting_Notice.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/page/MeetingPage_NoticePage.dart';
import 'package:moimbox/view/PreviewNotice.dart';

class MeetingPage_Home extends StatefulWidget {

  String meetingState;
  MeetingItem meetingItemPreviewItem;
  MeetingPage_Home({Key? key, required this.meetingState, required this.meetingItemPreviewItem}): super(key: key);

  @override
  _meetingHome createState() => _meetingHome();
}

class _meetingHome extends State<MeetingPage_Home> {

  File? currentFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.meetingItemPreviewItem.imageUrlList.length !=0
                    ?CarouselSlider(
                  options: CarouselOptions(height: 230.0),
                  items: widget.meetingItemPreviewItem.imageUrlList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 230,
                            margin: const EdgeInsets.all(5.0),
                            child: Image.network(i)
                        );
                      },
                    );
                  }).toList(),
                )
                    :Container(
                  margin: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.width * 9/16,
                  width: MediaQuery.of(context).size.width,
                  child: widget.meetingItemPreviewItem.titleImageUrl.isNotEmpty
                      ?Image.network(widget.meetingItemPreviewItem.titleImageUrl,fit: BoxFit.fitHeight,)
                      :ClipOval(child: Image.asset("images/nullImage.png", fit: BoxFit.fill,),),
                ),

                /// intro
                Container(
                  margin: const EdgeInsets.all( 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// tag, title
                      Row(
                        children: [
                          getMeetingItemTagWidget(widget.meetingItemPreviewItem.meetingTag),
                          SizedBox(width: 8,),
                          Text(
                              widget.meetingItemPreviewItem.title,
                              style: const TextStyle(
                                  color:  const Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "NotoSansKR",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 20.0
                              ),
                              textAlign: TextAlign.center
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 20),
                        child: Text(
                            widget.meetingItemPreviewItem.intro,
                            style: const TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "NotoSansKR",
                                fontStyle:  FontStyle.normal,
                                fontSize: 14.0
                            ),
                            textAlign: TextAlign.left
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Icon(Icons.people),
                            SizedBox(width: 8,),
                            Text(
                                widget.meetingItemPreviewItem.peopleUidList.length.toString(),
                                style: const TextStyle(
                                    color:  const Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "NotoSansKR",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                ),
                                textAlign: TextAlign.center
                            )
                          ],),
                          Row(
                            children: [
                              Text(
                                  widget.meetingItemPreviewItem.billFrequency,
                                  style: const TextStyle(
                                      color:  const Color(0xff000000),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansKR",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 10.0
                                  ),
                                  textAlign: TextAlign.right
                              ),
                              SizedBox(width: 8,),
                              Text(
                                  "${widget.meetingItemPreviewItem.price} 원",
                                  style: const TextStyle(
                                      color:  const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NotoSansKR",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 14.0
                                  ),
                                  textAlign: TextAlign.center
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                /// line
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: const Color(0xffEEEEEE),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24,),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                      "공지사항",
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.left
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Meeting").doc(widget.meetingItemPreviewItem.id).collection("Notice").orderBy("DATE", descending: true).snapshots(),
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
                          child: Text("등록된 공지사항이 없어요"),
                        );
                      }
                      return ListView(
                        shrinkWrap: true,
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map myNoticeDoc = document.data() as Map;
                          NoticeItem noticeItem = getNoticeItemFromNoticeDoc(myNoticeDoc);
                          return NoticePreview(
                              onTap: (){
                                if(widget.meetingState == MeetingStateTag.joined){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => NoticePage(noticeItem: noticeItem, meetingId: widget.meetingItemPreviewItem.id!,)));
                                }
                                else{
                                  appToast("모임 가입자만 열람 가능합니다!");
                                }
                              },
                              noticeItem: noticeItem
                          );
                        }).toList(),
                      );
                    }
                ),
              ],
            ),
          )
      ),
    );
  }
}