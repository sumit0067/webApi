import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {


  const DashBoard({ Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Map<String, dynamic> map = {};

  Future getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.get('userId');
    http.Response response = await http.post(
        Uri.parse('https://icegamer.000webhostapp.com/api/getUser.php'),
        body: {'id': id});
    Map<String, dynamic> map = jsonDecode(response.body);
    if (map['code'] == '200') {
      print('User Data Is here$map');
    } else {
      print('some Error');
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Text('sumit',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
