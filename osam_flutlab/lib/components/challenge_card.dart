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
//https://pub.dev/packages/flip_card
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
            if (widget.added) {
              _navigateToInfoScreen(context);
            } else {
              _navigateToChallengeInfo(context);
            }
          },
          child: ListTile(
            title: Text(widget.challenge.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            subtitle: _buildCardSubtitles(defaultDuration, defaultPadding),
            trailing: widget.challenge.added ? Icon(FontAwesomeIcons.checkCircle) : Icon(FontAwesomeIcons.chevronRight),
            isThreeLine: true,
          ),
        )),
      // _createCard(),
        
        SizedBox(height: 30)
      ],
    );
  }

  Widget _newCard() {
    String date = widget.challenge.date;
    return InkWell(
      onTap: () {
        if (widget.added) {
            _navigateToInfoScreen(context);
        } else {
            _navigateToChallengeInfo(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(offset: Offset(5, 10), blurRadius: 20, color: Color(0xFF6985e8).withOpacity(0.2))
          ]
        ),
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Text("259대대 잔반경연", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.timer, size: 20, color: Colors.white),
                    SizedBox(
                       width: 10,
                    ),
                    Text("$date",
                        style: TextStyle(fontSize: 14, color: Colors.white,)
                    ),                    
                  ]
                ),
                Expanded(child: Container()),
                Icon(FontAwesomeIcons.chevronRight, color: Colors.white),
              ]
            )
          ]
        ),
      ),
    );

  }

  Widget _createCard() {
    return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  child: Container(
                      padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("Next workout",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            )),
                        SizedBox(height: 5),
                        Text("Legs Toning",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            )),
                        SizedBox(height: 5),
                        Text("and Glutes Workout",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            )),
                        SizedBox(height: 25),
                        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Row(children: [
                            Icon(Icons.timer, size: 20, color: Colors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text("60 min",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                            )),
                          ]),
                          Expanded(child: Container()),
                          Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), boxShadow: [
                                BoxShadow(color: Color(0xff0f17ad), blurRadius: 10, offset: Offset(4, 8))
                              ]),
                              child: Icon(Icons.play_circle_fill, color: Colors.white, size: 60))
                        ]),
                      ])),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff0f17ad).withOpacity(0.8),
                        Color(0xFF6985e8).withOpacity(0.9),
                      ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(80),
                      ),
                      boxShadow: [
                        BoxShadow(offset: Offset(5, 10), blurRadius: 20, color: Color(0xFF6985e8).withOpacity(0.2))
                      ]));
  }

  Widget _buildCardSubtitles(Duration duration, var padding) {
    return Row(children: [
      SlideCountdown(
        duration: duration,
        padding: padding,
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
      Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        avatar: Icon(FontAwesomeIcons.users, color: Colors.white, size: 13),
        label: Text(
          widget.challenge.attendants,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: padding,
      ),
    ]);
  }

  _navigateToChallengeInfo(BuildContext context) async {
    await showDialog(
        context: context,
        barrierColor: Color(0x00ffffff),
        builder: (BuildContext context) {
          return ChallengeInfo(challenge: widget.challenge);
        });
    widget.notifyParent();
  }

  _navigateToInfoScreen(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return AddedChallengeInfo(challenge: widget.challenge);
    }));
    widget.notifyParent();
  }
}