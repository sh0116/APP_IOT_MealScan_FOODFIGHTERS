import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final service_number = '20-14339655';

class DataDataBase {
  List imageList = [];
  final CollectionReference collectionRef = FirebaseFirestore.instance.collection('USER_FOOD_WASTE_AVG');
   Future getGaugeData() async {
    try {
      //to get data from a single/particular document alone.
      var temp = await collectionRef.doc(service_number).get();


      return temp;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}