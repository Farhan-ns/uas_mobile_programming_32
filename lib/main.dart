import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uas_mobile_programming_32/customer/customer_login.dart';
import 'package:uas_mobile_programming_32/customer/customer_register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routes = {
      CustomerLogin.routeName: (context) => const CustomerLogin(),
      CustomerRegister.routeName: (context) => const CustomerRegister()
    };

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomerLogin(),
    );
  }
}
