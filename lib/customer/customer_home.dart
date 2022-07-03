import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_mobile_programming_32/components/appbar.dart';
import 'package:uas_mobile_programming_32/components/cButton.dart';
import 'package:uas_mobile_programming_32/components/cTextField.dart';
import 'package:uas_mobile_programming_32/customer/customer_form.dart';
import 'package:uas_mobile_programming_32/customer/customer_login.dart';
import 'package:uas_mobile_programming_32/models/user.dart';
import 'package:uas_mobile_programming_32/shared_prefs.dart';

const EdgeInsets generalPadding = EdgeInsets.all(8.0);

class CustomerHome extends StatefulWidget {
  const CustomerHome({Key? key}) : super(key: key);

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  SharedPref prefs = SharedPref();
  User user = User('', '', '', '', '', '', '', '', '');

  getPrefs() async {
    var obj = await prefs.read(User.obj);
    user = User.fromJson(obj);
    setState(() {});
  }

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const screenPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 2);

    return Scaffold(
      appBar: CAppBar("Test"),
      body: SafeArea(
        child: Container(
          padding: screenPadding,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CButton('Logout', () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove(User.obj);
                  prefs.remove(User.idK);
                  prefs.remove(User.emailK);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const CustomerLogin())));
                })
              ],
            ),
            statusCard(1, 'Pending', user),
            dataCard(context, 3, user),
          ]),
        ),
      ),
    );
  }
}

Widget statusCard(int flex, String status, User user) => Expanded(
    flex: flex,
    child: Card(
      elevation: 5,
      child: Padding(
        padding: generalPadding,
        child: Column(
          children: [
            Row(
              children: [Text('Selamat Datang,  ' + user.name)],
            )
          ],
        ),
      ),
    ));

Widget dataCard(BuildContext context, int flex, User user) => Expanded(
    flex: flex,
    child: Card(
      elevation: 5,
      child: Padding(
        padding: generalPadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CButton(
                    'Edit Biodata',
                    (() => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CustomerForm()))
                        }))
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text('Nama: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(user.name)
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text('Email: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(user.email)
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text('Tempat, Tanggal Lahir: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(user.birthPlace + ',  ' + user.birthDate)
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text('Alamat: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(user.address)
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text('Lampiran: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(user.uploadedFile)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ));
