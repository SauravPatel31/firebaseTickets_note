import 'dart:async';
import 'package:firebase_note/home_page.dart';
import 'package:firebase_note/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_const.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      whereToGo();
    });
  }

  void whereToGo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var isLogin = pref.getString(AppConst.USER_ID_KEY);
    if (isLogin != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
