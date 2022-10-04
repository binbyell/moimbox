

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/class/ClassMeeting_Post.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MakePost extends StatefulWidget {
  MeetingItem meetingItem;

  MakePost({Key? key, required this.meetingItem}): super(key: key);

  @override
  _MakePostState createState() => _MakePostState();
}

class _MakePostState extends State<MakePost> {

  int countImage = 0;
  String title = "";
  String content = "";

  List<File> imageFileList = [];
  List<Widget> imageViewList = [];
  List<dynamic> imageUrlList = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    ScreenUtil.init(context, designSize: Size(_device_width ,_device_height));

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("게시글 작성", style: appBarTitleTextStyle,),
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
              "완료",
              style: TextStyle(
                  color: (title.isNotEmpty && content.isNotEmpty)?ColorsForApp.activeColor:ColorsForApp.inactiveColor
              ),
            ),
            onPressed: (){
              print("imageUrlList : $imageUrlList");
              if(title.isEmpty){
                appToast("게시물 제목이 비어 있습니다.");
              }
              else if(content.isEmpty){
                appToast("게시물 내용이 비어 있습니다.");
              }
              else if(title.isNotEmpty && content.isNotEmpty){
                PostItem temp = PostItem(
                  time: DateTime.now(),
                  onerNick: metaMyProfileItem.nickname,
                  onerUid: metaMyProfileItem.uid!,
                  title: title,
                  contents: content,
                  imageUrlList: imageUrlList,
                );
                addMeetingPost(temp, widget.meetingItem.id!);

                imageUrlList = [];
                Navigator.pop(context);
                /// do something
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(_device_width * 0.057, _device_width * 0.057, _device_width * 0.057, _device_width * 0.057),
                      child: GridView(
                        physics: const ScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            width: _device_width * 0.20,
                            height: _device_width * 0.20,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(6)
                                ),
                                color: Color(0xffF1F1F1)
                            ),
                            child: TextButton(
                              onPressed: (){
                                if(imageFileList.length < 5){
                                  getImage().then((value) {
                                    sendImageToMeetingPostStorageMk2(value, widget.meetingItem.id!, imageFileList.length).then((value){
                                      imageUrlList.add(value);
                                      print("imageUrlList : $imageUrlList");
                                    });
                                    imageFileList.add(value);
                                    setState((){
                                      imageViewList.add(
                                          Container(
                                            width: _device_width * 0.20,
                                            height: _device_width * 0.20,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)
                                                ),
                                                color: Color(0xffF1F1F1)
                                            ),
                                            child: Image.file(value,fit: BoxFit.fitHeight,),
                                          )
                                      );
                                    });
                                  });
                                }
                                else{
                                  appToast("더 이상 이미지를 추가할 수 없습니다.");
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add_a_photo,
                                    color: ColorsForApp.inactiveColor,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontSize: ScreenUtil().setSp(12)
                                        ),
                                        text: "${imageFileList.length}/5",
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          for(Widget view in imageViewList)
                            view
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: Color(0xFFEEEEEE),
              ),
              /// 제목
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: TextFormField(
                      onChanged: (text){
                        title = text;
                        print("title : $title");
                      },
                      onFieldSubmitted:(text){
                        title = text;
                        print("title : $title");
                      },
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: '제목을 입력해주세요.',
                        hintStyle: TextStyle(
                          color: Color(0xFFC3C3C3),
                          fontSize: 17,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: Color(0xFFEEEEEE),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 24),
                child: TextFormField(
                  onChanged: (text){
                    content = text;
                    print("title : $content");
                  },
                  onFieldSubmitted:(text){
                    content = text;
                    print("title : $content");
                  },
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: '내용을 입력해주세요.',
                    hintStyle: TextStyle(
                      color: Color(0xFFC3C3C3),
                      fontSize: 15,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}