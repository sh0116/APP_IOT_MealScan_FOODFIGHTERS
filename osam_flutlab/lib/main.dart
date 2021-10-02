import 'package:osam2021/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:osam2021/models/challenge.dart';
import 'package:osam2021/notifiers.dart';

void main() {
  runApp(MyApp());
}

//https://www.youtube.com/watch?v=svQOxQde0bg
//https://www.youtube.com/watch?v=hTg4DDl8Ixo
//https://www.youtube.com/watch?v=hTg4DDl8Ixo
//swipe 하고 add swipe이면 toast 보이기
//rating dialog
//https://pub.dev/packages/fl_chart
//https://stackoverflow.com/questions/56840994/how-to-show-icon-in-text-widget-in-flutter
//https://stackoverflow.com/questions/51825779/blur-background-behind-dialog-flutter
//https://flutter.dev/docs/cookbook/gestures/dismissible
//animate plus to check
//profile : https://github.com/flutter-coder/flutter-ui-book1/blob/master/flutter_profile/lib/components/profile_buttons.dart
//figma: https://www.figma.com/file/p1Ln3TPyICmkYXUJTXS2bI/Untitled?node-id=0%3A1
//time picker: https://flutterawesome.com/a-flutter-widget-that-wraps-a-textformfield-and-integrates-the-date-picker-dialogs/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Notifiers>(
      create: (_) => Notifiers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SpoqaHanSansNeo',
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        home: MainScreen(),
      ),
    );
  }
}
