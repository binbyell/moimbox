import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassComment.dart';
import 'package:moimbox/class/ClassMeeting_Post.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/view/ProfileImageAndNickNameFromUID.dart';

class CommentWidgetPost extends StatefulWidget {
  CommentItem commentItem;
  PostItem postItem;
  String meetingId;

  CommentWidgetPost({Key? key, required this.commentItem, required this.postItem, required this.meetingId}): super(key: key);

  @override
  _tempPage createState() => _tempPage();
}

class _tempPage extends State<CommentWidgetPost> {
  bool visibleTemp = true;
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visibleTemp,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.034),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [

                        /// 프로필 이미지, 닉네임
                        Container(
                          height: MediaQuery.of(context).size.height * 0.053,
                          width: MediaQuery.of(context).size.width * 0.29,
                          child: ProfileImageAndNickNameFromUID(uid: widget.commentItem.onerUid,),
                        ),
                        /// 시간
                        Text(
                          dateFormat.format(widget.commentItem.time!),
                          style: appTextGray(14),
                        ),
                      ],
                    ),
                    PopupMenuButton(
                        itemBuilder: (context){
                          if(widget.commentItem.onerUid == metaMyProfileItem.uid){
                            return [
                              PopupMenuItem(
                                child: Text(
                                  "수정",
                                  style: TextStyle(
                                      color: ColorsForApp.inactiveColor
                                  ),
                                ),
                                value: 1,
                                onTap: (){

                                },
                              ),
                              PopupMenuItem(
                                child: Text("삭제"),
                                value: 2,
                                onTap: (){
                                  print("widget.postItem.commentList : ${widget.postItem.commentList}");
                                  widget.postItem.commentList.remove(
                                      widget.postItem.commentList.where((element) => element['TIME'] == widget.commentItem.time && element['ONER_UID'] == widget.commentItem.onerUid).first
                                  );
                                  setState((){
                                    visibleTemp = false;
                                  });
                                  print("widget.postItem.commentList : ${widget.postItem.commentList}");
                                  updateCOMMENTPost(widget.postItem, widget.meetingId);
                                },
                              )
                            ];
                          }
                          return [
                            PopupMenuItem(
                              child: Text(
                                "신고",
                                style: TextStyle(
                                    color: ColorsForApp.inactiveColor
                                ),
                              ),
                              value: 1,
                              onTap: (){

                              },
                            ),
                          ];
                        }
                    )
                  ],
                ),
              ),
              /// 댓글 내용
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.18,
                  ),
                  /// 댓글 내용
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child:
                      Text(
                          widget.commentItem.contents,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          )
                      )
                  ),
                ],
              ),
              Container(
                  margin:EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  decoration: const BoxDecoration(
                      color: Color(0xffeeeeee)
                  )
              )
            ],
          ),
        )
    );
  }
}