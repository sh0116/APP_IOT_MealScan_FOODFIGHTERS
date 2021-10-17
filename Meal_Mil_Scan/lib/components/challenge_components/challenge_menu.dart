///챌린지 스크린에 보이는 참가 중 + 진행 중 화면을 모두 다루고 있음.
///셀렉터를 통하여 두 화면 사이 toggle 가능함

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam2021/components/challenge_components/challenge_card.dart';
import 'package:osam2021/firebase/database_challenge.dart';
import 'package:osam2021/models/challenge/challenge.dart';
import 'package:provider/provider.dart';
import 'package:osam2021/notifiers.dart';
import 'package:animated_widgets/animated_widgets.dart';


class ChallengeMenu extends StatefulWidget {
  @override
  _ChallengeMenuState createState() => _ChallengeMenuState();
}

class _ChallengeMenuState extends State<ChallengeMenu> {
  int selectedId = 0;
  int counter = 0;
  List challengeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: ChallengeDataBase().getChallengeData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            challengeList = snapshot.data as List;
            return Column(
              children: [
                _buildScreenSelector(),
                _buildItems(context, challengeList),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildItems(BuildContext context, List dataList) {
    final notifiers = context.watch<Notifiers>();
    final String noChallengeText = "참가 중인 챌린지가 없네요.\n" // 참가중인 챌린지가 없을시 보이는 참가독려 텍스트
        "지금 참가하여 상점, 전투휴무 등 다양한\n"
        "포상 획득하세요.\n";
    if (!notifiers.initialized) {
      initializeNotifier(dataList, notifiers);
    }
    /// Provider에 기록된 참가중, 진행중 챌린지들을 불러내어 챌린지 카드로 만듬. 
    /// 챌린지 카드로 참가중/진행중 여부 (added)를 pass하고, 챌린지 스크린 UI에 업데이트된 provider
    /// 데이터로 최신화할 수 있도록 setState을 유도하는 function 또한 전달함.
    
    final addedItems = List.generate(notifiers.added.length, (index) => ChallengeCard(challenge: notifiers.added[index], added: true, notifyParent: refresh));
    final openItems = List.generate(notifiers.opened.length, (index) => ChallengeCard(challenge: notifiers.opened[index], added: false, notifyParent: refresh));

    return selectedId == 0 // 디폴트로 참가 중 페이지가 설정되어있음
        ? (notifiers.added.length == 0 //참가 중인 챌린지가 없을 시 보이는 화면: 참가 독려 텍스트와 아이콘이 보임.
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
                    onPressed: () { // 참가 독려 아이콘 탭할 시 진행 중 탭 화면으로 전환.
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
            : // 참가 중인 챌린지가 있는 경우, 참가 중 탭 화면에서 보여줌.
            ListView.separated(
              shrinkWrap: true,
              itemCount: addedItems.length,
              itemBuilder: (context, index) {
                final item = addedItems[index];
                return Dismissible( // swipe하여 챌린지 삭제 가능
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
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 30
                );
              }
            )
          )
        : //진행 중 탭으로 전환된 경우: 참여가능한 챌린지 리스트를 보여줌.
            ListView.separated(
              shrinkWrap: true,
              itemCount: openItems.length,
              itemBuilder: (context, index) {
                final item = openItems[index];
                return Dismissible( //swipe하여 참가 가능
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
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 30
                );
              }
            );
  }

/// '참가 중', '진행 중' 챌린지 사이에서 셀렉터로 toggle 가능.
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

/// 셀렉터의 버튼을 만듬. 선택된 버튼을 검은색 배경으로 바뀜. 
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
