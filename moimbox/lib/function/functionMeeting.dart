
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moimbox/class/ClassAlarm.dart';
import 'package:moimbox/class/ClassMeetingApply.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/class/ClassMeeting_Notice.dart';
import 'package:moimbox/class/ClassMeeting_Post.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/view/PreviewMeetingItem.dart';

/// 회원가입
/// MeetingItemPreviewItem meetingItemPreviewItem
void addMyMeeting(MeetingItem meetingItem) async {
  print("functionMeeting.addMyMeeting");

  DateTime dateTimeNow = DateTime.now();
  var doc = FirebaseFirestore.instance.collection('Meeting').doc();
  doc.set({
    'DATE':dateTimeNow,
    'ID':doc.id,
    'ONER_UID':meetingItem.onerUid,
    'PEOPLE_UID_LIST':[meetingItem.onerUid],
    'PEOPLE_APPLIED':[],
    'TITLE':meetingItem.title,
    'TITLE_IMAGE':"",
    'MEETING_TAG':meetingItem.meetingTag,
    'IMAGE_URL_LIST':[],
    'LOCATION':meetingItem.location,
    'FREQUENCY':meetingItem.frequency,
    'BILL_FREQUENCY' : meetingItem.billFrequency,
    'PRICE' : meetingItem.price,
    'INTRO' : meetingItem.intro,
    'bool' : true
  });

  var accountDoc = FirebaseFirestore.instance.collection("Account").doc(metaMyProfileItem.uid);

  accountDoc.collection("MyOwnMeeting").doc(doc.id).set({
    'DATE':dateTimeNow,
    'ID':doc.id,
    'bool':true
  });

  currentMeetingDocId = doc.id;
}

void correctionMeeting(MeetingItem meetingItem) async{
  print("functionMeeting.addMyMeeting");

  var doc = FirebaseFirestore.instance.collection('Meeting').doc();
  doc.update({
    'TITLE':meetingItem.title,
    'MEETING_TAG':meetingItem.meetingTag,
    'LOCATION':meetingItem.location,
    'FREQUENCY':meetingItem.frequency,
    'BILL_FREQUENCY' : meetingItem.billFrequency,
    'PRICE' : meetingItem.price,
    'INTRO' : meetingItem.intro,
    'bool' : true
  });
}

Future sendImageToMeetingStorage(File imageFile, String meetingId) async{
  if(meetingId.isNotEmpty){
    Reference storageReference = FirebaseStorage.instance.ref()
        .child("Meeting")
        .child(meetingId).child("meetingTitleImage.jpg");
    try {
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot strageTask = await uploadTask;
      return strageTask.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print("ERROR ERROR $e");
      return false;
    }
  }
  return false;
}

void upDateMeetingTitleImageUrl(String titleImageUrl, String meetingId) async{
  var doc = FirebaseFirestore.instance.collection('Meeting').doc(meetingId);
  doc.update({
    'TITLE_IMAGE':titleImageUrl,
  });
}

MeetingItem getMeetingItemFromSnapShot(AsyncSnapshot snapshot){
  return MeetingItem(
    id: snapshot.data["ID"],
    onerUid: snapshot.data["ONER_UID"],
    peopleUidList: snapshot.data["PEOPLE_UID_LIST"],
    peopleAppliedList: snapshot.data["PEOPLE_APPLIED"],
    title: snapshot.data["TITLE"],
    titleImageUrl: snapshot.data["TITLE_IMAGE"],
    meetingTag: snapshot.data["MEETING_TAG"],
    imageUrlList: snapshot.data["IMAGE_URL_LIST"],
    location: snapshot.data["LOCATION"],
    frequency: snapshot.data["FREQUENCY"],
    billFrequency: snapshot.data["BILL_FREQUENCY"],
    price: snapshot.data["PRICE"],
    intro: snapshot.data["INTRO"],
  );
}


/// Meeting Notice
void addMeetingNotice(NoticeItem noticeItem, String MeetingID) async {
  print("functionMeeting.addMeetingNotice");

  DateTime dateTimeNow = DateTime.now();
  var doc = FirebaseFirestore.instance.collection('Meeting').doc(MeetingID).collection("Notice").doc();
  doc.set({
    'DATE':dateTimeNow,
    'ID':doc.id,
    'ONER_UID':noticeItem.onerUid,
    'TITLE':noticeItem.title,
    'CONTENTS': noticeItem.contents,
    'THUMBS_UP_LIST':noticeItem.thumbsUpList,
    'COMMENT_LIST':noticeItem.commentList,
    'bool' : true
  });

  var accountDoc = FirebaseFirestore.instance.collection("Account").doc(metaMyProfileItem.uid);

  accountDoc.collection("Post").doc(doc.id).set({
    'TYPE':"Notice",
    'DATE':dateTimeNow,
    'ID_MEETING':MeetingID,
    'ID_POST':doc.id,
    'bool':true
  });
}

void updateThumbsUp(NoticeItem noticeItem, String MeetingID){
  FirebaseFirestore.instance.collection('Meeting').doc(MeetingID).collection("Notice").doc(noticeItem.id).update({
   'THUMBS_UP_LIST' :  noticeItem.thumbsUpList
  });
}
void updateCOMMENT(NoticeItem noticeItem, String MeetingID){
  FirebaseFirestore.instance.collection('Meeting').doc(MeetingID).collection("Notice").doc(noticeItem.id).update({
    'COMMENT_LIST' :  noticeItem.commentList
  });
}

NoticeItem getNoticeItemFromNoticeDoc(Map myNoticeDoc){
  List<dynamic> beforeCommentList = myNoticeDoc["COMMENT_LIST"];
  List<dynamic> afterCommentList = [];
  for (Map a in beforeCommentList){
    a['TIME'] = DateTime.parse(a['TIME'].toDate().toString());
    afterCommentList.add(a);
  }

  return NoticeItem(
    time: DateTime.parse(myNoticeDoc["DATE"].toDate().toString()),
    id: myNoticeDoc["ID"],
    onerUid: myNoticeDoc["ONER_UID"],
    title: myNoticeDoc["TITLE"],
    contents: myNoticeDoc["CONTENTS"],
    thumbsUpList: myNoticeDoc["THUMBS_UP_LIST"],
    commentList: afterCommentList,
  );
}


/// meeting Post

/// 이미지 넣기

/// not use
Future sendImageToMeetingPostStorage(List<File> imageFileList, String meetingId, int count, List urlList) async{
  String nowString = DateFormat("yyyy.MM.dd_HH:mm").format(DateTime.now());

  if(meetingId.isNotEmpty){
    Reference storageReference = FirebaseStorage.instance.ref()
        .child("Meeting")
        .child(meetingId)
        .child("Post").child("${meetingId}_${nowString}_$count.jpg");
    try {
      UploadTask uploadTask = storageReference.putFile(imageFileList[count]);
      TaskSnapshot strageTask = await uploadTask;
      strageTask.ref.getDownloadURL().then((value){
        urlList.add(value);
        if(imageFileList.length == urlList.length){
          return urlList;
        }
        else{
          sendImageToMeetingPostStorage(imageFileList, meetingId, count+1, urlList).then((value){
            return value;
          });
        }
      });
    } on FirebaseException catch (e) {
      print("ERROR ERROR $e");
      return false;
    }
  }
  return false;
}


Future sendImageToMeetingPostStorageMk2(File imageFile, String meetingId, int count) async{
  String nowString = DateFormat("yyyy.MM.dd_HH:mm").format(DateTime.now());
  if(meetingId.isNotEmpty){
    Reference storageReference = FirebaseStorage.instance.ref()
        .child("Meeting")
        .child(meetingId)
        .child("Post").child("${meetingId}_${nowString}_$count.jpg");
    try {
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot strageTask = await uploadTask;
      return strageTask.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print("ERROR ERROR $e");
      return false;
    }
  }
  return false;
}

void addMeetingPost(PostItem postItem, String MeetingID) async {
  print("functionMeeting.addMeetingNotice");

  DateTime dateTimeNow = DateTime.now();
  var doc = FirebaseFirestore.instance.collection('Meeting').doc(MeetingID).collection("Post").doc();
  doc.set({
    'DATE':dateTimeNow,
    'ID':doc.id,
    'ONER_UID':postItem.onerUid,
    'ONER_NICK':postItem.onerNick,
    'TITLE':postItem.title,
    'CONTENTS': postItem.contents,
    'IMAGE_URL_LIST':postItem.imageUrlList,
    'THUMBS_UP_LIST':postItem.thumbsUpList,
    'COMMENT_LIST':postItem.commentList,
    'bool' : true
  });

  var accountDoc = FirebaseFirestore.instance.collection("Account").doc(metaMyProfileItem.uid);

  accountDoc.collection("Post").doc(doc.id).set({
    'TYPE':"Post",
    'DATE':dateTimeNow,
    'ID_MEETING':MeetingID,
    'ID_POST':doc.id,
    'bool':true
  });
}

PostItem getPostItemFromNoticeDoc(Map myPostDoc){
  List<dynamic> beforeCommentList = myPostDoc["COMMENT_LIST"];
  List<dynamic> afterCommentList = [];
  for (Map a in beforeCommentList){
    a['TIME'] = DateTime.parse(a['TIME'].toDate().toString());
    afterCommentList.add(a);
  }

  return PostItem(
    time: DateTime.parse(myPostDoc["DATE"].toDate().toString()),
    id: myPostDoc["ID"],
    onerUid: myPostDoc["ONER_UID"],
    onerNick: myPostDoc["ONER_NICK"],
    title: myPostDoc["TITLE"],
    contents: myPostDoc["CONTENTS"],
    imageUrlList : myPostDoc["IMAGE_URL_LIST"],
    thumbsUpList: myPostDoc["THUMBS_UP_LIST"],
    commentList: afterCommentList,
  );
}

void updateThumbsUpPost(PostItem noticeItem, String MeetingID){
  FirebaseFirestore.instance.collection('Meeting').doc(MeetingID).collection("Post").doc(noticeItem.id).update({
    'THUMBS_UP_LIST' :  noticeItem.thumbsUpList
  });
}
void updateCOMMENTPost(PostItem noticeItem, String MeetingID){
  FirebaseFirestore.instance.collection('Meeting').doc(MeetingID).collection("Post").doc(noticeItem.id).update({
    'COMMENT_LIST' :  noticeItem.commentList
  });
}

/// Meeting Apply
void updateMeetingApply(MeetingItem meetingItem, MeetingApplyItem meetingApplyItem){
  print("functionMeeting.updateMeetingApply");

  FirebaseFirestore.instance.collection('Meeting').doc(meetingItem.id).update({
    'PEOPLE_APPLIED' : meetingItem.peopleAppliedList
  });
  FirebaseFirestore.instance.collection('Account').doc(metaMyProfileItem.uid).collection('MyAppliedMeeting').doc(meetingItem.id).set({
    'DATE':meetingApplyItem.time,
    'ID':meetingItem.id,
    'CONTENTS':meetingApplyItem.contents,
    'bool':true
  });
}

void dropMeetingApply(MeetingItem meetingItem, MeetingApplyItem meetingApplyItem){
  print("functionMeeting.dropMeetingApply");

  FirebaseFirestore.instance.collection('Meeting').doc(meetingItem.id).update({
    'PEOPLE_APPLIED' : meetingItem.peopleAppliedList
  });
  print(meetingItem.id);
  FirebaseFirestore.instance.collection('Account').doc(metaMyProfileItem.uid).collection('MyAppliedMeeting').doc(meetingItem.id).delete();
}

void joinApply(MeetingItem meetingItem, MeetingApplyItem meetingApplyItem){
  print("functionMeeting.joinApply");

  FirebaseFirestore.instance.collection('Meeting').doc(meetingItem.id).update({
    'PEOPLE_UID_LIST' : meetingItem.peopleUidList
  });

  FirebaseFirestore.instance.collection("Account").doc(meetingApplyItem.onerUid).collection("MyJoinedMeeting").doc(meetingItem.id).set({
    'DATE':DateTime.now(),
    'ID':meetingItem.id,
    'bool':true
  });

  FirebaseFirestore.instance.collection("Account").doc(meetingApplyItem.onerUid).collection('MyAppliedMeeting').doc(meetingItem.id).delete();
}

/// Alarm
void setAlarm(AlarmItem alarmItem, String alarmOwnerUid){
  var alarmDoc = FirebaseFirestore.instance.collection("Account").doc(alarmOwnerUid).collection("Alarm").doc();
  alarmDoc.set({
    'ID': alarmDoc.id,
    'TYPE':alarmItem.type,
    'PAGE_TYPE':alarmItem.pageType,
    'DATE':alarmItem.time,
    'NICK':alarmItem.nick,
    'CONTENTS':alarmItem.contents,
    'MEETING_ID':alarmItem.meetingId,
    'POST_ID':alarmItem.postId,
    'NOTICE_ID':alarmItem.noticeId,
    'bool':true
  });
}

AlarmItem getAlarmItemFromMyAlarmDoc(Map myAlarmDoc){
  print("snapshot.datasnapshot.data : ${myAlarmDoc}");
  return AlarmItem(
    id: myAlarmDoc["ID"],
    type: myAlarmDoc["TYPE"],
    pageType: myAlarmDoc['PAGE_TYPE'],
    time: DateTime.parse(myAlarmDoc['DATE'].toDate().toString()),
    nick: myAlarmDoc['NICK'],
    contents: myAlarmDoc['CONTENTS'],
    meetingId: myAlarmDoc['MEETING_ID'],
    postId: myAlarmDoc['POST_ID'],
    noticeId: myAlarmDoc['NOTICE_ID'],
  );
}