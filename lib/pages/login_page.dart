import 'package:fire/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 0.0,
         backgroundColor: Colors.transparent
      ),
      body: LoginForm(),     
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> { 

  String _email = "";
  String _password = "";
  final auth = FirebaseAuth.instance;
  FirebaseUser user;

    Future<Widget> _signIn() async {
    if (_email == "" && _password == "") {
      return Flushbar(
        duration: Duration(seconds: 3),
        titleText: 'Enter Fields with appropriate values',
      );
    }else {
      await auth.signInWithEmailAndPassword(
        email: _email,
        password: _password
      ).then((user) {
        if (user == null) {
          return Flushbar(
            duration: Duration(seconds: 3),
            titleText: 'Login Failed',
          );
        } else {
          return MainScreen(user: user,);
        }
      }).catchError((err) => print(err));
      
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {

    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: _width * 0.7,
          height: _height * 0.07,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(100)
          ),
          child: TextFormField(
            style: TextStyle(
              fontSize: 20.0,
            ),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
              border: InputBorder.none
            ),
            validator: (value) => value.endsWith('@gmail.com') ? null: "PLease Enter Proper Email",
            onSaved: (value) => this._email = value,
          ),
        ),
        SizedBox(height: 20,),
        Container(
              width: _width * 0.7,
              height: _height * 0.07,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black),
                borderRadius: BorderRadius.circular(100)
              ),
              child: TextFormField(
                style: TextStyle(
                fontSize: 20.0,
              ),
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
                  border: InputBorder.none
                ),
                obscureText: true,
                keyboardType: TextInputType.text,
                onSaved: (value) => this._password = value,
              ),
            ),
        SizedBox(height: 20,),
        MaterialButton(
          color: Colors.orange,
          onPressed: _signIn,
          child: Text('Sign In'),
        ),
      ],
    );
  }
}