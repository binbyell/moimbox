import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeeting_Notice.dart';
import 'package:moimbox/data/data.dart';

class NoticePreview extends StatefulWidget {

  final NoticeItem noticeItem;
  final GestureTapCallback onTap;
  NoticePreview({Key? key, required this.noticeItem, required this.onTap}): super(key: key);

  @override
  _tempPage createState() => _tempPage();
}

class _tempPage extends State<NoticePreview> {

  @override
  Widget build(BuildContext context) {

    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    double _this_width = _device_width * 0.884;
    double _this_height = _device_height * 0.223;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        width: _this_width,
        height: _this_height,
        child: Stack(children: [
          // Rectangle back
          PositionedDirectional(
            top: 0,
            start: 0,
            child:
            Container(
                width: _this_width,
                height: _this_height,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(15)
                    ),
                    border: Border.all(
                        color: const Color(0xffe0e0e0),
                        width: 0.5
                    ),
                    boxShadow: const [BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0,4),
                        blurRadius: 4,
                        spreadRadius: 0
                    )] ,
                    color: const Color(0xfffcfcfc)
                ),
                child: Container(
                    margin: const EdgeInsets.all(16),
                    /// widget.noticeItem.title
                    /// widget.noticeItem.contents
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                widget.noticeItem.title,
                                style: const TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "NotoSansKR",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 18.0
                                ),
                                textAlign: TextAlign.left
                            ),
                          ],
                        ),
                        SizedBox(height: _this_height * 0.098,),
                        RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: WidgetSpan(
                            child: Text(
                              widget.noticeItem.contents,
                              style: const TextStyle(
                                color: Color(0xff505050),
                                fontWeight: FontWeight.w400,
                                fontFamily: "NotoSansKR",
                                fontStyle:  FontStyle.normal,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ),
                        )
                      ],
                    )
                )

            ),
          ),
          // Rectangle bottom
          PositionedDirectional(
            top: _this_height * 0.701,
            start: 0,
            child: Container(
                width: _this_width,
                height: _this_height * 0.299,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)
                    ),
                    border: Border.all(
                        color: const Color(0xffe0e0e0),
                        width: 0.5
                    ),
                    color: const Color(0xfff9f9fd)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: _this_width * 0.044,),
                        const Icon(
                          Icons.thumb_up,
                          color: ColorsForApp.inactiveColor,
                        ),
                        SizedBox(width: _this_width * 0.022,),
                        Text(widget.noticeItem.thumbsUpList.length.toString()),
                        SizedBox(width: _this_width * 0.044,),
                        const Icon(
                          Icons.comment,
                          color: ColorsForApp.inactiveColor,
                        ),
                        SizedBox(width: _this_width * 0.022,),
                        Text(widget.noticeItem.commentList.length.toString()),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: _this_width * 0.044),
                      child: Text(
                          dateFormat.format(widget.noticeItem.time!),
                          style: const TextStyle(
                              color: Color(0xff797979),
                              fontWeight: FontWeight.w500,
                              fontFamily: "NotoSansKR",
                              fontStyle:  FontStyle.normal,
                              fontSize: 14.0
                          ),
                          textAlign: TextAlign.left
                      ),
                    )
                  ],
                )
            ),
          ),
        ]),
      ),
    );
  }
}