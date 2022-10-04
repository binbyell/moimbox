
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moimbox/data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/page/SignUp_Address.dart';
import 'package:moimbox/tempP.dart';

import 'package:moimbox/data/data_meta.dart';


/// 회원가입 정보입력

class SignUp_SignUpPage extends StatefulWidget {
  @override
  _signUp_SignUpPage createState() => _signUp_SignUpPage();
}

class _signUp_SignUpPage extends State<SignUp_SignUpPage> {

  /// 이름
  final TextEditingController _controllerName = TextEditingController();
  /// 닉네임
  final TextEditingController _controllerNickName = TextEditingController();
  /// 생년월일
  final TextEditingController _controllerDateOfBirth = TextEditingController();
  /// 연락처
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  /// 이메일
  final TextEditingController _controllerEMail = TextEditingController();

  String address = "내 지역 선택";

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                        ? const Icon(
                      Icons.add_a_photo,
                      color: Color(0xffC4C4C4),
                    )
                        :ClipOval(
                      child: Image.file(metaSignInImage!,fit: BoxFit.fitHeight,),
                    ),
                  ),
                ),
                /// 이름을 입력해 주세요
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// 이름을 입력해 주세요
                      Container(
                        width: _device_width * 0.517,
                        height: _device_height * 0.064,
                        decoration: BoxDecoration(
                          color: ColorsForApp.textFieldBack,
                          borderRadius:  BorderRadius.circular(5),
                        ),
                        child: TextField(
                          onChanged: (text){
                            metaMyProfileItem.name = text;
                          },
                          onSubmitted: (text){
                            metaMyProfileItem.name = text;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[ㅏ-ㅣ|ㄱ-ㅎ|가-힣|ㆍ|ᆢ]")),
                          ],
                          keyboardType: TextInputType.name,
                          maxLength: 8,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                              counterText: '',
                              contentPadding:
                              EdgeInsets.fromLTRB(_device_width * 0.05, 0, 0, 0),
                              border: InputBorder.none,
                              hintText: "이름을 입력해 주세요",
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
                /// 닉네임을 입력해 주세요
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: _device_width * 0.903,
                  height: _device_height * 0.064,
                  decoration: BoxDecoration(
                    color: ColorsForApp.textFieldBack,
                    borderRadius:  BorderRadius.circular(5),
                  ),
                  child: TextField(
                    onChanged: (text){
                      metaMyProfileItem.nickname = text;
                    },
                    onSubmitted: (text){
                      metaMyProfileItem.nickname = text;
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
                        hintText: "닉네임을 입력해 주세요",
                        hintStyle: const TextStyle(
                            color: ColorsForApp.hintTextColor
                        )
                    ),
                  ),
                ),
                /// 공백, 특수기호는 입력되지 않습니다. (한글, 영어, 숫자)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: _device_width * 0.903,
                  child: const Text(
                    "공백, 특수기호는 입력되지 않습니다. (한글, 영어, 숫자)",
                    style: TextStyle(
                        color: ColorsForApp.narrationText
                    ),
                  ),
                ),
                /// 생년월일을 입력해주세요.(8자리)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: _device_width * 0.903,
                  height: _device_height * 0.064,
                  decoration: BoxDecoration(
                    color: ColorsForApp.textFieldBack,
                    borderRadius:  BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: _controllerDateOfBirth,
                    keyboardType: TextInputType.datetime,
                    maxLength: 8,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(_device_width * 0.05, 0, 0, 0),
                        border: InputBorder.none,
                        hintText: "생년월일을 입력해주세요.(8자리)",
                        hintStyle: const TextStyle(
                            color: ColorsForApp.hintTextColor
                        )
                    ),
                  ),
                ),
                /// 연락처를 입력해주세요.
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: _device_width * 0.903,
                  height: _device_height * 0.064,
                  decoration: BoxDecoration(
                    color: ColorsForApp.textFieldBack,
                    borderRadius:  BorderRadius.circular(5),
                  ),
                  child: TextField(
                    onChanged: (text){
                      metaMyProfileItem.phoneNumber = text;
                    },
                    onSubmitted: (text){
                      metaMyProfileItem.phoneNumber = text;
                    },
                    controller: _controllerPhoneNumber,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(_device_width * 0.05, 0, 0, 0),
                        border: InputBorder.none,
                        hintText: "연락처를 입력해주세요.",
                        hintStyle: const TextStyle(
                            color: ColorsForApp.hintTextColor
                        )
                    ),
                  ),
                ),
                // /// 인증번호를 입력해주세요.
                // Container(
                //   margin: const EdgeInsets.symmetric(vertical: 8),
                //   width: _device_width * 0.903,
                //   height: _device_height * 0.064,
                //   decoration: BoxDecoration(
                //     color: ColorsForApp.textFieldBack,
                //     borderRadius:  BorderRadius.circular(5),
                //   ),
                //   child: TextField(
                //     controller: TextEditingController(),
                //     keyboardType: TextInputType.number,
                //     maxLength: 11,
                //     style: TextStyle(
                //       fontSize: 15,
                //     ),
                //     decoration: InputDecoration(
                //         counterText: '',
                //         contentPadding: EdgeInsets.fromLTRB(_device_width * 0.05, 0, 0, 0),
                //         border: InputBorder.none,
                //         hintText: "인증번호를 입력해주세요.",
                //         hintStyle: const TextStyle(
                //             color: ColorsForApp.hintTextColor
                //         )
                //     ),
                //   ),
                // ),
                /// 이메일을 입력해주세요.
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: _device_width * 0.903,
                  height: _device_height * 0.064,
                  decoration: BoxDecoration(
                    color: ColorsForApp.textFieldBack,
                    borderRadius:  BorderRadius.circular(5),
                  ),
                  child: TextField(
                    onChanged: (text){
                      metaMyProfileItem.eMail = text;
                    },
                    onSubmitted: (text){
                      metaMyProfileItem.eMail = text;
                    },
                    controller: _controllerEMail,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 11,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(_device_width * 0.05, 0, 0, 0),
                        border: InputBorder.none,
                        hintText: "이메일을 입력해주세요.",
                        hintStyle: const TextStyle(
                            color: ColorsForApp.hintTextColor
                        )
                    ),
                  ),
                ),
                /// 회원가입 시 등록한 정보는 개인정보처리방침에 따라 처리되며,
                /// 기본정보는 내 프로필에서 수정 가능 합니다.
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: _device_width * 0.903,
                  child: const Text(
                    "회원가입 시 등록한 정보는 개인정보처리방침에 따라 처리되며,"
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