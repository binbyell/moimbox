import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/fuctionTest.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'dart:io';

import 'package:moimbox/page/MakeMeeting_Location.dart';
import 'package:moimbox/page/MakeMeeting_Interest.dart';

/// 회원가입 정보입력

class MakeMeeting extends StatefulWidget {
  @override
  _makeMeeting createState() => _makeMeeting();
}

class _makeMeeting extends State<MakeMeeting> {

  File? meetingTitleImage;
  String location = "";
  String meetingTag = "";
  String meetingTitle = "";

  int selectMeetingFrequency = 0;
  List<String> meetingFrequencyList = ["1주일", "1개월", "1분기"];
  List<String> meetingFrequencyToAddList = ["주", "월", "분기"];
  String meetingFrequency = ""; // n회

  int selectBillFrequency = 0;
  List<String> billFrequencyList = ["모임 시", "1주일", "1개월", "1분기", "6개월", "1년"];

  String price = "";
  String intro = "";

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    Container _line = Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
        width: _device_width,
        height: 1,
        decoration: BoxDecoration(
            color: const Color(0xffc4c4c4)
        )
    );

    /// Dialog 버튼 있는 토스트 toast
    void FlutterDialog(BuildContext context) {
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
                children: const <Widget>[
                  Text("모임을 개설하시겠습니까?"),
                ],
              ),
              //
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "세부 내용은 언제든지 수정할 수 있습니다. 기본 모임은 최대 20명까지 모집할 수 있습니다. 모임 업그레이드로 더욱 많은 인원을 수용할 수 있습니다!",
                  ),
                ],
              ),
              actions: <Widget>[
                SizedBox(
                  width: _device_width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// 모임 개설하기
                      InkWell(
                        onTap: (){

                          MeetingItem thisMeetingItem = MeetingItem(
                            onerUid: metaMyProfileItem.uid!,
                            title: meetingTitle,
                            meetingTag: meetingTag,
                            // imageUrlList:
                            location: location,
                            frequency: "${meetingFrequencyToAddList[selectMeetingFrequency]}당 $meetingFrequency회 모임",
                            billFrequency: billFrequencyList[selectBillFrequency],
                            price: price,
                            intro: intro
                          );

                          // 이미지 제외한 데이터 먼저 서버에 저장 후 Meeting ID값을 metaData의 currentMeetingDocId에 저장
                          addMyMeeting(thisMeetingItem);
                          if(meetingTitleImage != null){
                            // 저장된 meeting ID값을 기반으로 Storage에 이미지 저장
                            sendImageToMeetingStorage(meetingTitleImage!, currentMeetingDocId).then((value) {
                              // 이미지 저장후 이미지 위치 meeting doc에 업데이트
                              upDateMeetingTitleImageUrl(value, currentMeetingDocId);
                            });
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                          /// do something
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: 262,
                          height: 56,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50)
                              ),
                              color: Color(0xff2e2c76)
                          ),
                          child: const Center(
                            child: Text(
                                "모임 개설하기",
                                style: TextStyle(
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
                      /// 돌아가기
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          /// do something
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: 262,
                            height: 56,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50)
                                ),
                                color: Color(0xff8A8A8A)
                            ),
                            child: const Center(
                              child: Text(
                                  "돌아가기",
                                  style: TextStyle(
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

    return Scaffold(
      appBar: AppBar(
          title: Text("모임 개설", style: appBarTitleTextStyle,),
          backgroundColor: ColorsForApp.appBarColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ColorsForApp.black,
            ),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        actions: [
          TextButton(
            child: Text(
              "확인",
            ),
            onPressed: (){
              if(location.isEmpty){
                appToast("모임 활동 지역을 선택해 주세요");
              }
              else if(meetingTag.isEmpty){
                appToast("모임 주제를 선택해 주세요");
              }
              else if(meetingTitle.isEmpty){
                appToast("모임 이름을 입력해 주세요");
              }
              else if(meetingFrequency.isEmpty){
                appToast("모임 횟수를 입력해 주세요");
              }
              else if(price.isEmpty){
                appToast("모임 회비를 입력해 주세요");
              }
              else{
                FlutterDialog(context);
              }
            },
          )
        ],
      ),

      body: Container(
          width: _device_width,
          padding: const EdgeInsets.fromLTRB(20,0,20,0),
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 프로필 사진 추가
                  InkWell(
                    onTap: (){
                      getImage().then((value) {
                        setState(() {
                          meetingTitleImage = value;
                        });
                        print("meetingTitleImage : $meetingTitleImage");
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
                      child: meetingTitleImage == null
                          ? const Icon(
                        Icons.add_a_photo,
                        color: Color(0xffC4C4C4),
                      )
                          :ClipOval(
                        child: Image.file(meetingTitleImage!,fit: BoxFit.fitHeight,),
                      ),
                    ),
                  ),

                  /// 활동 지역 선택, 모임 주제 선택
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// 활동 지역 선택
                        Container(
                          width: _device_width * 0.517,
                          height: _device_height * 0.064,
                          decoration: appButtonDecoration,
                          child: TextButton(
                            onPressed: () {
                              _getPushBackLocation(context);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(_device_width * 0.0386),
                              primary: ColorsForApp.buttonTextColor,
                            ),
                            child: location.isEmpty
                                ?const Text("모임 활동 지역 선택")
                                :Text(location),
                          ),
                        ),
                        /// 모임 주제 선택
                        Container(
                          width: _device_width * 0.348,
                          height: _device_height * 0.064,
                          decoration: appButtonDecoration,
                          child: TextButton(
                            onPressed: () {
                              _getPushBackInterest(context);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(_device_width * 0.0386),
                              primary: ColorsForApp.buttonTextColor,
                            ),
                            child: meetingTag.isEmpty
                                ?const Text("모임 주제 선택")
                                :Text(meetingTag),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /// 모임 이름을 입력해 주세요
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 374,
                    height: _device_height * 0.064,
                    decoration: BoxDecoration(
                      color: ColorsForApp.textFieldBack,
                      borderRadius:  BorderRadius.circular(5),
                    ),
                    child: TextField(
                      onChanged: (text){
                        meetingTitle = text;
                      },
                      onSubmitted: (text){
                        meetingTitle = text;
                      },
                      keyboardType: TextInputType.name,
                      maxLength: 16,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9|ㅏ-ㅣ|ㄱ-ㅎ|가-힣|ㆍ|ᆢa-zA-Z]")),
                      ],
                      decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(horizontal: _device_width * 0.05, vertical: 16),
                          border: InputBorder.none,
                          hintText: "모임 이름을 입력해 주세요",
                          hintStyle: const TextStyle(
                              color: ColorsForApp.hintTextColor
                          )
                      ),
                    ),
                  ),
                  /// 특수기호는 입력되지 않습니다. (한글, 영어, 숫자)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 374,
                    child: const Text(
                      "특수기호는 입력되지 않습니다. (한글, 영어, 숫자)",
                      style: TextStyle(
                          color: ColorsForApp.narrationText
                      ),
                    ),
                  ),
                  /// 모임에 대해 설명해 주세요.
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 374,
                    height: 126,
                    decoration: BoxDecoration(
                      color: ColorsForApp.textFieldBack,
                      borderRadius:  BorderRadius.circular(5),
                    ),
                    child: TextField(
                      onChanged: (text){
                        intro = text;
                      },
                      onSubmitted: (text){
                        intro = text;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      maxLength: 50,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: _device_width * 0.05),
                          border: InputBorder.none,
                          hintText: "모임에 대해 설명해 주세요.",
                          hintStyle: const TextStyle(
                              color: ColorsForApp.hintTextColor
                          )
                      ),
                    ),
                  ),
                  _line,
                  /// 모임 일정 설정
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: _device_width,
                    child: const Text(
                      "모임 일정 설정",
                      style: TextStyle(
                          color: ColorsForApp.narrationText
                      ),
                    ),
                  ),
                  /// 모임 일정 설정 gird
                  Container(
                      width: _device_width,
                      height: _device_height * 0.08,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: GridView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: meetingFrequencyList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                            childAspectRatio: 2 / 1, //item 의 가로 2, 세로 1 의 비율
                            mainAxisSpacing: 8, //수평 Padding
                            crossAxisSpacing: 8, //수직 Padding
                          ),
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              // width: _device_width * 0.27,
                              // height: _device_height * 0.07,
                              decoration: appButtonDecoration,
                              child: TextButton(
                                  onPressed: () {
                                    setState((){
                                      selectMeetingFrequency = index;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    primary: ColorsForApp.buttonTextColor,
                                    backgroundColor: selectMeetingFrequency == index? const Color(0xff2E2C76) : const Color(0xffFFFFFF)
                                  ),
                                  child: Text(
                                      meetingFrequencyList[index],
                                    style: TextStyle(
                                      color: selectMeetingFrequency == index? const Color(0xffFFFFFF) : const Color(0xff696969)
                                    ),
                                  )
                              ),
                            );
                          }
                      )
                  ),
                  /// 모임 횟수를 입력해주세요. 숫자만 가능합니다.
                  Container(
                    height: 62,
                    decoration: BoxDecoration(
                      color: ColorsForApp.textFieldBack,
                      borderRadius:  BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsets.zero,//EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: TextField(
                              onChanged: (text){
                                meetingFrequency = text;
                              },
                              onSubmitted: (text){
                                meetingFrequency = text;
                              },
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.fromLTRB(_device_width * 0.04, 0, 0, 0),
                                border: InputBorder.none,
                                hintText: "모임 횟수를 입력해주세요. 숫자만 가능합니다.",
                                hintStyle: TextStyle(
                                    color: ColorsForApp.hintTextColor,
                                  fontSize: 15
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Stack(
                            children: const [
                              Align(
                                alignment: AlignmentDirectional(0.9, 0),
                                child: Text(
                                  '회',
                                  style: TextStyle(
                                      color: Color(0xff797979),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansKR",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 20.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _line,
                  /// 모임 회비 설정
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: _device_width,
                    child: const Text(
                      "모임 회비 설정",
                      style: TextStyle(
                          color: ColorsForApp.narrationText
                      ),
                    ),
                  ),
                  /// 모임 회비 설정 grid
                  Container(
                    width: _device_width,
                    height: _device_height * 0.16,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: GridView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: billFrequencyList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                          childAspectRatio: 2 / 1, //item 의 가로 2, 세로 1 의 비율
                          mainAxisSpacing: 8, //수평 Padding
                          crossAxisSpacing: 8, //수직 Padding
                        ),
                        itemBuilder: (BuildContext context, int index){
                        return Container(
                          // width: _device_width * 0.27,
                          // height: _device_height * 0.07,
                          decoration: appButtonDecoration,
                          child: TextButton(
                              onPressed: () {
                                setState((){
                                  selectBillFrequency = index;
                                });
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                primary: ColorsForApp.buttonTextColor,
                                backgroundColor: selectBillFrequency == index? const Color(0xff2E2C76) : const Color(0xffFFFFFF)
                              ),
                              child: Text(
                                billFrequencyList[index],
                                style: TextStyle(
                                    color: selectBillFrequency == index? const Color(0xffFFFFFF) : const Color(0xff696969)
                                ),
                              )
                          ),
                        );
                      }
                    )
                  ),
                  /// 모임 회비를 입력해주세요.
                  Container(
                    height: 62,
                    decoration: BoxDecoration(
                      color: ColorsForApp.textFieldBack,
                      borderRadius:  BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsets.zero,//EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: TextField(
                              onChanged: (text){
                                price = text;
                              },
                              onSubmitted: (text){
                                price = text;
                              },
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.fromLTRB(_device_width * 0.04, 0, 0, 0),
                                border: InputBorder.none,
                                hintText: "모임 회비를 입력해주세요.",
                                hintStyle: const TextStyle(
                                    color: ColorsForApp.hintTextColor
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Stack(
                            children: const [
                              Align(
                                alignment: AlignmentDirectional(0.9, 0),
                                child: Text(
                                  '원',
                                  style: TextStyle(
                                      color: Color(0xff797979),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansKR",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 20.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  /// 회비가 없을 시 0을 입력해 주세요.
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: _device_width,
                    child: const Text(
                      "회비가 없을 시 0을 입력해 주세요.",
                      style: TextStyle(
                          color: ColorsForApp.narrationText,
                        fontSize: 14
                      ),
                    ),
                  ),
                ],
              ),
            )
          )
      ),
    );
  }

  _getPushBackLocation(BuildContext context) async {
    print("fjfjfj");
    final result = await Navigator.push(
      context,
      // 다음 단계에서 SelectionScreen를 만들 것입니다.
      MaterialPageRoute(builder: (context) => Meeting_Location()),
    );
    setState((){
      location = result;
    });
    print("meeting address : $location");
  }
  _getPushBackInterest(BuildContext context) async {
    print("fjfjfj");
    final result = await Navigator.push(
      context,
      // 다음 단계에서 SelectionScreen를 만들 것입니다.
      MaterialPageRoute(builder: (context) => Meeting_InterestReturn()),
    );
    setState((){
      if(result.length != 0){
        meetingTag = result[0];
      }
      else{
        meetingTag = "";
      }
    });
    print("meeting interestList : $meetingTag");
  }
}