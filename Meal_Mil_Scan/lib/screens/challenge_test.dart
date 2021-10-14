import 'package:osam2021/firebase/database_challenge.dart';
import 'package:osam2021/firebase/database_images.dart';
import 'package:flutter/material.dart';
import 'package:osam2021/models/challenge/challenge_provider.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key}) : super(key: key);

  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Demo"),
      ),
      body: FutureBuilder(
        future: ChallengeProvider().loadChallenge(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            dataList = snapshot.data as List;
            return buildItems(dataList);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildItems(dataList) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dataList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            dataList[index].name
          ),
          subtitle:  Text(dataList[index].announcement),
          trailing: Text(
            dataList[index].prize,
          ),
        );
      });
}