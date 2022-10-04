
class CommentItem{
  String onerUid;
  DateTime? time;
  String contents;

  CommentItem({
    this.onerUid = "t66AeFwljWdaUhSsTFkVBML7Hkx2",
    this.time,
    this.contents = "댓글 내꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인",
  });

  Map toCommentMap(){
    return {
      "ONER_UID" : onerUid,
      "TIME" : time,
      "CONTENT" : contents
    };
  }
}

CommentItem getCommentItemFromMap(Map commentMap){
  if(commentMap['TIME'].runtimeType == DateTime){
    return CommentItem(
      onerUid: commentMap['ONER_UID'],
      time: commentMap['TIME'],
      contents: commentMap['CONTENT'],
    );
  }
  else{
    return CommentItem(
      onerUid: commentMap['ONER_UID'],
      time: DateTime.parse(commentMap['TIME'].toDate().toString()),
      contents: commentMap['CONTENT'],
    );
  }
}