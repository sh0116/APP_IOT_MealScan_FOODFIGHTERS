import 'package:flutter/material.dart';
import 'album_details.dart';
import 'package:intl/intl.dart';

List<ImageDetails> _images = [
  ImageDetails(
    imagePath: 'assets/images/meal1.jpg',
    percentage: '80%',
    mealType: '조식',
    date: '2021-11-29',
    details:
        '',
  ),
  ImageDetails(
    imagePath: 'assets/images/meal2.jpg',
    percentage: '65%',
    mealType: '중식',
    date: '2021-11-30',
    details:
        '',
  ),
];

class AlbumHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _images.sort((a,b) => a.date.compareTo(b.date));
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
                            builder: (context) => AlbumDetails(
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
        )
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildImageGridView() {
    var dateToImages = new Map();
    _images.sort((a,b) => a.date.compareTo(b.date));
    //group images by date
    for (int i = 0; i < _images.length; i++) {
      var d = _images[i].date; //convert string to Datetime
      if (dateToImages.containsKey(d)) {
        dateToImages[d].add(_images[i]);
      } else {
        dateToImages[d] = [_images[i]];
                print(dateToImages);
      }
    }
    var sortedKeys = dateToImages.keys.toList()..sort((a, b) => a.compareTo(b));
    List<Widget> children = [];
    for (int i = 0; i < sortedKeys.length; i++) {
      var date = sortedKeys[i];
      children.add(Text(date, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)));
      var images = dateToImages[date];
      Container gridviewContainer = Container(
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
                              imagePath: images[index].imagePath,
                              date: images[index].date,
                              mealType: images[index].mealType,
                              percentage: images[index].percentage,
                              details: images[index].details,
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
                              image: AssetImage(images[index].imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: images.length,
                ),
        );
        children.add(gridviewContainer);
    }
    return children;
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