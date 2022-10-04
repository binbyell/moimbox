
import 'package:moimbox/data/data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyProfileItem{
  String? uid;
  String name;
  String profileImageUrl;
  String address;
  String nickname;
  String dateOfBirth;
  String phoneNumber;
  String eMail;
  String introduce;
  List<dynamic> interest;

  MyProfileItem({
    this.name = "",
    this.profileImageUrl = "", //https://lh3.googleusercontent.com/a-/AOh14Gi-U111ZiN8RkIZpRWlMAZxO8-IoxCcVNKfBfkn40U=s288-p-rw-no
    this.address = "",
    this.nickname = "",
    this.dateOfBirth = "",
    this.phoneNumber = "",
    this.eMail = "",
    this.introduce = "한줄 소개",
    this.interest = const []
  });

  void setInterest(List<String> interestList){
    interest = interestList;
  }

  bool checkFilled(){
    if(name.isEmpty){
      Fluttertoast.showToast(
          msg: "이름을 입력해 주세요",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorsForApp.black,
          textColor: ColorsForApp.inactiveColor,
          fontSize: 16.0
      );
      return false;
    }
    if(address.isEmpty){
      Fluttertoast.showToast(
          msg: "내 지역을 선택해 주세요",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorsForApp.black,
          textColor: ColorsForApp.inactiveColor,
          fontSize: 16.0
      );
      return false;
    }
    if(nickname.isEmpty){
      Fluttertoast.showToast(
          msg: "닉네임을 입력해 주세요",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorsForApp.black,
          textColor: ColorsForApp.inactiveColor,
          fontSize: 16.0
      );
      return false;
    }
    return true;
  }
  bool checkFilledWithoutToast(){
    if(name.isEmpty){
      return false;
    }
    if(address.isEmpty){
      return false;
    }
    if(nickname.isEmpty){
      return false;
    }
    return true;
  }
}
