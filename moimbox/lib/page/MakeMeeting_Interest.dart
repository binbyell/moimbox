


import 'package:flutter/material.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/function/function.dart';

class Meeting_InterestReturn extends StatefulWidget {

  @override
  _interestPage createState() => _interestPage();
}

class _interestPage extends State<Meeting_InterestReturn> {

  bool isGolf = false;
  bool isFishing = false;

  bool isBowling = false;
  bool isBilliards = false;

  bool isSurfing = false;
  bool isClimbing = false;

  List<String>interestList  = [];

  int getTotal(){
    List<bool> boolList = <bool>[isGolf, isFishing, isBowling, isBilliards, isSurfing, isClimbing];
    int total = boolList.where((c) => c).length;
    return total;
  }

  bool isOver(){
    bool result = getTotal() >= 1?true:false;
    if(result){
      appToast("하나만 선택이 가능합니다. 선택한 항목을 다시 누르시면 취소됩니다.");
    }
    return result;
  }

  void whenChangeInterest(){
    List<String> temp = [];
    if(isGolf){temp.add(MeetingItemTag.golf);}
    if(isFishing){temp.add(MeetingItemTag.fishing);}
    if(isBowling){temp.add(MeetingItemTag.bowling);}
    if(isBilliards){temp.add(MeetingItemTag.billiards);}
    if(isSurfing){temp.add(MeetingItemTag.surfing);}
    if(isClimbing){temp.add(MeetingItemTag.climbing);}
    interestList = temp;

    print("=whenChangeInterest=\n$interestList\n=whenChangeInterest=");
  }

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsForApp.black,
          ),
          onPressed: ()=>Navigator.of(context).pop(),
        ),
        title: Text("모임 주제 선택", style: appBarTitleTextStyle,),
        backgroundColor: ColorsForApp.appBarColor,
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context, interestList);
              },
              child: Text("확인")
          )
        ],
      ),
      body: Container(
          width: _device_width,
          padding: EdgeInsets.fromLTRB(_device_width * 0.057, _device_height * 0.038, _device_width * 0.057, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 1개만 선택이 가능합니다.
                Container(
                  margin: EdgeInsets.only(bottom: _device_height * 0.021),
                  width: _device_width,
                  child: const Text(
                    "1개만 선택이 가능합니다.",
                    style: TextStyle(
                        color: ColorsForApp.narrationText
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          /// golf
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(isOver()){
                                  isGolf = false;
                                }
                                else{
                                  isGolf = !isGolf;
                                }
                              });
                              whenChangeInterest();
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, _device_height * 0.016, _device_width * 0.019, _device_height * 0.016),
                              width: _device_width * 0.423,
                              height: _device_height * 0.19,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/golf.png"),
                                    fit: BoxFit.cover,
                                  )
                              ),
                              child: isGolf
                                  ?Container(
                                  width: _device_width * 0.423,
                                  height: _device_height * 0.19,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("images/imageChecked.png"),
                                        fit: BoxFit.fill,
                                      )
                                  )
                              )
                                  :Container(),
                            ),
                          ),
                          /// fishing
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(isOver()){
                                  isFishing = false;
                                }
                                else{
                                  isFishing = !isFishing;
                                }
                              });
                              whenChangeInterest();
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(_device_width * 0.019, _device_height * 0.016, 0, _device_height * 0.016),
                              width: _device_width * 0.423,
                              height: _device_height * 0.19,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/fishing.png"),
                                    fit: BoxFit.cover,
                                  )
                              ),
                              child: isFishing
                                  ?Container(
                                  width: _device_width * 0.423,
                                  height: _device_height * 0.19,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("images/imageChecked.png"),
                                        fit: BoxFit.fill,
                                      )
                                  )
                              )
                                  :Container(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          /// bowling
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(isOver()){
                                  isBowling = false;
                                }
                                else{
                                  isBowling = !isBowling;
                                }
                              });
                              whenChangeInterest();
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, _device_height * 0.016, _device_width * 0.019, _device_height * 0.016),
                              width: _device_width * 0.423,
                              height: _device_height * 0.19,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/bowling.png"),
                                    fit: BoxFit.cover,
                                  )
                              ),
                              child: isBowling
                                  ?Container(
                                  width: _device_width * 0.423,
                                  height: _device_height * 0.19,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("images/imageChecked.png"),
                                        fit: BoxFit.fill,
                                      )
                                  )
                              )
                                  :Container(),
                            ),
                          ),
                          /// billiards
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(isOver()){
                                  isBilliards = false;
                                }
                                else{
                                  isBilliards = !isBilliards;
                                }
                                whenChangeInterest();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(_device_width * 0.019, _device_height * 0.016, 0, _device_height * 0.016),
                              width: _device_width * 0.423,
                              height: _device_height * 0.19,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/billiards.png"),
                                    fit: BoxFit.cover,
                                  )
                              ),
                              child: isBilliards
                                  ?Container(
                                  width: _device_width * 0.423,
                                  height: _device_height * 0.19,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("images/imageChecked.png"),
                                        fit: BoxFit.fill,
                                      )
                                  )
                              )
                                  :Container(),
                            ),
                          ),
                        ],

                      ),
                      Row(
                        children: [
                          /// Surfing
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(isOver()){
                                  isSurfing = false;
                                }
                                else{
                                  isSurfing = !isSurfing;
                                }
                                whenChangeInterest();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, _device_height * 0.016, _device_width * 0.019, _device_height * 0.016),
                              width: _device_width * 0.423,
                              height: _device_height * 0.19,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/surfing.png"),
                                    fit: BoxFit.cover,
                                  )
                              ),
                              child: isSurfing
                                  ?Container(
                                  width: _device_width * 0.423,
                                  height: _device_height * 0.19,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("images/imageChecked.png"),
                                        fit: BoxFit.fill,
                                      )
                                  )
                              )
                                  :Container(),
                            ),
                          ),
                          /// Climbing
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(isOver()){
                                  isClimbing = false;
                                }
                                else{
                                  isClimbing = !isClimbing;
                                }
                              });
                              whenChangeInterest();
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(_device_width * 0.019, _device_height * 0.016, 0, _device_height * 0.016),
                              width: _device_width * 0.423,
                              height: _device_height * 0.19,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/climbing.png"),
                                    fit: BoxFit.cover,
                                  )
                              ),
                              child: isClimbing
                                  ?Container(
                                  width: _device_width * 0.423,
                                  height: _device_height * 0.19,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("images/imageChecked.png"),
                                        fit: BoxFit.fill,
                                      )
                                  )
                              )
                                  :Container(),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                /// 관심사는 [내 프로필]에서 변경할 수 있습니다.
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 374,
                  child: const Text(
                    "관심사는 [내 프로필]에서 변경할 수 있습니다.",
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
