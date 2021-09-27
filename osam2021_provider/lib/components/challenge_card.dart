import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osam2021/screens/added_challenge_info.dart';
import 'package:osam2021/screens/challenge_info.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:osam2021/notifiers.dart';
import 'package:provider/provider.dart';

class ChallengeCard extends StatefulWidget {
  final Function() notifyParent;
  final Challenge challenge;
  final bool added;
  const ChallengeCard({required this.notifyParent, required this.challenge, required this.added});

  @override
  _ChallengeCardState createState() => _ChallengeCardState();
}

//https://sergiandreplace.com/planets-flutter-creating-a-planet-card/
//https://flutterawesome.com/a-flutter-widget-with-the-goal-of-simplifying-styling-and-to-reduce-nesting/
class _ChallengeCardState extends State<ChallengeCard> {
  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("hh:mm:ss");
    int estimateTs = DateTime.parse(widget.challenge.date).millisecondsSinceEpoch;
    int now = DateTime.now().millisecondsSinceEpoch;
    Duration remaining = Duration(milliseconds: estimateTs - now);
    String formattedRemaining = '${remaining.inDays}:${format.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
    var date = formattedRemaining.split(":");
    Duration defaultDuration = Duration(days: remaining.inDays, hours: int.parse(date[1]), minutes: int.parse(date[2]));
    const defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 3);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SlideCountdown(
                duration: defaultDuration,
                padding: defaultPadding,
                slideDirection: SlideDirection.up,
                fade: true,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.alarm,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
            child: InkWell(
          onTap: () {
            widget.added
                ? _navigateToInfoScreen(context)
                : showDialog(
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
        SizedBox(height: 50)
      ],
    );
  }

  _navigateToInfoScreen(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return AddedChallengeInfo(challenge: widget.challenge);
    }));
    widget.notifyParent();
  }
}
