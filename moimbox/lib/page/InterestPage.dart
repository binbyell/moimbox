import 'package:flutter/material.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/function/googleLogin.dart';
import 'package:moimbox/page/_Home.dart';
import '../class/ClassMeetingItemPreview.dart';
import '../data/data.dart';

class InterestPage extends StatefulWidget {
  bool needAppBar;

  InterestPage({Key? key, required this.needAppBar}): super(key: key);

  @override
  _interestPage createState() => _interestPage();
}

class _interestPage extends State<InterestPage> {

  bool isGolf = false;
  bool isFishing = false;

  bool isBowling = false;
  bool isBilliards = false;

  bool isSurfing = false;
  bool isClimbing = false;

  int getTotal(){
    List<bool> boolList = <bool>[isGolf, isFishing, isBowling, isBilliards, isSurfing, isClimbing];
    int total = boolList.where((c) => c).length;
    return total;
  }

  bool isOver(){
    bool result = getTotal() >= 3?true:false;
    return result;
  }

  void whenChangeInterest(){
    List<String>interestList  = [];
    if(isGolf){interestList.add(MeetingItemTag.golf);}
    if(isFishing){interestList.add(MeetingItemTag.fishing);}
    if(isBowling){interestList.add(MeetingItemTag.bowling);}
    if(isBilliards){interestList.add(MeetingItemTag.billiards);}
    if(isSurfing){interestList.add(MeetingItemTag.surfing);}
    if(isClimbing){interestList.add(MeetingItemTag.climbing);}
    metaMyProfileItem.setInterest(interestList);
    print("=whenChangeInterest=\n${metaMyProfileItem.interest}\n=whenChangeInterest=");
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
      appBar: widget.needAppBar
          ?AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsForApp.black,
          ),
          onPressed: ()=>Navigator.of(context).pop(),
        ),
        title: Text("관심사 선택", style: appBarTitleTextStyle,),
        backgroundColor: ColorsForApp.appBarColor,
        actions: [
          TextButton(
              onPressed: (){
                addAccount(metaMyProfileItem);
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>Home()));
              },
              child: Text("변경")
          )
        ],
      )

          :null,
      body: Container(
          width: _device_width,
          padding: EdgeInsets.fromLTRB(_device_width * 0.057, _device_height * 0.038, _device_width * 0.057, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 3개까지 선택이 가능합니다.
                Container(
                  margin: EdgeInsets.only(bottom: _device_height * 0.021),
                  width: _device_width,
                  child: const Text(
                    "3개까지 선택이 가능합니다.",
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