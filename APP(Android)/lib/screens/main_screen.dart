import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'challenge_screens/challenge_screen.dart';
import 'data_screen.dart';
import 'album_screens/album_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ChallengeScreen(),
          DataScreen(),
          AlbumScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.grey[100],
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.trophy),
            label: "챌린지",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartBar),
            label: "내 잔반",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.images),
            label: "앨범",
          ),
        ],
      ),
    );
  }
}
