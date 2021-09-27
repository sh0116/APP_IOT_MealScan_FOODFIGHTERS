import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge.dart';

class Notifiers extends ChangeNotifier {
  final List<Challenge> _added = [];

  void addChallenge(Challenge challenge) {
    added.add(challenge);
    notifyListeners();
  }

  void deleteChallenge(Challenge challenge) {
    added.remove(challenge);
  }

  List<Challenge> get added => _added;
}
