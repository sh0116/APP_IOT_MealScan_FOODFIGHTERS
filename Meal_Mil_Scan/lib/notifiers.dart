import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge.dart';

class Notifiers extends ChangeNotifier {
  final List<Challenge> _added = [];
  final List<Challenge> _opened = open;

  void addChallenge(Challenge challenge) {
    added.add(challenge);
    notifyListeners();
  }

  void deleteChallenge(Challenge challenge) {
    added.remove(challenge);
  }

  void closeChallenge(Challenge challenge) {
    opened.remove(challenge);
  }

  void openChallenge(Challenge challenge) {
    opened.add(challenge);
  }

  List<Challenge> get opened => _opened;
  List<Challenge> get added => _added;
}
