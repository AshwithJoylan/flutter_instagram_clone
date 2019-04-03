
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  final FirebaseUser user;
  MainScreen({this.user});
  
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fire Base Basics"),
        centerTitle: true,
      ),
      body: MYPage(),
    );
  }
}

class MYPage extends StatefulWidget {
  @override
  _MYPageState createState() => _MYPageState();
}

class _MYPageState extends State<MYPage> {
  String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) => this.name = value,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            MaterialButton(
              color: Colors.orange,
              child: Text("Add", style: TextStyle(
                color: Colors.white
              ),),
              onPressed: () {
                Map<String, dynamic> name = {
                  'name': this.name,
                };
                Firestore.instance.collection("users").add({"name": name}).then((result) {
                  return SnackBar(
                    content: Text("Added"),
                    duration: Duration(seconds: 2),
                  );
                });
              }
            ),
          ],
        ),
      ),
        Expanded(
          child: BotomPart()
          ),
      ],
    );
  }
}



class BotomPart extends StatefulWidget {
  @override
  _BotomPartState createState() => _BotomPartState();
}

class _BotomPartState extends State<BotomPart> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('users').orderBy('name').snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (_, index) {
              var name = snapshot.data.documents[index].data['name']['name'];
              return Column(
                  children: <Widget>[ListTile(
                    title: Center(child: Text(name)),
                  ),
                  Divider(height: 0.5,)
                ]
              );
            },
          );
        }
      },
    );
  }
}