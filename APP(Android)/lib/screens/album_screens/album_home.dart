//유저가 지금까지 스캔한 식판들의 사진을 불러옴
import 'package:flutter/material.dart';
import 'package:osam2021/firebase/database_images.dart';
import 'album_details.dart';

class AlbumHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  return FutureBuilder( //Firebase에서 FutureBuilder를 통해 사진 받기
    future: ImageDataBase().getImageData(),
    builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
           if (snapshot.connectionState == ConnectionState.done) {
            photoList = snapshot.data as List;
            return GridView.builder(
              padding: const EdgeInsets.all(8),
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
                            image: Image.network(photoList[index]["IMAGE_ADDRESS"]).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
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
