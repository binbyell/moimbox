
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/function/function.dart';
import 'package:moimbox/page/InterestPage.dart';
import 'package:moimbox/page/SignUp_SignUp.dart';
import 'package:moimbox/page/SignUp_TermToAgreement.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moimbox/data/data_meta.dart';
import 'package:moimbox/page/_Home.dart';


/// 회원가입 정보입력

class SignUp extends StatefulWidget {
  @override
  _signUp createState() => _signUp();
}

class _signUp extends State<SignUp> {

  int _selectedIndex = 0;

  /// 페이지들
  final List<Widget> _pageListForSignUp = <Widget>[
    SignUp_AgreementPage(),
    SignUp_SignUpPage(),
    InterestPage(needAppBar: false,)
  ];

  String getActonButtonText(int getIndex){
    switch (getIndex){
      case 0: return "가입";
      case 1: return "다음";
      case 2: return "확인";
      default: return "다음";
    }
  }
  
  Color getActionButtonTextColor(int getIndex){
    switch (getIndex){
      case 0:
        {
          if(metaSignInIsCheckPersonalInformation && metaSignInIsCheckService){
            return ColorsForApp.activeColorForActionButton;
          }
          else{
            return ColorsForApp.inactiveColor;
          }
        }
      case 1: {
        if(metaMyProfileItem.checkFilledWithoutToast()){
          return ColorsForApp.activeColorForActionButton;
        }
        else{
          return ColorsForApp.inactiveColor;
        }
      }
      default: return ColorsForApp.activeColorForActionButton;
    }
  }

  String getAppbarText(int getIndex){
    switch (getIndex){
      case 0: return "약관동의";
      case 1: return "회원가입";
      case 2: return "관심사 선택";
      default: return "회원가입";
    }
  }

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsForApp.black,
          ),
          onPressed: (){
            _selectedIndex == 0?
            Navigator.of(context).pop():
            setState((){
              _selectedIndex -=1;
            });
          },
        ),
        title: Container(
          child: Text(getAppbarText(_selectedIndex), style: appBarTitleTextStyle,),
        ),
        actions: [
          TextButton(
              onPressed: (){
                print("=!=!=!=\n${metaMyProfileItem.interest}\n=!=!=!=");
                print("_selectedIndex : $_selectedIndex");
                /// 약관동의
                if (_selectedIndex == 0){
                  if( metaSignInIsCheckService && metaSignInIsCheckPersonalInformation){
                    setState(() {
                      _selectedIndex <=1?
                      _selectedIndex += 1:
                      _selectedIndex=_selectedIndex;
                    });
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: metaSignInIsCheckService?"개인정보 수집이용 동의가 채크되지 않았습니다.":"서비스 이용약관 동의가 채크되지 않았습니다.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: ColorsForApp.black,
                        textColor: ColorsForApp.inactiveColor,
                        fontSize: 16.0
                    );
                  }
                }
                /// 회원가입
                else if(_selectedIndex == 1){
                  if(metaMyProfileItem.checkFilled()){
                    setState(() {
                      _selectedIndex <=1?
                      _selectedIndex += 1:
                      _selectedIndex=_selectedIndex;
                    });
                  }
                }
                /// 관심사 선택
                else if(_selectedIndex == 2){
                  sendImageToAccountStorage(metaSignInImage!).then((value){
                    if(value.runtimeType == String){
                      setState(() {
                        metaMyProfileItem.profileImageUrl = value as String;
                      });
                      print("imageUrl Test ${metaMyProfileItem.profileImageUrl}");
                    }
                    addAccount(metaMyProfileItem);

                    metaSignInImage = null;

                    setState(() {
                      _selectedIndex <=1?
                      _selectedIndex += 1:
                      _selectedIndex=_selectedIndex;
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>Home()));
                    });
                  });
                }
                else{
                  setState(() {
                    _selectedIndex <=1?
                    _selectedIndex += 1:
                    _selectedIndex=_selectedIndex;
                  });
                }
              },
              child: Text(
                  getActonButtonText(_selectedIndex),
                style: TextStyle(
                  color: getActionButtonTextColor(_selectedIndex)
                ),
              ))
        ],
        backgroundColor: ColorsForApp.appBarColor,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pageListForSignUp,
      ),
    );
  }
}