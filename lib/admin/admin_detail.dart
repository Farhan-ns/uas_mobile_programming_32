import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:uas_mobile_programming_32/components/appbar.dart';

import 'package:flutter/material.dart';
import 'package:uas_mobile_programming_32/components/cButton.dart';
import 'package:uas_mobile_programming_32/models/user.dart';
import 'package:uas_mobile_programming_32/repository.dart';

class AdminDetail extends StatelessWidget {
  const AdminDetail(this.user, {Key? key}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar('Admin Home'),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            labelInfo('Nama Lengkap: ', user.name),
            labelInfo('Tempat Lahir: ', user.birthPlace),
            labelInfo('Tanggal Lahir: ', user.birthDate),
            labelInfo('Alamat: ', user.address),
          ],
        ),
      )),
    );
  }
}

Widget labelInfo(String label, String info) => Row(
      children: [
        Expanded(
          child: Text(label),
          flex: 1,
        ),
        Expanded(
          child: Text(info),
          flex: 2,
        ),
      ],
    );
