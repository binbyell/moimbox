
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassAlarm.dart';
import 'package:moimbox/class/ClassComment.dart';
import 'package:moimbox/class/ClassMeeting_Post.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/view/CommentWidget.dart';
import 'package:moimbox/view/CommentWidgetPost.dart';
import 'package:moimbox/view/ProfileImageAndNickNameFromUID.dart';

class PostPage extends StatefulWidget {

  PostItem postItem;
  String meetingId;

  PostPage({Key? key, required this.postItem, required this.meetingId}): super(key: key);

  @override
  _postPage createState() => _postPage();
}

class _postPage extends State<PostPage> {

  final TextEditingController _commentController = new TextEditingController();

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
          title: Text("게시글", style: appBarTitleTextStyle,),
          backgroundColor: ColorsForApp.appBarColor,
          actions: [
            Visibility(
              visible: widget.postItem.onerUid == metaMyProfileItem.uid,
              child:ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  ColorsForApp.black,
                  BlendMode.srcIn,
                ),
                child: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("게시글 수정", style: TextStyle(color: ColorsForApp.inactiveColor),),
                        value: 1,
                        onTap: (){print("FirstFirstFirst");},
                      ),
                      PopupMenuItem(
                        child: Text("게시글 삭제"),
                        value: 2,
                      )
                    ],
                  onSelected: (choice){
                    switch(choice.toString()){
                      case '1':
                        break;
                      case '2':
                        FlutterDialogSimple(
                            context: context,
                            headText: '정말 삭제하시겠습니까?',
                            noText: '게시글 삭제하지 않기',
                            yesText: '게시글 삭제하기',
                            onTapYes: (){
                              FirebaseFirestore.instance.collection("Meeting").doc(widget.meetingId).collection("Post").doc(widget.postItem.id).delete();
                              FirebaseFirestore.instance.collection("Account").doc(metaMyProfileItem.uid).collection('Post').doc(widget.postItem.id).delete();
                              Navigator.of(context).pop();
                            },
                            onTapNo: (){
                              // Navigator.of(context).pop();
                            }
                        );
                        break;
                    }
                  },
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
                                widget.postItem.title,
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
                                child: ProfileImageAndNickNameFromUID(uid: widget.postItem.onerUid,),
                              ),
                              /// time
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                    dateFormat.format(widget.postItem.time!),
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
                          widget.postItem.imageUrlList.isNotEmpty
                              ?CarouselSlider(
                            options: CarouselOptions(
                                aspectRatio: 16/9,
                                height: MediaQuery.of(context).size.width * 9/16,
                              enableInfiniteScroll: false
                            ),
                            items: widget.postItem.imageUrlList.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 230,
                                      margin: const EdgeInsets.all(5.0),
                                      child: Image.network(i, fit: BoxFit.fill,)
                                  );
                                },
                              );
                            }).toList(),
                          )
                              :Container(),
                          /// contents
                          Container(
                            margin: const EdgeInsets.all(24),
                            child: Text(widget.postItem.contents),
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
                                  print("widget.noticeItem.thumbsUpList : ${widget.postItem.thumbsUpList}");
                                  print("metaMyProfileItem.uid! : ${metaMyProfileItem.uid!}");
                                  if(widget.postItem.thumbsUpList.where((element) => element == metaMyProfileItem.uid!).isEmpty)
                                  {
                                    setState((){
                                      widget.postItem.thumbsUpList = widget.postItem.thumbsUpList + [metaMyProfileItem.uid!];
                                    });
                                    updateThumbsUpPost(widget.postItem, widget.meetingId);
                                  }
                                  else{
                                    appToast("이미 추천을 누르셨습니다.");
                                  }

                                  /// alarm
                                  if(widget.postItem.onerUid != metaMyProfileItem.uid){
                                    AlarmItem alarmItem = AlarmItem(
                                      type: AlarmTag.like,
                                      pageType: AlarmPageTag.post,
                                      time: DateTime.now(),
                                      contents: _commentController.text,
                                      meetingId: widget.meetingId,
                                      nick: metaMyProfileItem.nickname,
                                      postId: widget.postItem.id!,
                                    );
                                    setAlarm(alarmItem, widget.postItem.onerUid);
                                  }
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.thumb_up,
                                        color: widget.postItem.thumbsUpList.where((element) => element == metaMyProfileItem.uid!).isEmpty
                                            ?ColorsForApp.inactiveColor
                                            :const Color(0xff2E2C76),
                                      ),
                                      SizedBox(width: 8,),
                                      Text(widget.postItem.thumbsUpList.length.toString())
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
                                  Text(widget.postItem.commentList.length.toString())
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
                    for(Map commentMap in widget.postItem.commentList)
                      CommentWidgetPost(commentItem: getCommentItemFromMap(commentMap), postItem: widget.postItem, meetingId: widget.meetingId,)
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 62,
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
                        setComment(_commentController);
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
    if(widget.postItem.onerUid != metaMyProfileItem.uid){
      AlarmItem alarmItem = AlarmItem(
        type: AlarmTag.comment,
        pageType: AlarmPageTag.post,
        time: DateTime.now(),
        contents: _commentController.text,
        meetingId: widget.meetingId,
        nick: metaMyProfileItem.nickname,
        postId: widget.postItem.id!,
      );
      setAlarm(alarmItem, widget.postItem.onerUid);
    }

    CommentItem commentItem = CommentItem(onerUid: metaMyProfileItem.uid!, contents: _commentController.text, time: DateTime.now());
    setState((){
      widget.postItem.commentList = widget.postItem.commentList + [commentItem.toCommentMap()];
      _commentController.text = "";
    });
    updateCOMMENTPost(widget.postItem, widget.meetingId);
    // addMeetingNotice(widget.noticeItem, widget.meetingId);
  }
}