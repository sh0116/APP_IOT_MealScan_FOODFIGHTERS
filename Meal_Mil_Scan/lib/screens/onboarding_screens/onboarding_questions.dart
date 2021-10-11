import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osam2021/models/user/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:osam2021/models/user/user_model.dart';

class OnboardingQuestions extends StatefulWidget {
  @override
  State<OnboardingQuestions> createState() => _OnboardingQuestionsState();
}

class _OnboardingQuestionsState extends State<OnboardingQuestions> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _serialNumCtrl = TextEditingController();
  final TextEditingController _codeCtrl = TextEditingController();
  String name = '';
  String serialNum = '';
  String codeNum = '';

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
        title: '먼저, 전우님에 대해 알려주세요. ',
        subtitle: '',
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  onSaved: (value) {
                    print("이름");
                  },
                  decoration: InputDecoration(
                      labelText: '이름',
                      labelStyle: TextStyle(color: Colors.black38, fontSize: 12),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '이름은 필수로 입력해주세요.';
                    } else {
                      name = _nameCtrl.text;
                    }
                    return null;
                  },
                  controller: _nameCtrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  onSaved: (value) {
                    print("군번");
                  },
                  decoration: InputDecoration(
                      labelText: '군번 (- 포함)',
                      labelStyle: TextStyle(color: Colors.black38, fontSize: 12),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '군번은 필수로 입력해주세요.';
                    } else {
                      serialNum = _serialNumCtrl.text;
                    }
                    return null;
                  },
                  controller: _serialNumCtrl,
                ),
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return '필수 정보를 입력해주세요.';
          } else {
            serialNum = _codeCtrl.text;
          }
          _formKey.currentState!.save();
        },
      ),
      CoolStep(
        title: '부대 고유코드를 입력해주세요.',
        subtitle: '고유코드는 부대 내에서 전파받을 수 있습니다.',
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  onSaved: (value) {
                    print("고유코드");
                  },
                  decoration: InputDecoration(
                      labelText: '부대 고유코드',
                      labelStyle: TextStyle(color: Colors.black38, fontSize: 12),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '부대 고유코드는 필수입력사항입니다.';
                    } else {
                      codeNum = _codeCtrl.text;
                    }
                    return null;
                  },
                  controller: _codeCtrl,
                ),
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return name;
          } else {
            codeNum = _codeCtrl.text;
          }
          _formKey.currentState!.save();
        },
      ),
    ];

    final stepper = GestureDetector(
      child: CoolStepper(
        showErrorSnackbar: true,
        onCompleted: () {
          print('Steps completed!');
        },
        steps: steps,
        config: CoolStepperConfig(
          icon: Icon(FontAwesomeIcons.circle, size: 1),
          backText: '이전',
          nextText: '다음',
          finalText: '완료하기',
          stepText: '',
          ofText: '/',
          headerColor: Color(0xfffafafa),
          titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20
          )
        ),
      ),
      //to-do: make it so that data gets sent only when the final submit button is clicked.
      onTap: () async {          
        var now = (DateTime.now().millisecondsSinceEpoch).toString();
        var test = 'fas';
        final f = FirebaseFirestore.instance;
        await f
        .collection('USER')
        .doc(test)
        .set({'test':'pass'});
      }
    );
    return Scaffold(body: Container(padding: EdgeInsets.only(top: 30), child: stepper));
  }
}
