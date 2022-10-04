
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/class/ClassMeeting_Notice.dart';
import 'package:moimbox/class/ClassMeeting_Post.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/page/MeetingPage.dart';
import 'package:moimbox/page/MeetingPage_NoticePage.dart';
import 'package:moimbox/page/MeetingPage_PostPage.dart';

class AlarmItem{
  String? id;
  final String type;
  final String pageType;
  final DateTime time;
  final String nick;
  String contents;
  final String meetingId;
  final String postId;
  final String noticeId;

  AlarmItem({
    this.id = "",
    required this.type,
    required this.pageType,
    required this.time,
    this.nick = 'nick',
    this.contents = "content",
    this.meetingId = '',
    this.postId = '',
    this.noticeId = '',
  });

  String getTitle(){
    switch(type){
      case AlarmTag.comment:
        return "$nick님께서\n회원님의 게시글에 답글을 남겼습니다.";
      case AlarmTag.like:
        return "$nick님께서\n회원님의 게시글에 좋아요를 눌렀습니다.";
      case AlarmTag.apply:
        return "$nick님께서\n모임 가입을 신청했습니다.";
      case AlarmTag.join:
        return "$nick님께서\n신청한 모임에서 신청을 수락했습니다.";
      case AlarmTag.decline:
        return "$nick님께서\n신청한 모임에서 신청을 거절했습니다.";
      default: return "title";
    }
  }

  void openMeetingPage(BuildContext context){
    FirebaseFirestore.instance.collection("Meeting").doc(meetingId).get().then((value){
      Map temp = value.data() as Map;
      print('getMeetingItem $temp');
      print('getMeetingItem ${temp['TITLE_IMAGE']}');
      MeetingItem meetingItem = MeetingItem(
        id: temp["ID"],
        onerUid: temp["ONER_UID"],
        peopleUidList: temp["PEOPLE_UID_LIST"],
        peopleAppliedList: temp["PEOPLE_APPLIED"],
        title: temp["TITLE"],
        titleImageUrl: temp["TITLE_IMAGE"],
        meetingTag: temp["MEETING_TAG"],
        imageUrlList: temp["IMAGE_URL_LIST"],
        location: temp["LOCATION"],
        frequency: temp["FREQUENCY"],
        billFrequency: temp["BILL_FREQUENCY"],
        price: temp["PRICE"],
        intro: temp["INTRO"],
      );
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => MeetingPage(meetingItem: meetingItem, meetingState: meetingItem.getMeetingState(),))
      );
      _deleteFromNoticeList();
    });
  }

  void openPostPage(BuildContext context){
    FirebaseFirestore.instance.collection("Meeting").doc(meetingId).get().then((value){
      Map meetingMap = value.data() as Map;
      MeetingItem meetingItem = MeetingItem(
        id: meetingMap["ID"],
        onerUid: meetingMap["ONER_UID"],
        peopleUidList: meetingMap["PEOPLE_UID_LIST"],
        peopleAppliedList: meetingMap["PEOPLE_APPLIED"],
        title: meetingMap["TITLE"],
        titleImageUrl: meetingMap["TITLE_IMAGE"],
        meetingTag: meetingMap["MEETING_TAG"],
        imageUrlList: meetingMap["IMAGE_URL_LIST"],
        location: meetingMap["LOCATION"],
        frequency: meetingMap["FREQUENCY"],
        billFrequency: meetingMap["BILL_FREQUENCY"],
        price: meetingMap["PRICE"],
        intro: meetingMap["INTRO"],
      );
      FirebaseFirestore.instance.collection('Meeting').doc(meetingId).collection('Post').doc(postId).get().then((value){
        Map postMap = value.data() as Map;
        PostItem postItem = PostItem(
          time: DateTime.parse(postMap["DATE"].toDate().toString()),
          id: postMap["ID"],
          onerUid: postMap["ONER_UID"],
          onerNick: postMap["ONER_NICK"],
          title: postMap["TITLE"],
          contents: postMap["CONTENTS"],
          imageUrlList : postMap["IMAGE_URL_LIST"],
          thumbsUpList: postMap["THUMBS_UP_LIST"],
          commentList: postMap["COMMENT_LIST"],
        );
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => MeetingPage(meetingItem: meetingItem, meetingState: meetingItem.getMeetingState(),))
        );
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => PostPage(postItem: postItem, meetingId: meetingItem.id!,))
        );
        _deleteFromNoticeList();
      });
    });
  }

  void openNoticePage(BuildContext context){
    FirebaseFirestore.instance.collection("Meeting").doc(meetingId).get().then((value){
      Map meetingMap = value.data() as Map;
      MeetingItem meetingItem = MeetingItem(
        id: meetingMap["ID"],
        onerUid: meetingMap["ONER_UID"],
        peopleUidList: meetingMap["PEOPLE_UID_LIST"],
        peopleAppliedList: meetingMap["PEOPLE_APPLIED"],
        title: meetingMap["TITLE"],
        titleImageUrl: meetingMap["TITLE_IMAGE"],
        meetingTag: meetingMap["MEETING_TAG"],
        imageUrlList: meetingMap["IMAGE_URL_LIST"],
        location: meetingMap["LOCATION"],
        frequency: meetingMap["FREQUENCY"],
        billFrequency: meetingMap["BILL_FREQUENCY"],
        price: meetingMap["PRICE"],
        intro: meetingMap["INTRO"],
      );
      FirebaseFirestore.instance.collection('Meeting').doc(meetingId).collection('Notice').doc(noticeId).get().then((value){
        Map noticeMap = value.data() as Map;
        NoticeItem noticeItem = NoticeItem(
          time: DateTime.parse(noticeMap["DATE"].toDate().toString()),
          id: noticeMap["ID"],
          onerUid: noticeMap["ONER_UID"],
          title: noticeMap["TITLE"],
          contents: noticeMap["CONTENTS"],
          thumbsUpList: noticeMap["THUMBS_UP_LIST"],
          commentList: noticeMap['COMMENT_LIST'],
        );
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => MeetingPage(meetingItem: meetingItem, meetingState: meetingItem.getMeetingState(),))
        );
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => NoticePage(noticeItem: noticeItem, meetingId: meetingItem.id!,))
        );
        _deleteFromNoticeList();
      });
    });
  }

  void _deleteFromNoticeList(){
    FirebaseFirestore.instance.collection("Account").doc(metaMyProfileItem.uid).collection('Alarm').doc(id).delete();
  }
}

class AlarmTag {
  AlarmTag._();
  // 댓글
  static const String comment = "comment";
  // 좋아요
  static const String like = "like";
  // 가입 신청
  static const String apply = "apply";
  // 신청 수락
  static const String join = 'join';
  // 신청 거절
  static const String decline = 'decline';
}

class AlarmPageTag {
  AlarmPageTag._();
  // 모임
  static const String meeting = "meeting";
  // 개시글
  static const String post = "post";
  // 공지
  static const String notice = "notice";
}