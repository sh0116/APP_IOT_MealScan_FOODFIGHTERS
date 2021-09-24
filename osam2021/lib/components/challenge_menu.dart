import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam2021/components/challenge_card.dart';
import 'package:osam2021/models/challenge.dart';

class ChallengeMenu extends StatefulWidget {
  @override
  _ChallengeMenuState createState() => _ChallengeMenuState();
}

class _ChallengeMenuState extends State<ChallengeMenu> {
  int selectedId = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildScreenSelector(),
        _buildItems()
      ],
    );
  }

  Widget _buildItems() {
    final String noChallengeText = "참가 중인 챌린지가 없네요.\n"
        "지금 참가하여 상점, 전투휴무 등 다양한\n"
        "포상 획득하세요.\n";

    List<Challenge> addedChallenges = open.where((f) => f.added == true).toList();

    return selectedId == 0
        ? Center(child: Text(noChallengeText, textAlign: TextAlign.center)) //
        : ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: List.generate(open.length, (index) => ChallengeCard(challenge: open[index])), //List.generate
          ); //ListView
  }

  Widget _buildScreenSelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildHeaderSelectorButton(0, "ADDED"),
          _buildHeaderSelectorButton(1, "OPEN"),
        ],
      ),
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
