import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("MoreScreen"));
  }
}
