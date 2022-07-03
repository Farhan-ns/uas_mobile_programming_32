import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_mobile_programming_32/customer/customer_home.dart';
import 'package:uas_mobile_programming_32/models/user.dart';
import 'package:uas_mobile_programming_32/repository.dart';
import 'package:uas_mobile_programming_32/shared_prefs.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({Key? key}) : super(key: key);

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  Repository repository = Repository();
  EdgeInsets formPadding = EdgeInsets.fromLTRB(10, 10, 10, 0);

  @override
  Widget build(BuildContext context) {
    // var user = User(nameController.text, emailController.text);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          padding: formPadding,
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email"),
                          ),
                        ),
                        Container(
                          padding: formPadding,
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Nama"),
                          ),
                        ),
                        Container(
                          padding: formPadding,
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                          ),
                        ),
                        Container(
                          padding: formPadding,
                          child: TextField(
                            controller: confPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Konfirmasi Password"),
                          ),
                        ),
                        Container(
                          padding: formPadding,
                          child: Row(
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
                                    Map<String, String> data = {
                                      'name': nameController.text,
                                      'email': emailController.text,
                                      'password': passwordController.text,
                                      'uploadedFile': '',
                                      'birthPlace': '',
                                      'birthDate': '',
                                      'gender': '',
                                      'address': '',
                                    };
                                    var response = await repository
                                        .postData(jsonEncode(data));
                                    if (response != null) {
                                      User user =
                                          User.fromJson(jsonDecode(response));

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(User.idK, user.id);
                                      prefs.setString(User.emailK, user.email);
                                      prefs.setString(
                                          User.obj, jsonEncode(user));

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomerHome()));
                                    }
                                  },
                                  child: const Text('Register'))
                            ],
                          ),
                        )
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
