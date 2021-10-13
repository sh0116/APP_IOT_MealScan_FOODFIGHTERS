import 'package:osam2021/firebase/database_challenge.dart';
import 'package:osam2021/models/challenge/challenge.dart';
import 'package:flutter/material.dart';

class ChallengeProvider {
  Future<List> loadChallenge() async {
    List dataList = await ChallengeDataBase().getData() as List;
    List<Challenge> challengeList = [];
    for(int i=0; i < dataList.length; i++){
      challengeList.add(
        Challenge(
          name: dataList[i]["name"],
          bgColor: dataList[i]["bgColor"] as Color,
          bgColor2: dataList[i]["bgColor2"] as Color,
          announcement: dataList[i]["announcement"],
          date: dataList[i]["date"],
          attendants: dataList[i]["attendants"],
          code: dataList[i]["code"],
          added: dataList[i]["added"],
          prize: dataList[i]["prize"]
        )
      );
    }
    return challengeList;
  }  
}