import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osam2021/components/challenge_header.dart';
import 'package:provider/provider.dart';
import 'package:osam2021/main.dart';
import 'package:osam2021/notifiers.dart';

class AddedChallengeInfo extends StatefulWidget {
  final Challenge challenge;

  const AddedChallengeInfo({required this.challenge});

  @override
  _AddedChallengeInfoState createState() => _AddedChallengeInfoState();
}

class _AddedChallengeInfoState extends State<AddedChallengeInfo> {
  int selectedId = 0;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<Notifiers>();

    return Scaffold(
        backgroundColor: Color(0xffFFAAA6),
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color(0xff999999),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.trashAlt,
                  size: 20,
                  color: Color(0xff999999),
                ), // Icon
                onPressed: () {
                  notifier.deleteChallenge(widget.challenge);
                  Navigator.pop(context, true);
                },
              ),
              SizedBox(width: 20)
            ]),
        body: Stack(children: [
          ChallengeHeader(challenge: widget.challenge),
          DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.8,
              maxChildSize: 1.0,
              builder: (BuildContext context, myScrollController) {
                return ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                          controller: myScrollController,
                          child: Column(children: [
                            _buildScreenSelector(),
                            selectedId == 0 ? SizedBox() : _buildLeaderboard(),
                          ])),
                    ));
              })
        ]));
  }

  Widget _buildScreenSelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildHeaderSelectorButton(0, "소개"),
          _buildHeaderSelectorButton(1, "리더보드"),
        ],
      ),
    );
  }

  // Widget _buildIntro() {
  //   return ();
  // }
  Widget _buildLeaderboard() {
    return Container(
      child: _rankItem(1), //Row
    ); //Container;
  }

  Widget _rankItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text("$index", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
        ), // padding
        Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text("Neecoder X", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(height: 4.0),
              Text("460km", style: TextStyle(color: Colors.grey))
            ])), //Column
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(FontAwesomeIcons.arrowUp, color: Colors.green, size: 10.0),
        ),
      ]),
    );
  }

  Widget _buildHeaderSelectorButton(int id, String t) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedId = id;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: 56,
        height: 21,
        child: Text(
          '$t',
          style: TextStyle(color: id == selectedId ? Colors.white : Colors.black),
        ),
        decoration: BoxDecoration(
          color: id == selectedId ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
