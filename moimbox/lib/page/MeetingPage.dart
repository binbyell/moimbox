import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeeting.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/page/MeetingPage_AppliedList.dart';
import 'package:moimbox/page/MeetingPage_ApplyPage.dart';
import 'package:moimbox/page/MeetingPage_Gallery.dart';
import 'package:moimbox/page/MeetingPage_Home.dart';
import 'package:moimbox/page/MeetingPage_MakeNotice.dart';
import 'package:moimbox/page/MeetingPage_MakePost.dart';
import 'package:moimbox/page/MeetingPage_MeetingManagement.dart';
import 'package:moimbox/page/MeetingPage_Memberlist.dart';
import 'package:moimbox/page/MeetingPage_PostList.dart';
import 'package:moimbox/tempP.dart';

class MeetingPage extends StatefulWidget {

  String meetingState;
  MeetingItem meetingItem;

  MeetingPage({Key? key, required this.meetingState, required this.meetingItem}): super(key: key);

  @override
  _meetingPage createState() => _meetingPage();
}

class _meetingPage extends State<MeetingPage> {

  double bottomHeight = 72;
  double topNaviHeight = 50;

  int _selectedPageIndex = 0;

  TextStyle topNaviTextStyle = TextStyle(
      color: Color(0xff2e2c76),
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle:  FontStyle.normal,
      fontSize: 16.0
  );

  final List<PopupMenuItem> popupMenuOnerUid = [
    PopupMenuItem(
      value: 1,
      child: Text("모임 관리 및 설정"),
    ),
    PopupMenuItem(
      value: 2,
      child: Text("모임 업그레이드"),
    ),
    PopupMenuItem(
      value: 3,
      child: Text("모임 멤버 리스트 보기"),
      // onTap: (){print("모임 멤버 리스트 보기");},
    ),
    PopupMenuItem(
      value: 4,
      child: Text("모임 가입 신청 리스트 보기"),
    )
  ];

  List<PopupMenuItem> popupMenuElse = [
    PopupMenuItem(
      child: Text("모임 신고하기", style: TextStyle(color: ColorsForApp.inactiveColor),),
      value: 1,
      onTap: (){print("FirstFirstFirst");},
    ),
    PopupMenuItem(
      child: Text("모임 멤버 리스트 보기"),
      value: 2,
      onTap: (){print("SecondSecondSecond");},
    )
  ];
  List<PopupMenuItem> casePopupMenuList(){
    if(metaMyProfileItem.uid == widget.meetingItem.onerUid){
      return popupMenuOnerUid;
    }
    return popupMenuElse;
  }

  void choiceAction(Object? choice, BuildContext context){
    if(metaMyProfileItem.uid == widget.meetingItem.onerUid){
      switch(choice.toString()){
        case '1':
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => MeetingManagementPage(meetingItem: widget.meetingItem))
          );
          break;
        case '2':
          appToast("준비중입니다");
          break;
        case '3':
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => MeetingMemberListPage(meetingItem: widget.meetingItem, isOwner: widget.meetingItem.onerUid == metaMyProfileItem.uid,))
          );
          break;
        case '4':
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => MeetingAppliedListPage(meetingItem: widget.meetingItem, isOwner: widget.meetingItem.onerUid == metaMyProfileItem.uid,))
          );
          break;
        default:
          print("ajajaj");
          break;
      }
    }
    else{
      switch(choice.toString()) {
        case '1':
          break;
        case '2':
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => MeetingMemberListPage(meetingItem: widget.meetingItem, isOwner: widget.meetingItem.onerUid == metaMyProfileItem.uid,))
          );
          break;
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    List<Widget> _pageList = <Widget>[
      MeetingPage_Home(meetingState: widget.meetingState, meetingItemPreviewItem: widget.meetingItem,),
      MeetingPage_PostList(meetingItem: widget.meetingItem,),
      MeetingPage_Gallery(meetingItem: widget.meetingItem,),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.meetingItem.title,
          style: appBarTitleTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsForApp.black,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: ColorsForApp.appBarColor,
        actions: [
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              ColorsForApp.black,
              BlendMode.srcIn,
            ),
            child: PopupMenuButton(
              itemBuilder: (context) => casePopupMenuList(),
              enabled: widget.meetingState == MeetingStateTag.joined,
              onSelected: (choice) => choiceAction(choice, context),
            ),
          )
        ],
      ),
      body: Container(
        // color: ColorsForApp.colorForFishing,
        child: Column(
          children: [
            /// top navi
            Container(
              height: _device_height * 0.068,
              width: _device_width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: SizedBox(
                      width: _device_width/3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: _device_height * 0.063,
                            child: Center(
                              child: Text(
                                  "모임홈",
                                  style: TextStyle(
                                      color: widget.meetingState==MeetingStateTag.joined?ColorsForApp.black:ColorsForApp.inactiveColor),
                                  textAlign: TextAlign.center ),),),
                          Visibility(visible: _selectedPageIndex == 0,child: Container(height: _device_height * 0.005, width: _device_width/3,color:const Color(0xff2e2c76)),),
                        ],
                      ),
                    ),
                    onTap: (){
                      if(widget.meetingState == MeetingStateTag.joined){
                        setState((){
                          {
                            _selectedPageIndex = 0;
                          }
                        });
                      }
                      else{
                        appToast('모임 가입자만 열람 가능합니다!');
                      }
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: _device_width/3,
                      child: Column(
                        children: [
                          Container(
                            height: _device_height * 0.063,
                            child: Center(
                              child: Text("게시판", style: TextStyle(color: widget.meetingState==MeetingStateTag.joined?ColorsForApp.black:ColorsForApp.inactiveColor),
                                  textAlign: TextAlign.center ),
                            ),
                          ),
                          Visibility(child: Container(height: _device_height * 0.005, width: _device_width/3,color:const Color(0xff2e2c76)),visible: _selectedPageIndex == 1,),
                        ],
                      ),
                    ),
                    onTap: (){
                      if(widget.meetingState == MeetingStateTag.joined){
                        setState((){
                          {
                            _selectedPageIndex = 1;
                          }
                        });
                      }
                      else{
                        appToast('모임 가입자만 열람 가능합니다!');
                      }
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: _device_width/3,
                      child: Column(
                        children: [
                          Container(
                            height: _device_height * 0.063,
                            child: Center(
                              child: Text(
                                  "사진첩",
                                  style: TextStyle(color: widget.meetingState==MeetingStateTag.joined?ColorsForApp.black:ColorsForApp.inactiveColor),
                                  textAlign: TextAlign.center ),),),
                          Visibility(child: Container(height: _device_height * 0.005, width: _device_width/3,color:const Color(0xff2e2c76)),visible: _selectedPageIndex == 2,),
                        ],
                      ),
                    ),
                    onTap: (){
                      if(widget.meetingState == MeetingStateTag.joined){
                        setState((){
                          {
                            _selectedPageIndex = 2;
                          }
                        });
                      }
                      else{
                        appToast('모임 가입자만 열람 가능합니다!');
                      }
                    },
                  )
                ],
              ),
            ),

            /// page
            Flexible(
              flex: 1,
              child: IndexedStack(
                index: _selectedPageIndex,
                children: _pageList,
              ),
            )
          ],
        ),
      ),

      /// 가입됐는지 보는 바
      bottomNavigationBar: Visibility(
        visible: widget.meetingState != MeetingStateTag.joined,
        child: Container(
          width: _device_width,
          height: _device_height * 0.1,
          color: ColorsForApp.white,
          child: Center(
            child: meetingStateBottom(context, widget.meetingState),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: (metaMyProfileItem.uid == widget.meetingItem.onerUid && _selectedPageIndex == 0) || _selectedPageIndex == 1,
        child: FloatingActionButton(
            onPressed: (){
              if(metaMyProfileItem.uid == widget.meetingItem.onerUid && _selectedPageIndex == 0){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>MakeNoticePage(meetingItem: widget.meetingItem,)));
              }
              if(_selectedPageIndex == 1){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>MakePost(meetingItem: widget.meetingItem,)));
              }
            },
            // backgroundColor: const Color(0xff2E2C76),
            child: const ImageIcon(
              AssetImage("images/icon_add_post.png"),
              color: ColorsForApp.white,
              size: 24,
            )
        ),
      ),
    );
  }


  /// 신청 상태 채크
  Widget meetingStateBottom(BuildContext context, String _meetingState){
    /// 첫  방문
    if(_meetingState == MeetingStateTag.nothing){
      return InkWell(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => MeetingApplyPage(meetingItem: widget.meetingItem))
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.364,
          height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.065,
          decoration: const BoxDecoration(
            color: ColorsForApp.meetingStateNoting,
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
          ),
          child: const Center(
            child: Text(
                "모임 가입하기",
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                    fontFamily: "NotoSansKR",
                    fontStyle:  FontStyle.normal,
                    fontSize: 20.0
                ),
                textAlign: TextAlign.center
            ),
          ),
        ),
      );
    }
    /// 신청상태
    else if(_meetingState == MeetingStateTag.subscription){
      return Container(
        width: MediaQuery.of(context).size.width * 0.364,
        height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.065,
        decoration: const BoxDecoration(
          color: ColorsForApp.meetingStateSubscription,
          borderRadius: BorderRadius.all(
              Radius.circular(5)
          ),
        ),
        child: const Center(
          child: Text(
              "신청됨",
              style: TextStyle(
                  color:  Color(0xffffffff),
                  fontWeight: FontWeight.w500,
                  fontFamily: "NotoSansKR",
                  fontStyle:  FontStyle.normal,
                  fontSize: 20.0
              ),
              textAlign: TextAlign.center
          ),
        ),
      );
    }
    /// 가입상태
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.364,
      height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.065
    );
  }
}