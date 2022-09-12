// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/test.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        //accentColor: Colors.white
        //eeeee
      ),
      home: Test()
    );
  }
}


