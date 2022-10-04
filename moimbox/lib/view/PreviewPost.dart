import 'package:flutter/material.dart';
import 'package:moimbox/class/ClassMeeting_Notice.dart';
import 'package:moimbox/class/ClassMeeting_Post.dart';
import 'package:moimbox/data/data.dart';

class PostPreview extends StatefulWidget {

  final PostItem postItem;
  final GestureTapCallback onTap;
  PostPreview({Key? key, required this.postItem, required this.onTap}): super(key: key);

  @override
  _tempPage createState() => _tempPage();
}

class _tempPage extends State<PostPreview> {

  @override
  Widget build(BuildContext context) {

    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    double _this_width = _device_width * 0.923;
    double _this_height = _device_height * 0.158;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: _device_height * 0.01),
        width: _this_width,
        height: _this_height,
        child: Row(
          children: [
            Container(
              width: _this_height,
              height: _this_height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(15)
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(15)
                ),
                child: widget.postItem.imageUrlList.isNotEmpty
                    ?Image.network(widget.postItem.imageUrlList[0], fit: BoxFit.fill,)
                    :Image.asset("images/nullImagePost.png", fit: BoxFit.fill,),
              )
            ),
            SizedBox(
              width: _this_width * 0.063,
            ),
            Expanded(
                child: SizedBox(
                  height: _this_width * 0.592,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// title
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: WidgetSpan(
                                child: Text(
                                  widget.postItem.title,
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
                          ),
                          SizedBox(height: _this_height * 0.034,),
                          /// time
                          Text(
                              dateFormat.format(widget.postItem.time!),
                              style: const TextStyle(
                                  color: Color(0xff797979),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "NotoSansKR",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 14.0
                              ),
                              textAlign: TextAlign.left
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              widget.postItem.onerNick,
                            style: appTextGray(12),
                          ),
                          Row(
                            children: [
                              SizedBox(width: _this_width * 0.063,),
                              Icon(
                                Icons.thumb_up,
                                color: ColorsForApp.inactiveColor,
                              ),
                              SizedBox(width: _this_width * 0.03,),
                              Text(widget.postItem.thumbsUpList.length.toString()),
                              SizedBox(width: _this_width * 0.063,),
                              Icon(
                                Icons.comment,
                                color: ColorsForApp.inactiveColor,
                              ),
                              SizedBox(width: _this_width * 0.03,),
                              Text(widget.postItem.commentList.length.toString()),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}