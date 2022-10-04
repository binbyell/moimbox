import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeetingApply.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/data/data.dart';

class MeetingApplyPreview extends StatefulWidget {

  final MeetingApplyItem meetingApplyItem;
  final GestureTapCallback onTap;
  const MeetingApplyPreview ({ Key? key, required this.meetingApplyItem, required this.onTap }): super(key: key);

  @override
  _applyPreview createState() => _applyPreview();
}

class _applyPreview extends State<MeetingApplyPreview> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;

    double _device_height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    double _this_width = _device_width;
    double _this_height = _device_height * 0.119;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: _this_width,
        height: _this_height,
        decoration: const BoxDecoration(
          color: ColorsForApp.white,
          border: Border(bottom: BorderSide(
              color: ColorsForApp.inactiveColor,
              width: 1
          ))
        ),
        child: Stack(children: [
          // (본인 닉)님께서 신청한 모임에서 신청을 수락했습니다.
          PositionedDirectional(
            top: _this_height * 0.182,
            start: _this_width * 0.039,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: 14.0
                      ),
                      text: "${widget.meetingApplyItem.onerNick}님께서\n회원님에게 모임 가입을 신청했습니다.",
                    )
                ),
                SizedBox(height: _this_height * 0.075,),
                RichText(
                  maxLines: 2,
                    text: TextSpan(
                      style: const TextStyle(
                          color: Color(0xff797979),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: 12.0
                      ),
                      text: widget.meetingApplyItem.contents,
                    )
                ),
              ],
            )
          ),
          PositionedDirectional(
              top: _this_height * 0.182,
              end: _this_width * 0.039,
              child: RichText(
                maxLines: 2,
                  text: TextSpan(
                    style: const TextStyle(
                        color: Color(0xff797979),
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSansKR",
                        fontStyle:  FontStyle.normal,
                        fontSize: 12.0
                    ),
                    text: dateFormat.format(widget.meetingApplyItem.time!),
                  )
              ),
          ),
        ]),
      ),
    );
  }
}