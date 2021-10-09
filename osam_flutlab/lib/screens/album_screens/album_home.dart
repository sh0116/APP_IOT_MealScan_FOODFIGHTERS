import 'package:flutter/material.dart';
import 'album_details.dart';

List<ImageDetails> _images = [
  ImageDetails(
    imagePath: 'assets/images/meal1.jpg',
    percentage: '80%',
    mealType: '조식',
    date: '2021년 10월 7일',
    details:
        '',
  ),
  ImageDetails(
    imagePath: 'assets/images/meal2.jpg',
    percentage: '65%',
    mealType: '중식',
    date: '2020년 10월 7일',
    details:
        '',
  ),
];

class AlbumHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            builder: (context) => AlbumDetails(
                              imagePath: _images[index].imagePath,
                              date: _images[index].date,
                              mealType: _images[index].mealType,
                              price: _images[index].percentage,
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
                              image: AssetImage(_images[index].imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _images.length,
                ),
              ),
            )
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