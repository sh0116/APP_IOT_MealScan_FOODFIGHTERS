import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osam2021/screens/album_screens/album_home2.dart';
import 'album_home.dart';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("앨범", style: TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.signOutAlt),
            onPressed: () {},
          ),
          SizedBox(width: 16),
        ],
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: 
          AlbumHome2(),
      ),
    );
  }
}