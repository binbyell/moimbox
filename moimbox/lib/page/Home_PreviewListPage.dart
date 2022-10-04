import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moimbox/class/ClassMeeting.dart';
import 'package:moimbox/class/ClassMeetingItemPreview.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/function/functionMeeting.dart';
import 'package:moimbox/page/MeetingPage.dart';
import 'package:moimbox/view/PreviewMeetingItem.dart';

import '../data/data_meta.dart';

class PreviewListPage extends StatefulWidget {

  const PreviewListPage({Key? key}): super(key: key);

  @override
  _previewListPage createState() => _previewListPage();
}

class _previewListPage extends State<PreviewListPage> {

  String _appbarBottomState = AppbarBottomState.nothing;
  String? _selectedFilter = null;

  AppBar? tempAppber(String _appbarBottomState){
    switch (_appbarBottomState) {
      case AppbarBottomState.search:
        return AppBar(
            backgroundColor: ColorsForApp.appBarColor,
            title: Container(
              width: double.infinity,
              height: 42,
              decoration: BoxDecoration(
                color: ColorsForApp.textFieldBack,
                borderRadius:  BorderRadius.circular(10),
              ),
              child: TextField(
                controller: TextEditingController(),
                keyboardType: TextInputType.name,
                maxLength: 8,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  border: InputBorder.none,
                  hintText: "이름을 입력해 주세요",
                  hintStyle: const TextStyle(
                    color: ColorsForApp.hintTextColor,
                    fontSize: 14,
                  ),
                  suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                ),
              ),
            )
        );
      case AppbarBottomState.filter:
        return AppBar(
          backgroundColor: ColorsForApp.appBarColor,
          title: Container(
            width: double.infinity,
            height: 42,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for(String meetingTagList in MeetingTagList)
                    filterItem(meetingTagList)
                ],
              ),
            )
          ),
        );
      default:
        return null;
    }
  }
  // margin: const EdgeInsets.symmetric(horizontal: 8),
  Container filterItem(String _filter){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        borderRadius: BorderRadius.all(
            Radius.circular(19)
        ),
        child: Container(
          width: 67,
          height: 39,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(19)
              ),
              color: _selectedFilter == _filter
                  ?getTagColor(_filter)
                  :ColorsForApp.white,
              border: Border.all(
                  color: _selectedFilter == _filter
                      ?getTagColor(_filter)
                      :Color(0xffeaebee),
                  width: 1
              )
          ),
          child: Center(
            child: Text(
                _filter,
                style: TextStyle(
                    color: _selectedFilter == _filter?ColorsForApp.white:const Color(0xff797979),
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansKR",
                    fontStyle:  FontStyle.normal,
                    fontSize: 14.0
                ),
                textAlign: TextAlign.center
            ),
          ),
        ),
        onTap: (){
          setState(() {
            if(_selectedFilter == _filter){
              _selectedFilter = null;
            }
            else{
              _selectedFilter = _filter;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// Appbar
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            backgroundColor: ColorsForApp.appBarColor,
            title: Text('모임박스', style: appBarTitleTextStyle,),
            actions: [
              // IconButton(
              //   icon: Icon(Icons.search),
              //   onPressed: (){
              //     setState(() {
              //       _appbarBottomState = AppbarBottomState.search;
              //     });
              //     },
              //   color: ColorsForApp.black,
              // ),
              IconButton(
                icon: Icon(Icons.filter_alt_outlined),
                onPressed: (){
                  if(_appbarBottomState == AppbarBottomState.filter){
                    setState(() {
                      _appbarBottomState = AppbarBottomState.nothing;
                    });
                  }
                  else{
                    setState(() {
                      _appbarBottomState = AppbarBottomState.filter;
                    });
                  }
                  },
                color: ColorsForApp.black,
              ),
            ],
            bottom: tempAppber(_appbarBottomState),
          ),
          // Other Sliver Widgets
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Meeting").where('LOCATION', isEqualTo: metaMyProfileItem.address).orderBy("DATE", descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
                if(snapshot.hasData == null){
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      const Text("없어요")
                    ],),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text("Loading");
                          }
                          if(snapshot.data == null){
                            return Text("Loading");
                          }
                          if(snapshot.data!.size == 0){
                            return Container(
                              height: 500,
                              child: Center(
                                child: Text("주변에 등록된 모임이 없어요"),
                              ),
                            );
                          }
                          return ListView(
                            shrinkWrap: true,
                            controller: ScrollController(),
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero ,
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map myOwnMeetingDoc = document.data() as Map;

                              return FutureBuilder(
                                  future: FirebaseFirestore.instance.collection("Meeting").doc(myOwnMeetingDoc['ID']).get(),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                                    if (snapshot.hasData == false) {
                                      return CircularProgressIndicator();
                                    }
                                    //error가 발생하게 될 경우 반환하게 되는 부분
                                    else if (snapshot.hasError) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Error: ${snapshot.error}',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      );
                                    }
                                    // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                                    else {
                                      print("snapshot.data : ${snapshot.data['PEOPLE_UID_LIST']}");

                                      MeetingItem previewItem = getMeetingItemFromSnapShot(snapshot);

                                      return Visibility(
                                          visible: (previewItem.meetingTag == _selectedFilter)||_selectedFilter == null,
                                          child: MeetingItemPreview(
                                        testParameter: previewItem,
                                        onTap: (){
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => MeetingPage(meetingState: previewItem.getMeetingState(), meetingItem: previewItem,))
                                          );
                                        },
                                      )
                                      );
                                    }
                                  }
                              );
                            }).toList(),
                          );
                          // return ListTile(title: Text(snapshot.data!.toString()));
                        },
                    childCount: snapshot.hasData ? 1 : 0,
                  )
                );
              }
          )
        ],
      ),
    );
  }
}

class AppbarBottomState {

  AppbarBottomState._();

  static const String search = "search";
  static const String filter = "filter";
  static const String nothing = "nothing";
}