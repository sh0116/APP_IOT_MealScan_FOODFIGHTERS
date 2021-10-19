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
      required this.name, //챌린지 이름
      required this.bgColor, //챌린지 카드 배경색
      required this.bgColor2, //챌린지 카드 배경 gradient 색
      required this.prize, // 챌린지 우승 포상
      required this.announcement, //지휘관 전파사항
      required this.date, // 마가임
      required this.attendants, //참가인원수
      required this.code, //부대운영코드
      required this.added //유저가 참가등록했는지 여부
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
