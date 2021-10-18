import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge/challenge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osam2021/components/challenge_components/challenge_header.dart';
import 'package:provider/provider.dart';
import 'package:osam2021/notifiers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddedChallengeInfo extends StatefulWidget {
  final Challenge challenge;

  const AddedChallengeInfo({required this.challenge});

  @override
  _AddedChallengeInfoState createState() => _AddedChallengeInfoState();
}

class _AddedChallengeInfoState extends State<AddedChallengeInfo> {
  int selectedId = 0;
  List<String> ranks = [
    "본부포대",
    "3포대",
    "2포대",
    "1포대"
  ];

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<Notifiers>();

    return Scaffold(
        backgroundColor: widget.challenge.bgColor,
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
                ),
                onPressed: () {
                  notifier.deleteChallenge(widget.challenge);
                  notifier.openChallenge(widget.challenge);
                  Navigator.pop(context, true);
                  ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('삭제 완료! 진행 중 탭에서 확인하세요.')));
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
                            selectedId == 0 ? _buildIntro() : _buildLeaderboard('1'),
                          ])),
                    ));
              })
        ]));
  }

  Widget _buildIntro() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Icon(FontAwesomeIcons.bullhorn, color: Color(0xff5B5555), size: 15),
              Text('  지휘관 전파사항', style: TextStyle(color: Color(0xff5B5555),)),
            ],
          ),
          SizedBox(height: 5),
          Text('  이기자! 수호대대 병사 여러분, 좋은 취지에 함께하기 위해 챌린지에 참여해주셔서 감사합니다.', style: TextStyle(color: Color(0xff000000))),
          SizedBox(height: 40),

          
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Icon(FontAwesomeIcons.award, color: Color(0xff5B5555), size: 15),
              Text(' 포상', style: TextStyle(color: Color(0xff5B5555))),
            ],
          ),
          SizedBox(height: 5),
          Text('  포상외출', style: TextStyle(color: Color(0xff000000)))
        ],
      )
        ]

      ),
    );
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

  Widget _buildLeaderboard(chalCode) {
    CollectionReference rank = FirebaseFirestore.instance.collection('CHALLENGE_RANK').doc('1').collection(chalCode);
    return FutureBuilder<DocumentSnapshot>(
      future: rank.doc("RANK").get(),
      builder: 
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          //return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, 
                children: [Icon(FontAwesomeIcons.flagCheckered, size: 14),
                  Text("  매일 저녁 8시에 업데이트 됩니다."),
                ]),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  //child: Column(children: [_createRanksSpecial('1', data['LEADERBOARD'][0].substring(14), data[(data['LEADERBOARD'][0].substring(0,11))+'_AVG']), _createRanksSpecial('2', data['LEADERBOARD'][1].substring(14), data[(data['LEADERBOARD'][1].substring(0,11))+'_AVG']), _createRanks('3', '2포대', '79%'), 
                  //_createRanks('4', '1포대', '73%')].expand((x) => x).toList()),
                  child: Column(children: _createList(data).expand((x) => x).toList()),
                ), 
              ),
            ],
          );
        }
        return Text("loading");
        },
      );
  }
  List<List<Widget>> _createList(Map<String, dynamic> rankData){
    List<List<Widget>> rank = [];
    try {
      for (var i = 0; i < rankData['LEADERBOARD'].length; i++){
        if (i ==0 || i ==1){
          rank.add(_createRanksSpecial((i+1).toString(), rankData['LEADERBOARD'][i].substring(14), rankData[(rankData['LEADERBOARD'][i].substring(0,11))+'_AVG']));
        } 
        else{
          rank.add(_createRanks((i+1).toString(), rankData['LEADERBOARD'][i].substring(14), rankData[(rankData['LEADERBOARD'][i].substring(0,11))+'_AVG']));
        }

    };
    return rank;
  } catch (e) {
      debugPrint("Error - $e");
      return rank;
    }
  }
  List<Widget> _createRanks(String rank, String name, String percentage) {
    List<Widget> ranks = [];
    ranks.add(Container(
      decoration: BoxDecoration(
          color: Color(0xfffafafa), 
          borderRadius: BorderRadius.circular(10),
        ),
      child: ListTile(
        leading: Text("$rank", style: TextStyle(color: widget.challenge.bgColor, fontSize: 20),),
        title: Text("$name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        trailing: Container(child: Text("$percentage", style: TextStyle(color: widget.challenge.bgColor2, fontSize: 18))),),)
    );
    ranks.add(SizedBox(height: 13));
    return ranks;
  } 

  List<Widget> _createRanksSpecial(String rank, String name, String percentage) {
    List<Widget> ranks = [];
    Icon arrow;
    Widget rankWidget;
    Widget trailingWidget;
    Widget tooltipText = Wrap(
      children: [
        Text("$percentage", style: TextStyle(color: widget.challenge.bgColor2, fontSize: 18)),
        Icon(FontAwesomeIcons.solidQuestionCircle, size: 8)
      ],
    );
    if (rank == '1') {
      arrow = Icon(FontAwesomeIcons.sortUp, color: Colors.green, size: 10.0);
      rankWidget = Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 6),
        child: Icon(FontAwesomeIcons.medal, color: Color(0xffd4af37), size: 15),
      );
      trailingWidget = Tooltip(message: '누적 잔반 클리어율을 나타냅니다.', child: tooltipText,);
    } else {
      arrow = Icon(FontAwesomeIcons.sortDown, color: Colors.red, size: 10.0);
      rankWidget = Text("$rank", style: TextStyle(color: widget.challenge.bgColor, fontSize: 20));
      trailingWidget = Text("$percentage", style: TextStyle(color: widget.challenge.bgColor2, fontSize: 18));
    }
    ranks.add(Container(
      decoration: BoxDecoration(
          color: Color(0xfffafafa), 
          borderRadius: BorderRadius.circular(10),
        ),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(children: [rankWidget,arrow,]),
        ),
        title: Text("$name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        trailing: trailingWidget,),)
    );
    ranks.add(SizedBox(height: 13));
    return ranks;
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
