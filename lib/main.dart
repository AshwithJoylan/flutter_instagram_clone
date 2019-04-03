import 'package:fire/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'ash@gmail.com',
      password: '123456'
    );
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[50],
        backgroundColor: Colors.white
      ),
      home: HomePage(),
    );
  }
}