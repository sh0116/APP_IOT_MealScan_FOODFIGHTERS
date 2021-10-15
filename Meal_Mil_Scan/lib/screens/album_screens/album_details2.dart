import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

class AlbumDetails2 extends StatelessWidget {
  final String imagePath;
  final String date;
  final String mealType;
  final String percentage;
  final String details;
  final int index;

  AlbumDetails2(
      {required this.imagePath,
      required this.date,
      required this.mealType,
      required this.percentage,
      required this.details,
      required this.index});
      
  @override
  Widget build(BuildContext context) {
    var splitDate = date.split('-');
    var photoDescription = splitDate[0] + "년 " + splitDate[1] + "월 " + splitDate[2] +"일 (" + mealType + ") - " + percentage;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff999999),
          ),
          elevation: 0,
          leading: 
            IconButton(
              icon: Icon(
                FontAwesomeIcons.arrowLeft,
                size: 20,
                color: Color(0xff999999),
              ), // Icon
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          title: Text(photoDescription, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          actions: [
            IconButton(
              icon: Icon(
                Icons.file_download_outlined,
                size: 20,
                color: Color(0xff999999),
              ), // Icon
              onPressed: () {
              },
            ),
            SizedBox(width: 20)
          ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: 'logo$index',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  child: PhotoView(
                    imageProvider: Image.network(imagePath).image,
                    backgroundDecoration: BoxDecoration(
                      color: Colors.white
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}