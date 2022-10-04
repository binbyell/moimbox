
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassAlarm.dart';
import 'package:moimbox/class/ClassComment.dart';
import 'package:moimbox/class/ClassMeeting_Notice.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/view/CommentWidget.dart';
import 'package:moimbox/view/ProfileImageAndNickNameFromUID.dart';

class NoticePage extends StatefulWidget {

  NoticeItem noticeItem;
  String meetingId;

  NoticePage({Key? key, required this.noticeItem, required this.meetingId}): super(key: key);

  @override
  _noticePage createState() => _noticePage();
}

class _noticePage extends State<NoticePage> {

  final TextEditingController _commentController = new TextEditingController();

  /// Dialog 버튼 있는 토스트 toast
  void flutterDialog(BuildContext context) {
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
                Text("정말 회원탈퇴 하시겠습니까?"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  "회원탈퇴 하게 된다면, 내가 가입된 모임에서 탈퇴처리 됩니다. 또한, 내가 쓴 게시글은 모두 삭제되며, 내가 개설한 모임 역시 삭제됩니다. 구독중인 프리미엄권은 자동으로 취소되지만, 환불은 되지 않습니다.",
                ),
              ],
            ),
            actions: <Widget>[
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      /// 탈퇴 하지않기
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
                              "탈퇴 하지않기",
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
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: 262,
                          height: 56,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50)
                              ),
                              color: Color(0xffff0000)
                          ),
                          child: const Center(
                            child: Text(
                                "탈퇴 하기",
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

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

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
          title: Text("공지사항", style: appBarTitleTextStyle,),
          backgroundColor: ColorsForApp.appBarColor,
          actions: [
            Visibility(
              visible: widget.noticeItem.onerUid == metaMyProfileItem.uid,
                child:ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    ColorsForApp.black,
                    BlendMode.srcIn,
                  ),
                  child: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("공지 수정"),
                          value: 1,
                          onTap: (){print("FirstFirstFirst");},
                        ),
                        PopupMenuItem(
                          child: Text("공지 삭제"),
                          value: 2,
                          onTap: (){
                            FlutterDialogSimple(
                                context: context,
                                headText: '정말 삭제하시겠습니까?',
                                noText: '공지 삭제 하지않기',
                                yesText: '공지 삭제 하기',
                                onTapYes: (){
                                  FirebaseFirestore.instance.collection("Meeting").doc(widget.meetingId).collection("Notice").doc(widget.noticeItem.id).delete();
                                  FirebaseFirestore.instance.collection("Account").doc(metaMyProfileItem.uid).collection('Post').doc(widget.noticeItem.id).delete();
                                  Navigator.of(context).pop();
                                },
                                onTapNo: (){}
                            );
                            },
                        )
                      ]
                  ),
                ),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child:SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: _device_width,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// title
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 13),
                            child: Text(
                                widget.noticeItem.title,
                                style: const TextStyle(
                                    color:  Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "NotoSansKR",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 22.0
                                ),
                                textAlign: TextAlign.left
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// 프로필 이미지, 닉네임
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.053,
                                width: MediaQuery.of(context).size.width * 0.29,
                                child: ProfileImageAndNickNameFromUID(uid: widget.noticeItem.onerUid,),
                              ),
                              /// time
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                    dateFormat.format(widget.noticeItem.time!),
                                    style: const TextStyle(
                                        color:  Color(0xff797979),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "NotoSansKR",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 14.0
                                    ),
                                    textAlign: TextAlign.right
                                ),
                              ),
                            ],
                          ),
                          /// contents
                          Container(
                            margin: const EdgeInsets.all(24),
                            child: Text(widget.noticeItem.contents),
                          ),
                        ],
                      ),
                    ),
                    /// line
                    Container(
                        width: _device_width,
                        height: 1,
                        decoration: const BoxDecoration(
                            color: Color(0xffeeeeee)
                        )
                    ),
                    Container(
                      width: _device_width,
                      child: Row(
                        children: [
                          /// thumbs up
                          Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: (){
                                  print("widget.noticeItem.thumbsUpList : ${widget.noticeItem.thumbsUpList}");
                                  print("metaMyProfileItem.uid! : ${metaMyProfileItem.uid!}");
                                  if(widget.noticeItem.thumbsUpList.where((element) => element == metaMyProfileItem.uid!).isEmpty)
                                  {
                                    setState((){
                                      widget.noticeItem.thumbsUpList = widget.noticeItem.thumbsUpList + [metaMyProfileItem.uid!];
                                    });
                                    updateThumbsUp(widget.noticeItem, widget.meetingId);
                                  }
                                  else{
                                    appToast("이미 추천을 누르셨습니다.");
                                  }
                                  /// alarm
                                  if(widget.noticeItem.onerUid != metaMyProfileItem.uid){
                                    AlarmItem alarmItem = AlarmItem(
                                      type: AlarmTag.like,
                                      pageType: AlarmPageTag.notice,
                                      time: DateTime.now(),
                                      contents: _commentController.text,
                                      meetingId: widget.meetingId,
                                      nick: metaMyProfileItem.nickname,
                                      noticeId: widget.noticeItem.id!,
                                    );
                                    setAlarm(alarmItem, widget.noticeItem.onerUid);
                                  }
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.thumb_up,
                                        color: widget.noticeItem.thumbsUpList.where((element) => element == metaMyProfileItem.uid!).isEmpty
                                            ?ColorsForApp.inactiveColor
                                            :const Color(0xff2E2C76),
                                      ),
                                      SizedBox(width: 8,),
                                      Text(widget.noticeItem.thumbsUpList.length.toString())
                                    ],
                                  ),
                                ),
                              )),
                          /// line
                          Container(
                              width: 1,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Color(0xffeeeeee)
                              )
                          ),
                          /// comment
                          Flexible(
                            flex: 1,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.comment, color: ColorsForApp.inactiveColor,),
                                  SizedBox(width: 8,),
                                  Text(widget.noticeItem.commentList.length.toString())
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    /// line
                    Container(
                        width: _device_width,
                        height: 1,
                        decoration: const BoxDecoration(
                            color: Color(0xffeeeeee)
                        )
                    ),
                    for(Map commentMap in widget.noticeItem.commentList)
                      CommentWidget(commentItem: getCommentItemFromMap(commentMap), noticeItem: widget.noticeItem, meetingId: widget.meetingId,)
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: _device_height * 0.084,
              decoration: BoxDecoration(
                color: ColorsForApp.textFieldBack,
                borderRadius:  BorderRadius.circular(5),
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _commentController,
                maxLength: 200,
                style: TextStyle(
                  fontSize: 15,
                ),
                onSubmitted: (String text){
                  setComment(_commentController);
                },
                decoration: InputDecoration(
                  // counterText: '',
                    contentPadding: EdgeInsets.fromLTRB(_device_width * 0.05, 24, 0, 0),
                    border: InputBorder.none,
                    hintText: "댓글을 남겨보세요!",
                    hintStyle: const TextStyle(
                        color: ColorsForApp.hintTextColor
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: (){
                        if(_commentController.text.isEmpty){
                          appToast("내용을 입력해 주세요");
                        }
                        else{
                          setComment(_commentController);
                        }
                        },
                    )
                ),
              ),
            ),
          ],
        )
    );
  }

  void setComment(TextEditingController commentController){
    /// alarm
    if(widget.noticeItem.onerUid != metaMyProfileItem.uid){
      AlarmItem alarmItem = AlarmItem(
        type: AlarmTag.comment,
        pageType: AlarmPageTag.notice,
        time: DateTime.now(),
        contents: _commentController.text,
        meetingId: widget.meetingId,
        nick: metaMyProfileItem.nickname,
        noticeId: widget.noticeItem.id!,
      );
      setAlarm(alarmItem, widget.noticeItem.onerUid);
    }

    print("_commentController : ${_commentController.text}");
    CommentItem commentItem = CommentItem(onerUid: metaMyProfileItem.uid!, contents: _commentController.text, time: DateTime.now());
    setState((){
      widget.noticeItem.commentList = widget.noticeItem.commentList + [commentItem.toCommentMap()];
      _commentController.text = "";
    });
    print(commentItem.toCommentMap());
    updateCOMMENT(widget.noticeItem, widget.meetingId);
    // addMeetingNotice(widget.noticeItem, widget.meetingId);
  }
}