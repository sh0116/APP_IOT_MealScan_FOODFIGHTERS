import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam2021/components/challenge_card.dart';
import 'package:osam2021/models/challenge.dart';
import 'package:provider/provider.dart';
import 'package:osam2021/main.dart';
import 'package:osam2021/notifiers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tcard/tcard.dart';



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

    List<Challenge> addedChallenges = open.where((f) => f.added == true).toList();

    return selectedId == 0
        ? (notifiers.added.length == 0 //ADDED
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

        : _buildSwipableCards(context);
        
        //  ListView( //OPEN
        //     scrollDirection: Axis.vertical,
        //     shrinkWrap: true,
        //     children: List.generate(notifiers.opened.length, (index) => ChallengeCard(challenge: notifiers.opened[index], added: false, notifyParent: refresh)), //List.generate
        //   ); 
  }

  Widget _buildSwipableCards(BuildContext context) {
      final notifiers = context.watch<Notifiers>();
      TCardController _controller = TCardController();
  //             if (counter <= 20) {
  //               //_cardController.addItem(CardView(text: "Card $counter"));
  //               counter++;
  //             }
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TCard(
              cards: List.generate(notifiers.opened.length, 
              (index) => ChallengeCard(challenge: notifiers.opened[index], added: false, notifyParent: refresh)),
              size: Size(360, 480),
              controller: _controller,
              onForward: (index, info) {
                print(index);
              },
              onBack: (index, info) {
                print(index);
              },
              onEnd: () {
                print('end');
              },
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    print(_controller);
                    _controller.back();
                  },
                  child: Text('Back'),
                ),
                OutlinedButton(
                  onPressed: () {
                    _controller.reset();
                  },
                  child: Text('Reset'),
                ),
                OutlinedButton(
                  onPressed: () {
                    _controller.forward();
                  },
                  child: Text('Forward'),
                ),
              ],
            ),
          ],
        );
    }

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