import 'package:flutter/material.dart';
import 'package:osam2021/components/challenge_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChallengeScreen extends StatelessWidget {
  final int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("챌린지"),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.bell),
            onPressed: () {},
          ),
          SizedBox(width: 16),
        ],
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: 
          ChallengeMenu(),
      ),
    ); //scaffold
  }
}
