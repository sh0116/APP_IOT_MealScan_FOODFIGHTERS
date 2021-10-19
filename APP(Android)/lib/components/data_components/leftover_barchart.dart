import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:animated_widgets/animated_widgets.dart';


class LeftoverBarchart extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => LeftoverBarchartState();
}

class LeftoverBarchartState extends State<LeftoverBarchart> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 1000);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff81e5cd),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    '저번 주 잔반',
                    style: TextStyle(color: const Color(0xff0f4a3c), fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '100에 가까울 수록 잔반이 적은거에요.',
                    style: TextStyle(color: const Color(0xff379982), fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: 
                        BarChart(
                        isPlaying ? mainBarData() : initData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: isPlaying ? SizedBox(height: 0) : 
                ShakeAnimatedWidget(
                  enabled: true,
                  shakeAngle: Rotation.deg(z: 30),
                  curve: Curves.linear,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_circle_fill,
                      color: const Color(0xff0f4a3c),
                      size: 30
                    ),
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                        if (isPlaying) {
                          refreshState();
                        }
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched
              ? [
                  Colors.yellow
                ]
              : [
                  barColor
                ],
          width: width,
          borderSide: isTouched ? BorderSide(color: Colors.yellow, width: 1) : BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            colors: [
              barBackgroundColor
            ],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 100, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 50, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 77, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 76, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 90, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 50, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 60, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });


  BarChartData initData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 16,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return '월';
                case 1:
                  return '화';
                case 2:
                  return '수';
                case 3:
                  return '목';
                case 4:
                  return '금';
                case 5:
                  return '토';
                case 6:
                  return '일';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(
            showTitles: false,
          ),
          topTitles: SideTitles(
            showTitles: false,
          ),
          rightTitles: SideTitles(
            showTitles: false,
          )),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 0, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, 0, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, 0, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, 0, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, 0, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, 0, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, 0, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }    

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '월요일';
                  break;
                case 1:
                  weekDay = '화요일';
                  break;
                case 2:
                  weekDay = '수요일';
                  break;
                case 3:
                  weekDay = '목요일';
                  break;
                case 4:
                  weekDay = '금요일';
                  break;
                case 5:
                  weekDay = '토요일';
                  break;
                case 6:
                  weekDay = '일요일';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions || barTouchResponse == null || barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '월';
              case 1:
                return '화';
              case 2:
                return '수';
              case 3:
                return '목';
              case 4:
                return '금';
              case 5:
                return '토';
              case 6:
                return '일';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 16,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return '월';
                case 1:
                  return '화';
                case 2:
                  return '수';
                case 3:
                  return '목';
                case 4:
                  return '금';
                case 5:
                  return '토';
                case 6:
                  return '일';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(
            showTitles: false,
          ),
          topTitles: SideTitles(
            showTitles: false,
          ),
          rightTitles: SideTitles(
            showTitles: false,
          )),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 6, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 6, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 6, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 6, barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});

    await Future<dynamic>.delayed(animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
