import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'auth/SplashScreen.dart';

// MainMethod

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
