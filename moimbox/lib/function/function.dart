
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moimbox/class/ClassMyProfile.dart';
import 'package:moimbox/data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Color getTagColor(String _tag){
  switch(_tag){
    case MeetingItemTag.fishing : return ColorsForApp.colorForFishing;
    case MeetingItemTag.golf : return ColorsForApp.colorForGolf;
    case MeetingItemTag.climbing : return ColorsForApp.colorForClimbing;
    case MeetingItemTag.billiards : return ColorsForApp.colorForBilliards;
    case MeetingItemTag.surfing : return ColorsForApp.colorForSurfing;
    case MeetingItemTag.bowling : return ColorsForApp.colorForBowling;

    default:
      return ColorsForApp.colorForFishing;
  }
}

Widget getMeetingItemTagWidget(String meetingItemTage){
  return Container(
      width: 33,
      height: 20,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(3)
          ),
          color: getTagColor(meetingItemTage)
      ),
      child: Center(
        child: Text(
            meetingItemTage,
            style: const TextStyle(
                color:  Color(0xffffffff),
                fontWeight: FontWeight.w500,
                fontFamily: "NotoSansKR",
                fontStyle:  FontStyle.normal,
                fontSize: 8.0
            ),
            textAlign: TextAlign.center
        ),
      )
  );
}

/// 이미지 갤러리에서 얻기
Future<File> getImage() async {
  PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery);
  File image = File(pickedFile!.path);
  return image;
}

/// 회원가입
void addAccount(MyProfileItem userData) async {
  print("function.addAccount");
  FirebaseFirestore.instance.collection('Account').doc(userData.uid).set({
    'UID':userData.uid,
    'NAME':userData.name,
    'PROFILE_IMAGE_URL':userData.profileImageUrl,
    'ADDRESS':userData.address,
    'NICKNAME':userData.nickname,
    'DATE_OF_BIRTH' : userData.dateOfBirth,
    'PHONE_NUMBER' : userData.phoneNumber,
    'E_MAIL' : userData.eMail,
    'INTRODUCE' : userData.introduce,
    'INTEREST': userData.interest,
    'bool' : true
  });
}

/// 프로필 이미지 넣기
Future sendImageToAccountStorage(File imageFile) async{
  String? uid = metaMyProfileItem.uid;
  uid ??= "";

  if(uid.isNotEmpty){
    Reference storageReference = FirebaseStorage.instance.ref()
        .child("Account")
        .child(uid).child("profile.jpg");
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

/// 회원 탈퇴
Future<void> withdrawal() async{
  metaMyProfileItem = MyProfileItem();
  FirebaseFirestore.instance.collection("Account").doc(metaMyProfileItem.uid).delete().then((value) {
    delImageFromAccountStorage(metaMyProfileItem.uid).then((value){
      FirebaseAuth.instance.currentUser!.delete();
    });
  });
}
/// 회원 이미지 스토리지에서 지우기
Future delImageFromAccountStorage(String? uid) async{
  if(uid != null){
    FirebaseStorage.instance.ref().child("Account").child(uid).listAll().then((value){
      for(Reference reference in value.items){
        reference.delete();
      }
    });
  }
  else{
    return false;
  }
}

/// app toast 기본 폼
void appToast(String text){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xff9F9F9F),
      textColor: ColorsForApp.white,
      fontSize: 16.0
  );
}

void openUrl(url) async {
  var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
  if(urllaunchable){
    await launch(url); //launch is from url_launcher package to launch URL
  }else{
    print("URL can't be launched.");
  }
}

/// Dialog 버튼 있는 토스트 toast
void FlutterDialogSimple({
  required BuildContext context,
  required String headText,
  required String noText,
  required String yesText,
  required GestureTapCallback onTapYes,
  required GestureTapCallback onTapNo}){

  showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          //Dialog Main Title
          title: Column(
            children: <Widget>[
              Text(headText),
            ],
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      onTapNo;
                    },
                    /// 탈퇴 하지않기
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width * 0.632,
                      height: 56,//(MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top) * 0.076,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(50)
                          ),
                          color: Color(0xff2e2c76)
                      ),
                      child: Center(
                        child: Text(
                            noText,
                            style: const TextStyle(
                                color:  Color(0xffffffff),
                                fontWeight: FontWeight.w400,
                                fontFamily: "NotoSansKR",
                                fontStyle:  FontStyle.normal,
                                fontSize: 20.0
                            ),
                            textAlign: TextAlign.center
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      onTapYes;
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: MediaQuery.of(context).size.width * 0.632,
                        height: 56,// (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top) * 0.076,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(50)
                            ),
                            color: Color(0xffff0000)
                        ),
                        child: Center(
                          child: Text(
                              yesText,
                              style: const TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSansKR",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 20.0
                              ),
                              textAlign: TextAlign.center
                          ),
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      });
}

//
// {
//   if (!await launchUrl(url)) {
//     throw 'Could not launch $url';
//   }
// }