import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChallengeDataBase {
  List challengesList = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("CHALLENGES");

   Future getChallengeData() async {
    try {
      // Firebase "CHALLENGES" collection에 있는 모든 챌린지들을 읽어서 리스트에 저장후 리턴함.
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          challengesList.add(result.data());
        }
      });

      return challengesList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}