import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapi/signUP.dart';
import 'dashBoard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final key = GlobalKey<FormState>();
  bool isVisible = true;
  var data;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  progressDialog() {
    AlertDialog dialog=AlertDialog(
      title: Container(
        color: Colors.white,
        child: Row(
          children: [
            CircularProgressIndicator(backgroundColor: Colors.red,),
            SizedBox(width: 20),
            Text(
              'Please Wait......',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            )
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (context) => dialog);
  }

  Future logInButton() async {
    if (key.currentState.validate()) {
      Map<String, dynamic> map = {
        'email': email.text.trim(),
        'password': password.text.trim(),
      };
      progressDialog();
      http.Response response = await http.post(
          Uri.parse('https://icegamer.000webhostapp.com/api/login.php'),
          body: map);

      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        var id = res['user']['id'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('userId', id);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashBoard(),
          ),
        );
      } else {
        print('data fail to get');
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Card(
            elevation: 10,
            child: Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'LogIn',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'RobotoMono',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: email,
                      validator: (input) =>
                          input.isEmpty ? 'Enter Your Email ID' : null,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: password,
                      obscureText: isVisible,
                      validator: (input) =>
                          input.isEmpty ? 'Enter Your Password' : null,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: isVisible
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    isVisible = false;
                                  });
                                },
                                child: Icon(Icons.visibility_off),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    isVisible = true;
                                  });
                                },
                                child: Icon(Icons.visibility),
                              ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: logInButton,
                      color: Colors.red,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ));
                        },
                        child: Text('Create New Account ?')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
