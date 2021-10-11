import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:osam2021/models/user/user_model.dart';

class UserProvider extends ChangeNotifier {
  static const String USER = 'USER';

  UserProvider(this.name, this.service_no, this.password);
  final String? name;
  final String? service_no;
  final String? password;

  Future send(name, service_no, password) async {
    
    final g = FirebaseFirestore.instance;
    await g.collection('USER').doc('test').set({'123':'456'});
    var now = DateTime.now().millisecondsSinceEpoch;
    final f = FirebaseFirestore.instance;
    await f
        .collection(USER)
        .doc('now.toString()')
        .set(User(name, service_no, password, now).toJson());
  }
}
