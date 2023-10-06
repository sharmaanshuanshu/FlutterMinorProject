import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proofhubmobileapplication/widgets/SnackBar.dart';
import 'LaunchUrlApp.dart';
import 'Password.dart';
import 'package:http/http.dart' as http;

import 'SignupForm.dart';

class Email extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  var userEmail = TextEditingController();
  // bool emailError = false;
  int emailTextLength = 0;
  bool emailBtnPress = true;
  bool isLoading =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 100),
          child: Image.asset(
            'assets/images/proofHub.png',
            width: 100,
            height: 100,
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(20, 30, 0, 30),
            child: Text('Sign in',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
        // Container(
        //   margin: EdgeInsets.fromLTRB(20, 0, 210, 0),
        //   child: Visibility(
        //     visible: emailError,
        //     child: Text(
        //       'Invalid Email',
        //       style: TextStyle(fontSize: 18, color: Colors.red),
        //     ),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
          child: Text(
            'Email',
            style: emailBtnPress
                ? TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)
                : TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Form(
            child: TextField(
              controller: userEmail,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: _onChanged,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 55,
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ElevatedButton(
            child: isLoading? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('Loading...',style: TextStyle(fontSize: 20),),
                // SizedBox(width: 10,),
                CircularProgressIndicator(color: Colors.white,),
              ],
            ):Text('Next',style: TextStyle(fontSize: 18)),
            onPressed: () async {
              var email = userEmail.text.toString();
              if (email.length == 0) {
                setState(() {
                  emailBtnPress = false;
                });
              }
              var response = await http.post(
                  Uri.parse(
                      'https://within.proofhub.com/api/v4/authenticate/valid'),
                  body: {'email': email},
                  headers: {'ver': 'lite'});
              var body = response.body;
              var compData = jsonDecode(body);
              var responseObj = compData['data'];
              var exist = responseObj['exist'];
              if (exist == true) {
                  setState(() {
                    isLoading =true;
                  });
                  Future.delayed(Duration(seconds: 2),(){
                    setState(() {
                      isLoading =false;
                    });
                    navigateToPasswordScreen(context);
                  });
              } else {
                if (exist == false && email.length > 0) {
                  setState(() {
                    isLoading =true;
                  });
                  Future.delayed(Duration(seconds: 2),(){
                    setState(() {
                      isLoading =false;
                      errorMessage(context, 'Invalid Email');
                    });
                  });
                  // setState(() {
                  //   emailError = true;
                  // });
                }
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(160, 20, 0, 0),
          child: Text(
            'or',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 60,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 318,
                height: 70,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset('assets/images/googleIcon.png',
                                height: 30)),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.white)),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 235, 0),
          //color: Colors.green,
          height: 40,
          child: TextButton(
            onPressed: () {
              goToWebPage();
            },
            child: Text(
              'Need help?',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Dont have an account?',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                        child: TextButton(
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupForm()));
                      },
                    ))
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    ));
  }

  Future navigateToPasswordScreen(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Password(email: userEmail.text)));
  }

  _onChanged(String value) {
    setState(() {
      emailTextLength = value.length;
    });
    // if (emailTextLength >= 0) {
    //   emailError = false;
    // }
    if (value.length > 0) {
      emailBtnPress = true;
    }
  }
}
