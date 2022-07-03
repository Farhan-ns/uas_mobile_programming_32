import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:uas_mobile_programming_32/admin/admin_detail.dart';
import 'package:uas_mobile_programming_32/components/appbar.dart';

import 'package:flutter/material.dart';
import 'package:uas_mobile_programming_32/components/cButton.dart';
import 'package:uas_mobile_programming_32/models/user.dart';
import 'package:uas_mobile_programming_32/repository.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Repository repo = Repository();
  List<User> users = [];

  getData() async {
    users = await repo.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar('Admin Home'),
      body: SafeArea(
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('${users[index].name}'),
                    subtitle:
                        Text('Status Pengajuan: ${users[index].flagPengajuan}'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AdminDetail(users[index]),
                                ));
                          },
                          child: Text('Detail')),
                      TextButton(
                          onPressed: () {}, child: Text('Approve Pengajuan'))
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
