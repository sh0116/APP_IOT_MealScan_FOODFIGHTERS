import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:osam2021/notifiers.dart';

class ChallengeInfo extends StatefulWidget {
  final Challenge challenge;
  const ChallengeInfo({required this.challenge});

  @override
  _ChallengeInfoState createState() => _ChallengeInfoState();
}

class _ChallengeInfoState extends State<ChallengeInfo> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          //elevation: 0,
          backgroundColor: Colors.white,
          child: new Container(
            height: 350.0,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(widget.challenge.name,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                _buildSubtitle(),
                SizedBox(height: 15),
                _drawAnnouncement(),
                SizedBox(height: 30),
                _drawPrize(),
                SizedBox(height: 80),
                _drawTextButtons(),
              ],
            ),
          ),
        ));
  }

  Widget _buildSubtitle() {
    return Wrap(
      children: [
        Icon(FontAwesomeIcons.solidClock, color: Color(0xff5B5555), size: 15),
        SizedBox(
          width: 4,
        ),
        Text(widget.challenge.date + " 종료   "),
        Icon(FontAwesomeIcons.solidUser, color: Color(0xff5B5555), size: 15),
        SizedBox(
          width: 4,
        ),
        Text(widget.challenge.attendants,
            style: TextStyle(color: Color(0xff5B5555))),
      ],
    );
  }

  Widget _drawAnnouncement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            Icon(FontAwesomeIcons.bullhorn, color: Color(0xff5B5555), size: 15),
            Text(' 지휘관 전파사항:', style: TextStyle(color: Color(0xff5B5555))),
          ],
        ),
      ],
    );
  }

  Widget _drawPrize() {
    String prize = widget.challenge.prize;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            Icon(FontAwesomeIcons.award, color: Color(0xff5B5555), size: 15),
            Text(' 포상', style: TextStyle(color: Color(0xff5B5555))),
          ],
        ),
        Text('$prize', style: TextStyle(color: Color(0xff5B5555)))
      ],
    );
  }

  Widget _drawTextButtons() {
    return Consumer<Notifiers>(
      builder: (context, notifiers, child) {
        return Row(children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 20, color: Color(0xff5B5555)),
            ),
            onPressed: () {
              notifiers.addChallenge(widget.challenge);
              notifiers.closeChallenge(widget.challenge);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('참가등록 완료! 참가 중 탭에서 확인하세요.')));
            },
            child: const Text('참가하기'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 20, color: Color(0xff5B5555)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('닫기'),
          ),
        ], mainAxisAlignment: MainAxisAlignment.spaceAround);
      },
    );
  }
}
