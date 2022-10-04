import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileImageAndNickNameFromUID extends StatefulWidget {

  final String uid;
  ProfileImageAndNickNameFromUID({Key? key, required this.uid}): super(key: key);

  @override
  _viewImageFromUid createState() => _viewImageFromUid();
}

class _viewImageFromUid extends State<ProfileImageAndNickNameFromUID> {
  Future sendImageToAccountStorage(String uid) async{
    var temp = FirebaseFirestore.instance.collection("Account");
    DocumentSnapshot test = await temp.doc(uid).get();

    return test;
  }
  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    double _this_width = _device_width * 0.437;
    double _this_height = _device_height * 0.053;
    return Scaffold(
        body: Center(
          child: FutureBuilder(
              future: sendImageToAccountStorage(widget.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                if (snapshot.hasData == false) {
                  return const CircularProgressIndicator();
                }
                //error가 발생하게 될 경우 반환하게 되는 부분
                else if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(_this_width * 0.044),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }
                // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                else {
                  return Row(
                    children: [
                      SizedBox(
                        height: _this_height,
                        width: _this_height,
                        child: ClipOval(
                          child: Image.network(snapshot.data.get("PROFILE_IMAGE_URL"), fit: BoxFit.fill,),
                        ),
                      ),
                      SizedBox(width: _this_width * 0.088,),
                      SizedBox(
                        width: _this_width * 0.286,
                        child: Text(snapshot.data.get("NICKNAME")),
                      )
                    ],
                  );
                }
              }
          ),
        )
    );
  }
}