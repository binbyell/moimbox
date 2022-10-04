import 'package:flutter/material.dart';
import 'package:moimbox/page/Home_AlarmListPage.dart';
import 'package:moimbox/page/Home_MyMeetingListPage.dart';
import 'package:moimbox/page/Home_MyProfilePage.dart';
import 'package:moimbox/page/Home_PreviewListPage.dart';
import 'package:moimbox/page/MakeMeetingPage.dart';
import 'package:moimbox/tempP.dart';

import '../data/data.dart';

class Home extends StatefulWidget {
  @override
  _pageHome createState() => _pageHome();
}

class _pageHome extends State<Home> {
  int _selectedIndex = 3;

  /// 페이지들
  final List<Widget> _pageList = <Widget>[
    PreviewListPage(),
    AlarmListPage(),
    MyMeetingListPage(),
    MyProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Key keyForFilterSelect = UniqueKey();
  Key keyForBottomNavigation = GlobalKey();

  /// appbar
  /// title 앞
  /// leading: IconButton(icon: const Icon(Icons.add),onPressed: (){},),
  /// title 뒤
  /// actions: [IconButton(icon: const Icon(Icons.add_a_photo),onPressed: (){},)],
  AppBar? tempAppber(int temp){
    switch (temp) {
      case 0:
        return null;
      case 1:
        return AppBar(
          title: Text("알림", style: appBarTitleTextStyle,),
          backgroundColor: ColorsForApp.appBarColor,
        );
      case 2:
        return AppBar(
          title: Text("내모임", style: appBarTitleTextStyle,),
          backgroundColor: ColorsForApp.appBarColor,
        );
      default:
        return AppBar(
          title: Text("프로필", style: appBarTitleTextStyle,),
          backgroundColor: ColorsForApp.appBarColor,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: tempAppber(_selectedIndex),
      body: Builder(
        builder: (bodyContext){
          return IndexedStack(
            index: _selectedIndex,
            children: _pageList,
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationBarIconList,
        currentIndex: _selectedIndex,
        unselectedItemColor: ColorsForApp.black,
        showUnselectedLabels: true,
        selectedItemColor: ColorsForApp.selectedItemColor,
        onTap: _onItemTapped,
      ),
      floatingActionButton: Visibility(
        visible: _selectedIndex == 2,
        child: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => MakeMeeting())
              );
            },
            backgroundColor: const Color(0xff2E2C76),
            child: const ImageIcon(
              AssetImage("images/icon_add_meeting.png"),
              color: ColorsForApp.white,
              size: 24,
            )
        ),
      ),
    );
  }
}