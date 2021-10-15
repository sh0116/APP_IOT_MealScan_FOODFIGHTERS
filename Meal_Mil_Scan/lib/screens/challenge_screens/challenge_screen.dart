import 'package:flutter/material.dart';
import 'package:osam2021/components/challenge_components/challenge_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osam2021/components/challenge_components/challenge_menu2.dart';

class ChallengeScreen extends StatelessWidget {
  final int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("챌린지", style: TextStyle(fontSize: 20)),
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
          ChallengeMenu2(),
      ),
    ); //scaffold
  }
}
