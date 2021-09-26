import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam2021/components/challenge_card.dart';
import 'package:osam2021/models/challenge.dart';
import 'package:provider/provider.dart';
import 'package:osam2021/main.dart';
import 'package:osam2021/notifiers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        _buildItems(context)
      ],
    );
  }

  Widget _buildItems(BuildContext context) {
    final notifiers = context.watch<Notifiers>();
    final String noChallengeText = "참가 중인 챌린지가 없네요.\n"
        "지금 참가하여 상점, 전투휴무 등 다양한\n"
        "포상 획득하세요.\n";

    List<Challenge> addedChallenges = open.where((f) => f.added == true).toList();

    return selectedId == 0
        ? (notifiers.added.length == 0
            ? Center(
                child: Column(children: [
                Text(
                  noChallengeText,
                  textAlign: TextAlign.center,
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      selectedId = 1;
                    });
                  },
                  color: Color(0xff4dd0e1),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: CircleBorder(),
                )
              ]))
            : ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: List.generate(notifiers.added.length, (index) => ChallengeCard(challenge: notifiers.added[index], added: true, notifyParent: refresh)), //List.generate
              )) //

        : ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: List.generate(notifiers.opened.length, (index) => ChallengeCard(challenge: notifiers.opened[index], added: false, notifyParent: refresh)), //List.generate
          ); //ListView
  }

  Widget _buildScreenSelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildHeaderSelectorButton(0, "참가 중"),
          _buildHeaderSelectorButton(1, "진행 중"),
        ],
      ),
    );
  }

  refresh() {
    setState(() {});
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
        width: 60,
        height: 21,
        child: Text(
          '$t',
          style: TextStyle(
            color: id == selectedId ? Colors.white : Colors.black,
          ),
        ),
        decoration: BoxDecoration(
          color: id == selectedId ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
