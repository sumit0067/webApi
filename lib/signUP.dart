import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isVisible = true;

  Future signUp() async {
    if (_key.currentState.validate()) {
      Map<String,dynamic>registerMap={
        'phone': phone.text.trim(),
        'password': password.text.trim(),
        'email': email.text.trim(),
        'name': name.text.trim(),
      };

      http.Response response = await http.post(
          Uri.parse('https://icegamer.000webhostapp.com/api/signup.php'),
          body: registerMap);

      if (response.statusCode ==200) {
        final map =jsonDecode(response.body);
        print('Data is $map');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name';
                    } else if (value.length <= 4 && value.length >= 10) {
                      return 'Please enter min 4 and max 10 character ';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: email,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: isVisible,
                  controller: password,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    } else {
                      return null;
                    }
                  },
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
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: repassword,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please reEnter your password ';
                    } else if (password.text != repassword.text) {
                      return 'password not match';
                    } else {
                      return null;
                    }
                  },
                  obscureText: isVisible,
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
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'ReEnterPassword',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: phone,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your Phone';
                    } else if (value.length != 10) {
                      return 'Enter valid phone number';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Phone',
                  ),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: signUp,
                  color: Colors.green,
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
