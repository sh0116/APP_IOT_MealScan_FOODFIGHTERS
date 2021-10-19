//챌린지 정보를 Firebase Firestore CHALLENGES Collection에서 불러오기 위한 클래스

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChallengeDataBase {

  List challengesList = [];

  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("CHALLENGES");

<<<<<<< HEAD
   Future getChallengeData() async {
    try {
      // Firebase "CHALLENGES" collection에 있는 모든 챌린지들을 읽어서 리스트에 저장후 리턴함.
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          challengesList.add(result.data());
        }
      });
=======
    //챌린지 정보들이 불러와지면 리스트에 정보를 담아 반환
    Future getChallengeData() async {
      try {
        await collectionRef.get().then((querySnapshot) {
          for (var result in querySnapshot.docs) {
            challengesList.add(result.data());
          }
        });
>>>>>>> 4e5e8f317f599935d181d6366a67990f8af9a2a8

        return challengesList;
        //그렇지 않을시 null 값 반환
      } catch (e) {
        debugPrint("Error - $e");
        return null;
      }
    }
}