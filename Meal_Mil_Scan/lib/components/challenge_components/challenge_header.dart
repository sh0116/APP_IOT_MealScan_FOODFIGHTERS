import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChallengeHeader extends StatelessWidget {
  final Challenge challenge;
  const ChallengeHeader({required this.challenge});

  @override
  Widget build(BuildContext context) {
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
            Text(challenge.date + " 종료   "),
            Icon(FontAwesomeIcons.solidUser, color: Color(0xff5B5555), size: 15),
            SizedBox(width: 4,),
            Text(challenge.attendants),
          ],
        )
      ]),
    ]);
  }
}
