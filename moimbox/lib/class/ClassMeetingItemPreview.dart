
import 'package:moimbox/class/ClassMeeting.dart';
import 'package:moimbox/class/ClassMeetingApply.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';

///       title               tag
/// url   location
///       Number of people
///       frequency           price


class MeetingItem{
  String? id;
  String onerUid;
  List<dynamic> peopleUidList;
  List<dynamic> peopleAppliedList;
  String title;
  String titleImageUrl;
  String meetingTag;
  List<dynamic> imageUrlList;
  String location;
  String frequency;
  String billFrequency;
  String price;
  String intro;

  MeetingItem({
    this.id = "",
    this.onerUid = "",
    this.peopleUidList = const [],
    this.peopleAppliedList = const [],
    this.title = "title",
    this.meetingTag = MeetingItemTag.surfing,
    this.titleImageUrl = "https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E",
    this.imageUrlList = const [
      "https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E",
      "https://sunstat.com/wp-content/uploads/2019/01/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C-%EB%B0%B0%EA%B2%BD%EC%9D%B4%EB%AF%B8%EC%A7%80.png",
      "https://www.urbanbrush.net/web/wp-content/uploads/edd/2020/02/urbanbrush-20200227023608426223.jpg"
    ],
    this.location = '부산시 / 해운대구',
    this.frequency = 'frequency',
    this.billFrequency = 'billFrequency',
    this.price = 'price',
    this.intro = 'intro',
  });

  String getMeetingState(){
    if(peopleUidList.where((element) => element == metaMyProfileItem.uid!).isNotEmpty){
      return MeetingStateTag.joined;
    }
    if(peopleAppliedList.where((element) => getApplyItemFromMap(element).onerUid == metaMyProfileItem.uid!).isNotEmpty){
      return MeetingStateTag.subscription;
    }
    return MeetingStateTag.nothing;
  }
}



