import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uas_mobile_programming_32/models/user.dart';

class Repository {
  final _userEndpoint = 'https://62c00e86d40d6ec55cca0f37.mockapi.io/users';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_userEndpoint));
      if (response.statusCode == 200) {
        Iterable iterable = jsonDecode(response.body);
        // iterable.forEach((element) {
        //   print(element);
        // });
        List<User> users = iterable.map((e) => User.fromJson(e)).toList();
        return users;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(Map<String, String> data) async {
    try {
      final response = await http.post(Uri.parse(_userEndpoint), body: data);
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
