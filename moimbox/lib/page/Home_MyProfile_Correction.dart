import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/function/googleLogin.dart';
import 'package:moimbox/page/SignUp_Address.dart';
import 'package:moimbox/page/_Home.dart';

class CorrectionProfile extends StatefulWidget {
  @override
  _crrectionProfile createState() => _crrectionProfile();
}

class _crrectionProfile extends State<CorrectionProfile> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsForApp.black,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: Container(
          child: Text("프로필 수정", style: appBarTitleTextStyle,),
        ),
        backgroundColor: ColorsForApp.appBarColor,
        actions: [
          TextButton(
              onPressed: (){
                if(metaSignInImage == null){
                  addAccount(metaMyProfileItem);
                  metaSignInImage = null;
                  print("wemetaMyProfileItem.nickname : ${metaMyProfileItem.nickname}");
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>Home()));
                }
                else{
                  delImageFromAccountStorage(metaMyProfileItem.uid).then((value) {
                    sendImageToAccountStorage(metaSignInImage!).then((value){
                      setState(() {
                        metaMyProfileItem.profileImageUrl = value as String;
                      });
                      addAccount(metaMyProfileItem);
                      metaSignInImage = null;
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>Home()));
                    });
                  });
                }
              },
              child: Text(
                "저장",
                style: TextStyle(),
              )
          )
        ],
      ),
      body: Container(
          width: _device_width,
          padding: const EdgeInsets.fromLTRB(20,0,20,0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 프로필 사진 추가
                InkWell(
                  onTap: (){
                    getImage().then((value) {
                      setState(() {
                        metaSignInImage = value;
                      });
                      print("metaSignInImage : $metaSignInImage");
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    height: _device_width * 0.275,
                    width: _device_width * 0.275,
                    decoration: const BoxDecoration(
                      color: ColorsForApp.textFieldBack,
                      shape: BoxShape.circle,
                    ),
                    child: metaSignInImage == null
                        ? ClipOval(
                      child: Image.network(metaMyProfileItem.profileImageUrl, fit: BoxFit.fill,))
                        :ClipOval(
                      child: Image.file(metaSignInImage!,fit: BoxFit.fill,),
                    ),
                  ),
                ),
                /// 닉네임을 입력해 주세요
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// 닉네임을 입력해 주세요
                      Container(
                        width: _device_width * 0.517,
                        height: _device_height * 0.064,
                        decoration: BoxDecoration(
                          color: ColorsForApp.textFieldBack,
                          borderRadius:  BorderRadius.circular(5),
                        ),
                        child: TextField(
                          onChanged: (text){
                            setState((){
                              metaMyProfileItem.nickname = text;
                            });
                          },
                          onSubmitted:(text){
                            setState((){
                              metaMyProfileItem.nickname = text;
                            });
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[ㅏ-ㅣ|ㄱ-ㅎ|가-힣|ㆍ|ᆢa-zA-Z]")),
                          ],
                          keyboardType: TextInputType.name,
                          maxLength: 8,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.fromLTRB(_device_width * 0.05, 0, 0, 0),
                              border: InputBorder.none,
                              hintText: "닉네임을 입력해 주세요.",
                              hintStyle: const TextStyle(
                                  color: ColorsForApp.hintTextColor
                              )
                          ),
                        ),
                      ),
                      /// 내 지역 선택
                      Container(
                        width: _device_width * 0.348,
                        height: _device_height * 0.064,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(
                              color: const Color(0xffc4c4c4),
                              width: 1
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUP_Address())).whenComplete(() {setState((){});});
                          },
                          style: TextButton.styleFrom(
                            primary: ColorsForApp.buttonTextColor,
                          ),
                          child: Text(metaMyProfileItem.address.isEmpty?"내 지역 선택":metaMyProfileItem.address),
                        ),
                      ),
                    ],
                  ),
                ),
                /// 한 줄 소개를 입력해 주세요
                Container(
                  padding: EdgeInsets.all(4),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: _device_width * 0.903,
                  height: _device_height * 0.064,
                  decoration: BoxDecoration(
                    color: ColorsForApp.textFieldBack,
                    borderRadius:  BorderRadius.circular(5),
                  ),
                  child: TextField(
                    onChanged: (text){
                      metaMyProfileItem.introduce = text;
                    },
                    onSubmitted: (text){
                      metaMyProfileItem.introduce = text;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[ ㅏ-ㅣ|ㄱ-ㅎ|가-힣|ㆍ|ᆢa-zA-Z]")),
                    ],
                    keyboardType: TextInputType.name,
                    maxLength: 25,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(_device_width * 0.05, 0, 0, 0),
                        border: InputBorder.none,
                        hintText: "한 줄 소개를 작성 해주세요. (25자)",
                        hintStyle: const TextStyle(
                            color: ColorsForApp.hintTextColor
                        )
                    ),
                  ),
                ),
                /// 회원가입 시 등록한 정보는 개인정보처리방침에
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: _device_width * 0.865,
                  child: const Text(
                    "회원가입 시 등록한 정보는 개인정보처리방침에 따라 처리되며, "
                    "기본정보는 내 프로필에서 수정 가능 합니다.",
                    style: TextStyle(
                        color: ColorsForApp.narrationText
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}