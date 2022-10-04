
import 'package:flutter/material.dart';
import 'package:moimbox/data/data.dart';

Widget makeListItem({required BuildContext context, required String text, required GestureTapCallback onTap, bool needBorder = true}){
  return InkWell(
    onTap: onTap,
    child: Container(
      height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.069,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.077),
      decoration: BoxDecoration(
          border: needBorder
              ?const Border(
              bottom: BorderSide(
                  color: ColorsForApp.inactiveColor,
                  width: 1
              )
          )
              :null
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              text,
              style: const TextStyle(
                  color: ColorsForApp.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: "NotoSansKR",
                  fontStyle:  FontStyle.normal,
                  fontSize: 14.0
              ),
              textAlign: TextAlign.left
          )
        ],
      ),
    ),
  );
}