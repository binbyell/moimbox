import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMyProfile.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/page/InterestPage.dart';
import 'package:moimbox/tempP.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfilePreview extends StatefulWidget {

  MyProfileItem myProfileItem;
  MyProfilePreview ({ Key? key, required this.myProfileItem }): super(key: key);

  @override
  _myProfilePreview createState() => _myProfilePreview();
}

class _myProfilePreview extends State<MyProfilePreview> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    double _this_width = _device_width * 0.923;
    double _this_height = _device_height * 0.219;

    ScreenUtil.init(context, designSize: Size(_device_width ,_device_height)); //, allowFontScaling: false

    return Container(
      width: _device_width * 0.923,
      height: _device_height * 0.219,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(10)
          ),
          border: Border.all(
              color: const Color(0xffc8c8c8),
              width: 1
          ),
          color: const Color(0xffffffff)
      ),
      child: Stack(children: [
        /// widget.myProfileItem.nickname (widget.myProfileItem.name)
        PositionedDirectional(
          top: _this_height * 0.099,
          start: _this_width * 0.348,
          child:
          Text(
              "${widget.myProfileItem.nickname} (${widget.myProfileItem.name})",
              style: const TextStyle(
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700,
                  fontFamily: "NotoSansKR",
                  fontStyle:  FontStyle.normal,
                  fontSize: 16.0
              ),
              textAlign: TextAlign.center
          ),
        ),
        // 내 관심 주제
        PositionedDirectional(
            top: _this_height * 0.754,
            start: _this_width * 0.042,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: ScreenUtil().setSp(14)
                      ),
                      text: "내 관심 주제",
                    )
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 31,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for(String interest in widget.myProfileItem.interest)
                            filterItem(interest, _this_width, _this_height)
                        ],
                      ),
                    )
                )
              ],
            )
        ),
        /// widget.myProfileItem.introduce
        PositionedDirectional(
          top: _this_height * 0.292,
          start: _this_width * 0.348,
          child:
          Text(
              widget.myProfileItem.introduce,
              style: const TextStyle(
                  color: Color(0xffacacac),
                  fontWeight: FontWeight.w400,
                  fontFamily: "NotoSansKR",
                  fontStyle:  FontStyle.normal,
                  fontSize: 14.0
              ),
              textAlign: TextAlign.left
          ),
        ),
        /// Line
        PositionedDirectional(
          top: _this_height * 0.671,
          start: 0,
          child:
          Container(
              width: _this_width,
              height: 1,
              decoration: const BoxDecoration(
                  color: Color(0xffeeeeee)
              )
          ),
        ),
        /// widget.myProfileItem.image
        PositionedDirectional(
          top: _this_height * 0.05,
          start: _this_width * 0.042,
          child:
          SizedBox(
            height: _this_height * 0.528,
            width: _this_height * 0.528,
            child: ClipOval(
                child:widget.myProfileItem.profileImageUrl.isEmpty?
                Image.asset("images/profileImageNull.png", fit: BoxFit.fill,):
                Image.network(widget.myProfileItem.profileImageUrl, fit: BoxFit.fill,)
            ),
          ),
        ),
        /// 관심사 변경
        PositionedDirectional(
          top: _this_height * 0.727,
          start: _this_width * 0.762,
          child:InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>InterestPage(needAppBar: true,)));
            },
            child: Container(
              width: _this_width * 0.196,
              height: _this_height * 0.224,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(5)
                  ),
                  border: Border.all(
                      color: const Color(0xffc8c8c8),
                      width: 1
                  ),
                  color: const Color(0xffffffff)
              ),
              child: Center(
                child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: 12.0
                      ),
                      text: "관심사 변경",
                    )
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

Container filterItem(String interest, double thisWidth, double thisHeight){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 3),
    child: Container(
      width: thisWidth * 0.141,
      height: thisHeight * 0.192,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(10)
          ),
          color: getTagColor(interest),
          border: Border.all(
              color: getTagColor(interest),
              width: 1
          )
      ),
      child: Center(
        child: RichText(
            text: TextSpan(
              style: TextStyle(
                  color: ColorsForApp.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: "NotoSansKR",
                  fontStyle:  FontStyle.normal,
                  fontSize: ScreenUtil().setSp(14)
              ),
              text: interest,
            )
        ),
        // child: Text(
        //     interest,
        //     style: const TextStyle(
        //         color: ColorsForApp.white,
        //         fontWeight: FontWeight.w400,
        //         fontFamily: "NotoSansKR",
        //         fontStyle:  FontStyle.normal,
        //         fontSize: 14.0
        //     ),
        //     textAlign: TextAlign.center
        // ),
      ),
    ),
  );
}