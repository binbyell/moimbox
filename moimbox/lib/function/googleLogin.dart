
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moimbox/data/data_meta.dart';

Future signInWithGoogle() async {
  print("signInWithGoogle");
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  UserCredential userCred = await FirebaseAuth.instance.signInWithCredential(credential);
  print("to test google sign in : ${userCred.user!.uid}");
  metaMyProfileItem.uid = userCred.user!.uid;
  var temp = FirebaseFirestore.instance.collection("Account");
  var test = await temp.doc(userCred.user!.uid).get();
  print("to test google sign in : ${test.get('bool')}");
  setMetaMyProfileItem(userCred.user!.uid);
  return  test.get('bool');
}

Future setMetaMyProfileItem(String uid) async {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("Account");
  // var test = await collectionReference.doc(uid).get();
  collectionReference.doc(uid).get().then((value){
    metaMyProfileItem.uid = uid;
    metaMyProfileItem.name = value.get('NAME');
    metaMyProfileItem.profileImageUrl  = value.get('PROFILE_IMAGE_URL');
    metaMyProfileItem.address  = value.get('ADDRESS');
    metaMyProfileItem.nickname  = value.get('NICKNAME');
    metaMyProfileItem.dateOfBirth  = value.get('DATE_OF_BIRTH');
    metaMyProfileItem.phoneNumber  = value.get('PHONE_NUMBER');
    metaMyProfileItem.eMail  = value.get('E_MAIL');
    metaMyProfileItem.introduce  = value.get('INTRODUCE');
    metaMyProfileItem.interest  = value.get('INTEREST');
  });
}