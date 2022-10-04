

import 'package:flutter/material.dart';
import 'package:moimbox/data/data.dart';
import 'package:moimbox/data/data_address.dart';
import 'package:vertical_picker/vertical_picker.dart';

class Meeting_Location extends StatefulWidget {
  @override
  _location createState() => _location();
}

class _location extends State<Meeting_Location> {

  String cityKey = '서울';
  String addressValue01 = "서울";
  String addressValue02 = "강남구";

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    Container divideLine = Container(
        width: _device_width * 0.9,
        height: 1,
        decoration: const BoxDecoration(
            color: Color(0xffeeeeee)
        )
    );

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ColorsForApp.black,
            ),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Container(
            child: Text("지역 선택", style: appBarTitleTextStyle,),
          ),
          backgroundColor: ColorsForApp.appBarColor,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              /// 시/도 , 시/구/군
              Row(
                children: [
                  Flexible(
                    child: Container(
                      height: _device_height * 0.095,
                      child: Center(
                        child: Text(
                          "시/도",
                          style: appTextGray(16),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: Container(
                      height: _device_height * 0.095,
                      child: Center(
                        child: Text(
                          "시/구/군",
                          style: appTextGray(16),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
              divideLine,
              Container(
                height: _device_height * 0.731,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: VerticalPicker(
                          items: List.generate(
                              cityList.length,
                                  (index) => Center(
                                child: Text(cityList[index]),
                              )),
                          itemHeight: 60,
                          onSelectedChanged: (int) {
                            setState((){
                              cityKey = cityList[int];
                            });
                            addressValue01 = cityList[int];
                            addressValue02 = addressMap[cityKey]![0];
                          },
                        ),
                      ),
                    ),
                    /// Line
                    Container(
                        width: 1,
                        height: _device_height * 0.731,
                        decoration: const BoxDecoration(
                            color: Color(0xffeeeeee)
                        )
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: VerticalPicker(
                          items: List.generate(
                              addressMap[cityKey]!.length,
                                  (index) => Center(
                                child: Text(addressMap[cityKey]![index]),
                              )),
                          itemHeight: 60,
                          onSelectedChanged: (int) {
                            addressValue02 = addressMap[cityKey]![int];
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              divideLine,
              Row(
                children: [
                  /// 닫기
                  Flexible(
                    flex: 1,
                    child: TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: _device_height * 0.08,
                        child: Center(
                          child: Text(
                            "닫기",
                            style: appTextGray(16),
                          ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero
                      ),
                    ),
                  ),
                  /// 확인
                  Flexible(
                    flex: 1,
                    child: TextButton(
                      onPressed: (){
                        print("=!=!=!=\n pop.address : $addressValue01 / $addressValue02\n=!=!=!=");
                        Navigator.pop(context, '$addressValue01 / $addressValue02');
                      },
                      child: Container(
                        height: _device_height * 0.08,
                        child: Center(
                          child: Text(
                            "확인",
                            style: appTextGray(16),
                          ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}