import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final service_number = '20-71209928';

class FireStoreDataBase {
  List imageList = [];
  List docImageList = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("IMAGES").doc(service_number).collection("WASTE_IMAGES");

   Future getImageData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          imageList.add(result['IMAGE_ADDRESS']);
          docImageList.add(result.id);
        }
      });

      return imageList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}