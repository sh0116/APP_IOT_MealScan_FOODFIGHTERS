import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osam2021/screens/added_challenge_info.dart';
import 'package:osam2021/screens/challenge_info.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ChallengeCard extends StatefulWidget {
  final Challenge challenge;
  const ChallengeCard({required this.challenge});

  @override
  _ChallengeCardState createState() => _ChallengeCardState();
}

//https://sergiandreplace.com/planets-flutter-creating-a-planet-card/
//https://flutterawesome.com/a-flutter-widget-with-the-goal-of-simplifying-styling-and-to-reduce-nesting/
class _ChallengeCardState extends State<ChallengeCard> {
  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("hh:mm:ss");
    int estimateTs = DateTime.parse('2021-11-30 23:59:59').millisecondsSinceEpoch;
    int now = DateTime.now().millisecondsSinceEpoch;
    Duration remaining = Duration(milliseconds: estimateTs - now);
    String formattedRemaining = '${remaining.inDays}:${format.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
    var date = formattedRemaining.split(":");
    Duration defaultDuration = Duration(days: remaining.inDays, hours: int.parse(date[1]), minutes: int.parse(date[2]));
    const defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
    return Column(
      children: [
        SlideCountdown(
          duration: defaultDuration,
          padding: defaultPadding,
          slideDirection: SlideDirection.up,
          fade: true,
          icon: Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              Icons.alarm,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        Card(
            child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                barrierColor: Color(0x00ffffff),
                builder: (BuildContext context) {
                  return ChallengeInfo(challenge: widget.challenge);
                });
            // _navigateToInfoScreen(context);
          },
          child: ListTile(
            title: Text(widget.challenge.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            subtitle: Text(
              'A sufficiently long subtitle warrants three lines',
              style: TextStyle(fontSize: 12),
            ),
            trailing: widget.challenge.added ? Icon(FontAwesomeIcons.checkCircle) : Icon(FontAwesomeIcons.chevronRight),
            isThreeLine: true,
          ),
        )),
      ],
    );
  }

  // _navigateToInfoScreen(BuildContext context) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => AddedChallengeInfo(challenge: widget.challenge)),
  //   );
  // }
}
