import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlbumDetails extends StatelessWidget {
  final String imagePath;
  final String date;
  final String mealType;
  final String price;
  final String details;
  final int index;

  AlbumDetails(
      {required this.imagePath,
      required this.date,
      required this.mealType,
      required this.price,
      required this.details,
      required this.index});
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff999999),
          ),
          backgroundColor: Colors.transparent,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: 'logo$index',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$mealType',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          price,
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          details,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}