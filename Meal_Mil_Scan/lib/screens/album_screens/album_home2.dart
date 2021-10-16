import 'dart:html';

import 'package:flutter/material.dart';
import 'package:osam2021/screens/album_screens/album_details2.dart';
import 'album_details.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:osam2021/firebase/database_images.dart';

//final ref =
//  FirebaseStorage.instance.ref().child('20-71209928/21-10-13-2.png');
// no need of the file extension, the name will do fine.
//var url = ref.getDownloadURL();
//var m = url.toString();
//StorageReference ref =
//    FirebaseStorage.instance.ref().child('20-71209928/21-10-13-2.png');
//String url = (ref.getDownloadURL()).toString();

//Future<String> getFileData() async {
//    final ref = FirebaseStorage.instance.ref().child('20-71209928/21-10-13-2.png');
//    var url = await ref.getDownloadURL();
//    return url.toString();
//  }

final m = "https://storage.googleapis.com/military-cafeteria.appspot.com/20-71209928/21-10-14-3.png";
List<ImageDetails> _images = [
  ImageDetails(
    imagePath: m,
    percentage: '80%',
    mealType: '조식',
    date: '2021-11-29',
    details: '',
  ),
  ImageDetails(
    imagePath: m,
    percentage: '65%',
    mealType: '중식',
    date: '2021-11-30',
    details: '',
  ),
];

class AlbumHome2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _images.sort((a, b) => a.date.compareTo(b.date));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumDetails2(
                            imagePath: _images[index].imagePath,
                            date: _images[index].date,
                            mealType: _images[index].mealType,
                            percentage: _images[index].percentage,
                            details: _images[index].details,
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'logo$index',
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: Image.network(_images[index].imagePath).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _images.length,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
 

class ImageDetails {
  final String imagePath;
  final String percentage;
  final String mealType;
  final String date;
  final String details;
  ImageDetails({
    required this.imagePath,
    required this.percentage,
    required this.mealType,
    required this.date,
    required this.details,
  });
}
