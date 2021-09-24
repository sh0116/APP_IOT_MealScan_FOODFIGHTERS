import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import 'package:shirne_dialog/shirne_dialog.dart';

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
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          backgroundColor: Color(0x00ffffff),
          child: new Container(
            height: 350.0,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(widget.challenge.name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                _buildSubtitle(),
                SizedBox(height: 15),
                _drawAnnouncement(),
                SizedBox(height: 30),
                _drawPrize(),
                SizedBox(height: 60),
                _drawTextButtons(),
              ],
            ),
          ),
        ));
  }

  Widget _buildSubtitle() {
    return Wrap(
      children: [
        Icon(FontAwesomeIcons.solidClock, color: Color(0xff5B5555), size: 10),
        Text(widget.challenge.date + "   "),
        Icon(FontAwesomeIcons.solidUser, color: Color(0xff5B5555), size: 10),
        Text(widget.challenge.attendants),
      ],
    );
  }

  Widget _drawAnnouncement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            Icon(FontAwesomeIcons.bullhorn, color: Color(0xff5B5555), size: 12),
            Text(' 지휘관 전파사항:'),
          ],
        ),
      ],
    );
  }

  Widget _drawPrize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            Icon(FontAwesomeIcons.award, color: Color(0xff5B5555), size: 12),
            Text(' 포상:'),
          ],
        ),
      ],
    );
  }

  Widget _drawTextButtons() {
    return Row(children: [
      TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          MyDialog.of(context).toast('참가 중 탭에서 확인하세요', iconType: IconType.success);
        },
        child: const Text('참가하기'),
      ),
      TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('닫기'),
      ),
    ], mainAxisAlignment: MainAxisAlignment.spaceAround);
  }
}
