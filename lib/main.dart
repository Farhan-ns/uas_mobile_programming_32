import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_mobile_programming_32/customer/customer_form.dart';
import 'package:uas_mobile_programming_32/customer/customer_home.dart';
import 'package:uas_mobile_programming_32/customer/customer_login.dart';
import 'package:uas_mobile_programming_32/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString(User.emailK);
  var loggedIn = (email == null ? false : true);
  runApp(MyApp(loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;

  const MyApp(this.loggedIn, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var home = (loggedIn ? CustomerHome() : CustomerLogin());

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home,
    );
  }
}
