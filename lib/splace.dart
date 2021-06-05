import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webapi/login.dart';

import 'dashBoard.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  setUser() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    if (preference.get('userId') != null) {
      Timer(Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashBoard(),
          ),
        );
      });
    } else {
      Timer(Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LogIn(),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setUser();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wep Api',style: TextStyle(color: Colors.black,decoration: TextDecoration.none)),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
