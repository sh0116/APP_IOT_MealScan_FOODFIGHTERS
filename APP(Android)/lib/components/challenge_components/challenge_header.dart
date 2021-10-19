/// 참가 중 챌린지 페이지에 들어가는 챌린지 헤더
import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge/challenge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChallengeHeader extends StatelessWidget {
  final Challenge challenge;
  const ChallengeHeader({required this.challenge});

  /// 마감일자, 참가인원 수를 보여줌. 
  @override
  Widget build(BuildContext context) {
    var splitDate = challenge.date.split('-');
    var formattedDate = splitDate[0] + "년 " + splitDate[1] + "월 " + splitDate[2].substring(0, 2) +"일";
    return Column(children: [
      SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(challenge.name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
      ]), 
      SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Wrap(
          children: [
            Icon(FontAwesomeIcons.solidClock, color: Color(0xff5B5555), size: 15),
            SizedBox(width: 4,),
            Text(formattedDate + " 종료   "),
            Icon(FontAwesomeIcons.solidUser, color: Color(0xff5B5555), size: 15),
            SizedBox(width: 4,),
            Text(challenge.attendants),
          ],
        )
      ]),
    ]);
  }
}
