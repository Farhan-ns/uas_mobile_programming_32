import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:uas_mobile_programming_32/components/appbar.dart';

class LoginChoose extends StatefulWidget {
  const LoginChoose({Key? key}) : super(key: key);

  @override
  State<LoginChoose> createState() => _LoginChooseState();
}

class _LoginChooseState extends State<LoginChoose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar('Admin'),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
