
//radius
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("yyyy.MM.dd HH:mm");

class ColorsForApp{
  ColorsForApp._();
  static const Color appBarColor = Color(0xffffffff);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color textFieldBack = Color(0xffF1F1F1);
  static const Color bolder = Color(0xffc4c4c4);
  static const Color buttonTextColor = Color(0xff696969);
  static const Color hintTextColor = Color(0xffc3c3c3);
  static const Color narrationText = Color(0xff797979);
  static const Color selectedItemColor = Color(0xff1F78E1);

  static const Color meetingStateNoting = Color(0xff2E2C76);
  static const Color meetingStateSubscription = Color(0xff797979);

  static const Color colorForFishing = Color(0xff1363ac);
  static const Color colorForGolf = Color(0xff2FBE22);
  static const Color colorForClimbing = Color(0xffA95C43);
  static const Color colorForBilliards = Color(0xff000000);
  static const Color colorForSurfing = Color(0xff108888);
  static const Color colorForBowling = Color(0xff6B1ABB);

  static const Color colorForDisabled = Color(0xffACACAC);

  static const Color inactiveColor = Color(0xffC4C4C4);//C4C4C4
  static const Color activeColorForActionButton = Color(0xff1F78E1);
  static const Color activeColor = Color(0xFF898989);
}

List<BottomNavigationBarItem>  bottomNavigationBarIconList = [
  const BottomNavigationBarItem(
    icon: Icon(
        Icons.home,
    ),
    label: '홈',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.notifications_active),
    label: '알림',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.people),
    label: '내 모임',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: '프로필',
  ),
];

class MeetingItemTag {
  MeetingItemTag._();

  static const String fishing = "낚시";
  static const String golf = "골프";
  static const String climbing = "등산";
  static const String billiards = "당구";
  static const String surfing = "서핑";
  static const String bowling = "볼링";
}

class MeetingFrequencyTag {
  MeetingFrequencyTag._();

  static const String onceWeek = "1주일";
  static const String onceMonth = "1주일";
  static const String onceQuarter = "1분기";
}

List<String> MeetingTagList = const [MeetingItemTag.fishing, MeetingItemTag.golf, MeetingItemTag.climbing, MeetingItemTag.billiards, MeetingItemTag.surfing, MeetingItemTag.bowling];

BoxDecoration appLineDecoration = const BoxDecoration(color: Color(0xffeeeeee));

TextStyle appTextStyle(double fontSize){
  return TextStyle(
      color: const Color(0xff000000),
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle:  FontStyle.normal,
      fontSize: fontSize);
}

TextStyle appTextGray(double fontSize){
  return TextStyle(
      color: const Color(0xff797979),
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle:  FontStyle.normal,
      fontSize: fontSize
  );
}

TextStyle appBarTitleTextStyle = const TextStyle(
    color: ColorsForApp.black
);

BoxDecoration appButtonDecoration = BoxDecoration(
  borderRadius: const BorderRadius.all(
    Radius.circular(5),
  ),
  border: Border.all(
      color: const Color(0xffc4c4c4),
      width: 1
  ),
);

BoxDecoration appTextBoxDecoration = BoxDecoration(
  color: ColorsForApp.textFieldBack,
  borderRadius:  BorderRadius.circular(5),
);