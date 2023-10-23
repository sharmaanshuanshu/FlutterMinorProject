import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proofhubmobileapplication/auth/SignupForm.dart';
import 'package:proofhubmobileapplication/widgets/SnackBar.dart';
import 'Email.dart';
import 'LaunchUrlApp.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  final textKey = GlobalKey<_HomeScreenState>;

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  var accountUrlText = TextEditingController();
  int accountTextLength = 0;
  // bool accountError = false;
  bool accUrlBtnpressed = true;
  dynamic snackBarContext;

  @override
  Widget build(BuildContext context) {
    snackBarContext = context;
    return Scaffold(
      body: ListView(children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Image.asset(
            'assets/images/proofHub.png',
            width: 100,
            height: 100,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 50, 0, 30),
          child: Text(
            'Sign in',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        // Container(
        //   margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
        //   child: Visibility(
        //     visible: accountError,
        //     child: Text(
        //       'Account URL/Custom domain is \nincorrect',
        //       style: TextStyle(fontSize: 18, color: Colors.red),
        //     ),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
          child: Text(
            'Account Url',
            style: accUrlBtnpressed
                ? TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)
                : TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
            // style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500
            // ),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Form(
              child: TextFormField(
                controller: accountUrlText,
                decoration: InputDecoration(
                    // labelText: 'Company Url',
                    border: OutlineInputBorder()),
                onChanged: _onChanged,
              ),
            )),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 55,
          // width: 200,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: ElevatedButton(
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text('Loading...', style: TextStyle(fontSize: 20),),
                      // SizedBox(width: 10,),
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  )
                : Text('Next', style: TextStyle(fontSize: 18)),
            onPressed: () async {
              var url = 'https://';
              var phLoginUrl = accountUrlText.text.toString();
              if (phLoginUrl.length == 0) {
                setState(() {
                  accUrlBtnpressed = false;
                  isLoading = false;
                });
              }
              var compUrl = '${url}${phLoginUrl}';
              var response = await http.post(
                  Uri.parse(
                      '${compUrl.trim()}.proofhub.com/api/v4/authenticate/company'),
                  headers: {
                    'Content-Type': 'application/json',
                    'X-API-KEY': '7bf004c161c903c98082a5b270d48e924912a99a'
                  });
              var body = response.body;
              var compData = jsonDecode(body);
              if (compData['success'] == true) {
                setState(() {
                  isLoading = true;
                });
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    isLoading = false;
                  }); navigateToEmailScreen(context);
    });

              }
              else {
                setState(() {
                  isLoading = true;
                });
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    isLoading = false;
                    errorMessage(context, 'Invalid Account Url');
                  });
                });
                // setState(() {
                //   accountError = true;
                // });
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 235, 0),
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
          margin: EdgeInsets.fromLTRB(0, 160, 0, 0),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupForm()));
                },
              ))
            ],
          ),
        )
      ]),
    );
  }

  Future navigateToEmailScreen(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Email()));
  }

  _onChanged(String value) {
    setState(() {
      accountTextLength = value.length;
    });
    // if (accountTextLength >= 0) {
    //   accountError = false;
    // }
    if (value.length > 0) {
      setState(() {
        accUrlBtnpressed = true;
      });
    }
  }
}
