import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/function/function.dart';

class MeetingItemPreview extends StatefulWidget {

  final MeetingItem testParameter;
  final GestureTapCallback onTap;
  const MeetingItemPreview ({ Key? key, required this.testParameter, required this.onTap }): super(key: key);

  @override
  _meetingItemPreview createState() => _meetingItemPreview();
}

class _meetingItemPreview extends State<MeetingItemPreview> {


  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    double _this_width = _device_width * 0.923;
    double _this_height = _device_height * 0.122;

    String imageUrl = widget.testParameter.titleImageUrl;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: _this_width,
        height: _this_height,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: ColorsForApp.white,
          border: Border.all(
              color: const Color(0xffc4c4c4),
              width: 1
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(5)
          ),
          boxShadow: [BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0,2),
              blurRadius: 4,
              spreadRadius: 0
          )] ,
        ),
        child: Stack(children: [
          /// MeetingItemPreviewItem.imageUrl
          PositionedDirectional(
            top: 0,
            start: 0,
            child:
            Container(
              width: _this_height,
              height: _this_height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(5)
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                child: Image.network(imageUrl, fit: BoxFit.fill,),
              ),
            ),
          ),
          /// MeetingItemPreviewItem.title
          PositionedDirectional(
              top: _this_height * 0.089,
              start: _this_width * 0.28,
              child:Text(
                  widget.testParameter.title,
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500,
                      fontFamily: "NotoSansKR",
                      fontStyle:  FontStyle.normal,
                      fontSize: 14.0
                  ),
                  textAlign: TextAlign.center
              )
          ),
          /// MeetingItemPreviewItem.location
          PositionedDirectional(
              top: _this_height * 0.4,
              start: _this_width * 0.28,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                  ),
                  Text(
                      widget.testParameter.location,
                      style: TextStyle(
                          color:  Color(0xff000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: 10.0
                      ),
                      textAlign: TextAlign.left
                  ),
                ],
              )
          ),
          /// MeetingItemPreviewItem.numberOfPeople
          PositionedDirectional(
              top: _this_height * 0.578,
              start: _this_width * 0.28,
              child: Row(
                children: [
                  const Icon(
                    Icons.people,
                    size: 14,
                  ),
                  Text(
                      widget.testParameter.peopleUidList.length.toString(),
                      style: const TextStyle(
                          color:  Color(0xff000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: 10.0
                      ),
                      textAlign: TextAlign.center
                  ),
                ],
              )
          ),
          /// MeetingItemPreviewItem.frequency
          PositionedDirectional(
              top: _this_height * 0.756,
              start: _this_width * 0.28,
              child:
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 14,
                  ),
                  Text(
                      widget.testParameter.frequency,
                      style: const TextStyle(
                          color:  Color(0xff000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: 10.0
                      ),
                      textAlign: TextAlign.left
                  ),
                ],
              )
          ),
          /// MeetingItemPreviewItem.tag
          PositionedDirectional(
            top: _this_height * 0.089,
            end: _this_width * 0.028,
            child: getMeetingItemTagWidget(widget.testParameter.meetingTag)
          ),

          /// MeetingItemPreviewItem.billFrequency
          /// MeetingItemPreviewItem.price
          PositionedDirectional(
              top: _this_height * 0.689,
              end: _this_width * 0.028,
              child:Row(
                children: [
                  Text(
                      widget.testParameter.billFrequency,
                      style: const TextStyle(
                          color:  const Color(0xff696969),
                          fontWeight: FontWeight.w500,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: 12.0
                      ),
                      textAlign: TextAlign.right
                  ),
                  SizedBox(width: _this_width * 0.025,),
                  Text(
                      "${widget.testParameter.price} 원",
                      style: const TextStyle(
                          color:  const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "NotoSansKR",
                          fontStyle:  FontStyle.normal,
                          fontSize: 14.0
                      ),
                      textAlign: TextAlign.right
                  ),
                ],
              )
          ),
        ]),
      ),
    );
  }
}