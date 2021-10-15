import 'package:flutter/material.dart';
import 'package:osam2021/notifiers.dart';

class Challenge {
  final String name;
  final Color bgColor;
  final Color bgColor2;
  final String announcement;
  final String date;
  final String attendants;
  final int code;
  final bool added;
  final String prize;

  Challenge(
    {
      required this.name,
      required this.bgColor,
      required this.bgColor2,
      required this.prize,
      required this.announcement,
      required this.date,
      required this.attendants,
      required this.code,
      required this.added
    }
  );
}

// Firebase에 저장된 challenge 데이터를 Notifier의 opened에 씀
void initializeNotifier(List dataList, Notifiers notifiers){
  notifiers.initialized = true;
  for(int i=0; i < dataList.length; i++){
    notifiers.openChallenge(
      Challenge(
        name: dataList[i]["name"],
        bgColor: Color(dataList[i]["bgColor"]),
        bgColor2: Color(dataList[i]["bgColor2"]),
        announcement: dataList[i]["announcement"],
        date: dataList[i]["date"],
        attendants: dataList[i]["attendants"],
        code: dataList[i]["code"],
        added: dataList[i]["added"],
        prize: dataList[i]["prize"]
      )
    );
  }
}