import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam2021/components/challenge_card.dart';
import 'package:osam2021/models/challenge.dart';
import 'package:provider/provider.dart';
import 'package:osam2021/main.dart';
import 'package:osam2021/notifiers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
<<<<<<< HEAD
import 'package:animated_widgets/animated_widgets.dart';
=======
>>>>>>> 03cb8207fe4ba2e5f539bf602c584198a648a235


class ChallengeMenu extends StatefulWidget {
  @override
  _ChallengeMenuState createState() => _ChallengeMenuState();
}

class _ChallengeMenuState extends State<ChallengeMenu> {
  int selectedId = 0;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildScreenSelector(),
        _buildItems(context),
        // _buildSwipableCards(context),
      ],
    );
  }

  Widget _buildItems(BuildContext context) {
    final notifiers = context.watch<Notifiers>();
    final String noChallengeText = "참가 중인 챌린지가 없네요.\n"
        "지금 참가하여 상점, 전투휴무 등 다양한\n"
        "포상 획득하세요.\n";

    final addedItems = List.generate(notifiers.added.length, (index) => ChallengeCard(challenge: notifiers.added[index], added: true, notifyParent: refresh));
    final openItems = List.generate(notifiers.opened.length, (index) => ChallengeCard(challenge: notifiers.opened[index], added: false, notifyParent: refresh));

    return selectedId == 0
        ? (notifiers.added.length == 0 //ADDED
            ? Center(
                child: Column(children: [
                Text(
                  noChallengeText,
                  textAlign: TextAlign.center,
                ),
                ShakeAnimatedWidget(
                  enabled: true,
                  shakeAngle: Rotation.deg(z: 40),
                  curve: Curves.linear,
                  child: MaterialButton(
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
                  ),
                )
              ]))
            : 
            ListView.builder(
              shrinkWrap: true,
              itemCount: addedItems.length,
              itemBuilder: (context, index) {
                final item = addedItems[index];
                return Dismissible(
                  key: Key(notifiers.added[index].name),
                  onDismissed: (direction) {
                    notifiers.openChallenge(notifiers.added[index]);
                    notifiers.deleteChallenge(notifiers.added[index]);
                    setState(() {
                      addedItems.removeAt(index);
                    });
                    ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('삭제 완료! 진행 중 탭에서 확인하세요.')));
                  },
                  background: Container(color: Colors.red),
                  child: item);
              },))

        : 
<<<<<<< HEAD
=======

>>>>>>> 03cb8207fe4ba2e5f539bf602c584198a648a235
            ListView.builder(
              shrinkWrap: true,
              itemCount: openItems.length,
              itemBuilder: (context, index) {
                final item = openItems[index];
                return Dismissible(
                  key: Key(notifiers.opened[index].name),
                  onDismissed: (direction) {
                    notifiers.addChallenge(notifiers.opened[index]);
                    notifiers.closeChallenge(notifiers.opened[index]);
                    setState(() {
                      openItems.removeAt(index);
                    });
                    ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('등록 완료! 참가 중 탭에서 확인하세요.')));
                  },
                  background: Container(color: Colors.green),
                  child: item);
              },);
  }
<<<<<<< HEAD
=======

>>>>>>> 03cb8207fe4ba2e5f539bf602c584198a648a235

  Widget _buildScreenSelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeaderSelectorButton(0, "참가 중"),
          SizedBox(width: 10),
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
        height: 25,
        child: Text(
          '$t',
          style: TextStyle(
            color: id == selectedId ? Colors.white : Colors.black, fontWeight: FontWeight.bold
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
