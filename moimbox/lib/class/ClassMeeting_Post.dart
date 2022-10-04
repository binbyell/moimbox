
class PostItem{
  DateTime? time;
  String? id;
  String onerUid;
  String onerNick;
  String title;
  String contents;
  List<dynamic> imageUrlList;
  List<dynamic> thumbsUpList;
  List<dynamic> commentList;

  PostItem({
    this.time,
    this.id = "",
    this.onerUid = "t66AeFwljWdaUhSsTFkVBML7Hkx2",
    this.onerNick = "",
    this.title = "title",
    this.contents = "CONTENTES",
    this.imageUrlList = const [],
    this.thumbsUpList = const [],
    this.commentList = const [],
  });
}
