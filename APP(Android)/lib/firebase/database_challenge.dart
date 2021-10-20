//챌린지 정보를 Firebase Firestore CHALLENGES Collection에서 불러오기 위한 클래스

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChallengeDataBase {

  List challengesList = [];

  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("CHALLENGES");

    //챌린지 정보들이 불러와지면 리스트에 정보를 담아 반환
    Future getChallengeData() async {
      try {
        await collectionRef.get().then((querySnapshot) {
          for (var result in querySnapshot.docs) {
            challengesList.add(result.data());
          }
        });

        return challengesList;
        //그렇지 않을시 null 값 반환
      } catch (e) {
        debugPrint("Error - $e");
        return null;
      }
    }
}