import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_mobile_programming_32/components/appbar.dart';
import 'package:uas_mobile_programming_32/components/ctextField.dart';
import 'package:uas_mobile_programming_32/customer/customer_home.dart';
import 'package:uas_mobile_programming_32/customer/customer_register.dart';
import 'package:uas_mobile_programming_32/models/user.dart';
import 'package:uas_mobile_programming_32/repository.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({Key? key}) : super(key: key);

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<User> users = [];
  Repository repo = Repository();

  getData() async {
    users = await repo.getData();
    setState(() {});
  }

  Future<bool> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = emailController.text;
    var password = passwordController.text;

    User user;
    Iterable<User> result = users.where(
        (element) => element.email == email && element.password == password);

    if (result.length > 0) {
      user = result.first;

      prefs.setString(User.idK, user.id);
      prefs.setString(User.emailK, user.email);
      prefs.setString(User.passwordK, user.password);
      prefs.setString(User.obj, jsonEncode(user));
      return true;
    } else {
      print('user not found');
    }
    return false;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets formPadding = EdgeInsets.fromLTRB(10, 10, 10, 0);
    emailController.text = 'farhanunnasih@gmail.com';
    passwordController.text = 'farhan123';

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CTextField('Email', emailController),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CTextField(
                            'Password',
                            passwordController,
                            obscureText: true,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerRegister()));
                              },
                              child: Text('Belum punya akun? Daftar'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.fromLTRB(
                                              30, 12, 30, 12)),
                                ),
                                onPressed: () async {
                                  bool success = await login();
                                  if (success) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerHome()));
                                  }
                                },
                                child: const Text('Login'))
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
