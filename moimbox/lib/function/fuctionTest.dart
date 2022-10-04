

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moimbox/class/ClassMyProfile.dart';

/// test to add collection in doc
void addCollection(MyProfileItem userData) async {
  print("function.addCollection");
  // var temp = FirebaseFirestore.instance.collection('Account').doc(userData.uid).collection("Test").doc();
  // temp.set({
  //   'ID':temp.id,
  //   'UID':userData.uid,
  //   'NAME':userData.name,
  //   'PROFILE_IMAGE_URL':userData.profileImageUrl,
  //   'ADDRESS':userData.address,
  //   'NICKNAME':userData.nickname,
  //   'DATE_OF_BIRTH' : userData.dateOfBirth,
  //   'PHONE_NUMBER' : userData.phoneNumber,
  //   'E_MAIL' : userData.eMail,
  //   'INTRODUCE' : userData.introduce,
  //   'INTEREST': userData.interest,
  //   'bool' : true
  // });
  var temp = FirebaseFirestore.instance.collection('Account').doc(userData.uid).collection("Test").get().then((value){
    print("value.size : ${value.size}");
  });

}