
class NoticeItem{
  DateTime? time;
  String? id;
  String onerUid;
  String title;
  String contents;
  List<dynamic> thumbsUpList;
  List<dynamic> commentList;
  // CommentItem(onerUid: widget.noticeItem.onerUid)

  NoticeItem({
    this.time,
    this.id = "",
    this.onerUid = "t66AeFwljWdaUhSsTFkVBML7Hkx2",
    this.title = "title",
    this.contents = "CONTENTES",
    this.thumbsUpList = const [],
    this.commentList = const [],
  });
}
