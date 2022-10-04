
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassAlarm.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';

class AlarmPreview extends StatefulWidget {

  final AlarmItem alarmItem;
  const AlarmPreview ({ Key? key, required this.alarmItem,}): super(key: key);

  @override
  _alarmPreview createState() => _alarmPreview();
}

class _alarmPreview extends State<AlarmPreview> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;

    double _device_height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    double _this_width = _device_width;
    double _this_height = _device_height * 0.119;

    return InkWell(
      onTap: (){
        switch(widget.alarmItem.pageType){
          case AlarmPageTag.meeting:
            widget.alarmItem.openMeetingPage(context);
            break;
          case AlarmPageTag.post:
            widget.alarmItem.openPostPage(context);
            break;
          case AlarmPageTag.notice:
            widget.alarmItem.openNoticePage(context);
            break;
          default: break;
        }
      },//widget.onTap,
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
                        text: widget.alarmItem.getTitle(),
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
                        text: widget.alarmItem.contents,
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
                  text: dateFormat.format(widget.alarmItem.time),
                )
            ),
          ),
        ]),
      ),
    );
  }
}