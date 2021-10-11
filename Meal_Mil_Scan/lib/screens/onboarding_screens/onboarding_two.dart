import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:osam2021/models/user/user_provider.dart';
import 'package:provider/provider.dart';

class OnboardingTwo extends StatefulWidget {
  @override
  State<OnboardingTwo> createState() => _OnboardingTwoState();
}

//https://stackoverflow.com/questions/58117205/flutter-best-way-to-get-all-values-in-a-form
class _OnboardingTwoState extends State<OnboardingTwo> {
  final _formKey = GlobalKey<FormState>();
  String? selectedRole = 'Writer';
  String? name;
  String? service_no;
  String? password;
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _numCtrl = TextEditingController();
  TextEditingController _codeCtrl = TextEditingController();
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
              _buildTextField(
                labelText: '이름',
                validator: (value) {
                  if (value!.isEmpty) {
                    return '이름은 필수로 입력해주세요.';
                  }
                  return null;
                },
                controller: _nameCtrl,
              ),
              _buildTextField(
                labelText: '군번 (- 포함)',
                validator: (value) {
                  if (value!.isEmpty) {
                    return '군번은 필수로 입력해주세요.';
                  }

                  return null;
                },
                controller: _numCtrl,
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return '필수 정보를 입력해주세요.';
          }

          return null;
        },
      ),
      CoolStep(
        title: '부대 고유코드를 입력해주세요.',
        subtitle: '고유코드는 부대 내에서 전파받을 수 있습니다.',
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                labelText: '부대 고유코드',
                validator: (value) {
                  if (value!.isEmpty) {
                    return '이름은 필수로 입력해주세요.';
                  }
                  if (!value.contains('-')) {
                    return '군번은 - 를 포함하여 입력해주세요.';
                  }
                  return null;
                },
                controller: _codeCtrl,
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return '부대 고유코드를 입력해주세요. 코드 없이는 챌린지에 참여할 수 없습니다.';
          }
          return null;
        },
      ),
    ];
    final stepper = GestureDetector(
        child: CoolStepper(
          showErrorSnackbar: false,
          onCompleted: () {
            print('Steps completed!');
          },
          steps: steps,
          config: CoolStepperConfig(
              backText: '이전', nextText: '다음', finalText: '완료하기'),
        ),
        onTap: () async {          
          var p = Provider.of<UserProvider>(context);
          name = _nameCtrl.text;
          service_no = _numCtrl.text;
          password = _codeCtrl.text;
          print("test1");
          await p.send(name, service_no, password);
          print("test2");
        });
    return Scaffold(body: Container(child: stepper));
  }

  Widget _buildTextField({
    String? labelText,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }
}
