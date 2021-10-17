import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChallengeDataBase {
  List challengesList = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("CHALLENGES");

   Future getChallengeData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
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