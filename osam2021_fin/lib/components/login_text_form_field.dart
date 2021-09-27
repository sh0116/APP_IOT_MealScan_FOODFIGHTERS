import 'package:flutter/material.dart' show BorderRadius, BuildContext, Column, CrossAxisAlignment, InputDecoration, OutlineInputBorder, SizedBox, StatelessWidget, Text, TextFormField, Widget;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_login/theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String text;

  const CustomTextFormField(this.text);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text),
        SizedBox(height: 100),
        TextFormField(
          validator: (value) => value!.isEmpty ? "Please enter some text" : null, // 1. 값이 없으면 Please enter some text 경고 화면 표시
          obscureText:
              // 2. 해당 TextFormField가 비밀번호 입력 양식이면 **** 처리 해주기
              widget.text == "Password" ? true : false,
          decoration: InputDecoration(
            hintText: "Enter ${widget.text}",
            enabledBorder: OutlineInputBorder(
              // 3. 기본 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              // 4. 손가락 터치시 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              // 5. 에러발생시 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              // 5. 에러가 발생 후 손가락을 터치했을 때 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
