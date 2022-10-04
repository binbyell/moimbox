
class MeetingApplyItem{
  String onerUid;
  String onerNick;
  DateTime? time;
  String contents;

  MeetingApplyItem({
    this.onerUid = "t66AeFwljWdaUhSsTFkVBML7Hkx2",
    required this.onerNick,
    this.time,
    this.contents = "확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인 줄바꿈 확인",
  });

  Map toApplyMap(){
    return {
      "ONER_UID" : onerUid,
      "ONER_NICK" : onerNick,
      "TIME" : time,
      "CONTENT" : contents
    };
  }
}

MeetingApplyItem getApplyItemFromMap(Map applyMap){
  if(applyMap['TIME'].runtimeType == DateTime){
    return MeetingApplyItem(
      onerUid: applyMap['ONER_UID'],
      onerNick: applyMap['ONER_NICK'],
      time: applyMap['TIME'],
      contents: applyMap['CONTENT'],
    );
  }
  else{
    return MeetingApplyItem(
      onerUid: applyMap['ONER_UID'],
      onerNick: applyMap['ONER_NICK'],
      time: DateTime.parse(applyMap['TIME'].toDate().toString()),
      contents: applyMap['CONTENT'],
    );
  }
}