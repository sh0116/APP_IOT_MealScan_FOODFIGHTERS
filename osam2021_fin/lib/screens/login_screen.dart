// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'challenge_screen.dart';

// const users = const {
//   'dribbble@gmail.com': '12345',
//   'hunter@gmail.com': 'hunter',
// };

// //refer to https://pub.dev/packages/flutter_login for instructions on this package
// class LoginScreen extends StatelessWidget {
//   Duration get loginTime => Duration(milliseconds: 2250);

//   Future<String> _authUser(LoginData data) {
//     print('Name: ${data.name}, Password: ${data.password}');
//     return Future.delayed(loginTime).then((_) {
//       if (!users.containsKey(data.name)) {
//         return 'User not exists';
//       }
//       if (users[data.name] != data.password) {
//         return 'Password does not match';
//       }
//     });
//     return null;
//   }

//   Future<String> _recoverPassword(String name) {
//     print('Name: $name');
//     return Future.delayed(loginTime).then((_) {
//       if (!users.containsKey(name)) {
//         return 'User not exists';
//       }
//     });
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       title: 'ECORP',
//       logo: 'military cafeteria',
//       onLogin: _authUser,
//       onSignup: _authUser,
//       onSubmitAnimationCompleted: () {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => ChallengeScreen(),
//         ));
//       },
//       onRecoverPassword: _recoverPassword,
//     );
//   }
// }
