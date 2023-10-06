import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proofhubmobileapplication/widgets/SnackBar.dart';
import '../me/Me.dart';
import 'LaunchUrlApp.dart';
import 'SignupForm.dart';

class Password extends StatefulWidget {
  String email;
  Password({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Password> {
  bool isLoading = false;
  // bool passBtnErr = true;
  int passTextLength =0;

  @override
  Widget build(BuildContext context) {
    var password = TextEditingController();
    var _email = widget.email;
    var userEmail = TextEditingController(text: _email);
    return Scaffold(
        body: Center(
      child: ListView(children: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 40),
            child: Image.asset(
              'assets/images/proofHub.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 10, 0, 0),
          child: Text(
            'Sign in',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(22, 20, 18, 0),
          child: TextField(
            enabled: false,
            controller: userEmail,
            style: TextStyle(fontWeight: FontWeight.w900),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 30, 0, 0),
          child: Text(
            'Password',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(22, 10, 18, 10),
            child: TextField(
              controller: password,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              // onChanged: _chnage,
            ),
          ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 15, 0),
          child: SizedBox(
            height: 60,
            width: 325,
            child: ElevatedButton(
              child: isLoading? CircularProgressIndicator( color: Colors.white):
                Text(
                  'Next',
                  style: TextStyle(fontSize: 16),
                ),
              onPressed: () async {
                var pass = password.text.toString();

                // if(pass.length == 0){
                //   setState(() {
                //     passBtnErr = false;
                //   });
                // }

                var userEmail = _email;
                var userPass = userEmail + ':' + pass;
                var auth = base64.encode(utf8.encode(userPass));
                var response = await http.post(
                  Uri.parse(
                      'https://within.proofhub.com/api/v4/authenticate/user'),
                  headers: {
                    'Authorization': 'Basic ' + auth,
                    'Content-Type': 'application/json',
                  },
                );
                var body = response.body;
                var compData = jsonDecode(body);
                print(compData);

                if(compData['success'] == true){
                  setState(() {
                    isLoading = true;
                  });
                  Future.delayed(Duration(seconds: 2),(){
                    setState(() {
                      isLoading = false;
                    });
                    navigateToMeScreen(context);
                  });
                }
                else{
                  if(compData['success'] == false && pass.length > 0){
                    setState(() {
                      isLoading = true;
                    });
                    Future.delayed(Duration(seconds: 2),(){
                      setState(() {
                        isLoading = false;
                      });
                      errorMessage(context, 'Invalid Password');
                    });
                  }
                }
              },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(170, 30, 0, 0),
          child: Text('or',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
          width: 320,
          height: 60,
          margin: EdgeInsets.fromLTRB(20, 20, 15, 0),
          child: ElevatedButton(
            onPressed: () {},
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/googleIcon.png',
                    height: 30,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                )
              ],
            ),
            style: ElevatedButton.styleFrom(primary: Colors.white),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 60, 0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: TextButton(
                  onPressed: () {
                    goToWebPage();
                  },
                  child: Text('Need Help?', style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 60, 0, 20),
                child: Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: TextButton(
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupForm()));
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }

  Future navigateToMeScreen(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Me()));
  }

  // void _chnage(String value) {
  //     passTextLength = value.length;
  //     print(passTextLength);
  //     if(passTextLength > 0){
  //       setState(() {
  //         passBtnErr = true;
  //       });
  //     }
  // }
}
