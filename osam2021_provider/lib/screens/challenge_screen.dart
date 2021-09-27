import 'package:flutter/material.dart';
import 'package:osam2021/components/challenge_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChallengeScreen extends StatelessWidget {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Challenge"),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.bell),
            onPressed: () {},
          ),
          SizedBox(width: 16),
        ],
        elevation: 0.0,
      ),
      body: Column(
        children: [
          ChallengeMenu(),
        ],
      ),
    ); //scaffold
  }
}
