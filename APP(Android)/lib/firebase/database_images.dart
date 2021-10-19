//이미지 정보를 Firebase Firestore WASTE_IMAGES Collection에서 불러오기 위한 클래스

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final service_number = '20-14339655';

class ImageDataBase {
  List imageList = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("IMAGES").doc(service_number).collection("WASTE_IMAGES");
      
    //이미지 정보들이 불러와지면 리스트에 정보를 담아 반환
    Future getImageData() async {
      try {
        await collectionRef.get().then((querySnapshot) {
          for (var result in querySnapshot.docs) {
            imageList.add(result.data());
          }
        });

        return imageList;
        //그렇지 않을시 null 값 반환
      } catch (e) {
        debugPrint("Error - $e");
        return null;
      }
    }
}