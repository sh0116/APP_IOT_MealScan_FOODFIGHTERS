import 'dart:html';

import 'package:flutter/material.dart';
import 'package:osam2021/firebase/database_images.dart';
import 'album_details.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';

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

//final m = getFileData();
List<ImageDetails> _images = [
  ImageDetails(
    imagePath: 'assets/images/meal1.jpg',
    percentage: '80%',
    mealType: '조식',
    date: '2021-11-29',
  ),
  ImageDetails(
    imagePath: 'assets/images/meal2.jpg',
    percentage: '65%',
    mealType: '중식',
    date: '2021-11-30',
  ),
];

class AlbumHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //_images.sort((a, b) => a.date.compareTo(b.date));
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
              child: buildPhotos(),
            ))
          ],
        ),
      ),
    );
  }

Widget buildPhotos() {
  List photoList = [];
  return FutureBuilder(
    future: ImageDataBase().getImageData(),
    builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            photoList = snapshot.data as List;
            return Column(
              children: [
                GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: photoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumDetails(
                            imagePath: photoList[index]["IMAGE_ADDRESS"],
                            date: photoList[index]["DATE"],
                            mealType: photoList[index]["MEALTYPE"],
                            percentage: photoList[index]["PERCENTAGE"],
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
                            //image: Image.network(photoList[index]["IMAGE_ADDRESS"]).image,
                            image:Image.network("https://storage.googleapis.com/military-cafeteria.appspot.com/20-71209928/21-10-14-1.png").image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());      
    }
  );
}

}

class ImageDetails {
  final String imagePath;
  final String percentage;
  final String mealType;
  final String date;
  ImageDetails({
    required this.imagePath,
    required this.percentage,
    required this.mealType,
    required this.date,
  });
}
