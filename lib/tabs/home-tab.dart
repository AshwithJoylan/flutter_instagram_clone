import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/tab-widgets/posts_tile.dart';
import 'package:fire/tab-widgets/stories.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height,
    width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("Instagram"),
        leading: IconButton(
          icon: Icon(Icons.camera_alt, color: Colors.black,),
          onPressed: () => print("Camera Pressed"),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => print('Settings Pressed'),
          )
        ],
      ),

      body: Container(
        color: Colors.white,
        child: HomeTabBody(
            height: height,
            width: width,
          ),
      ),
    );
  }
}

class HomeTabBody extends StatefulWidget {

  final height, width;

  HomeTabBody({
    @required this.height,
    @required this.width
  });

  @override
  _HomeTabBodyState createState() => _HomeTabBodyState();
}

class _HomeTabBodyState extends State<HomeTabBody> {

   void _refresh(up) async{
    setState(() {
      stories = db.collection('stories').orderBy('date').getDocuments();
      _future = db.collection('posts').orderBy('date').getDocuments();
          Future.delayed(const Duration(milliseconds: 1000)).then(
            (val) => _refreshController.sendBack(true, RefreshStatus.completed)
          );
        }
      );
  }

  //Firebase User
  final user = FirebaseAuth.instance.currentUser();

  
  static final db = Firestore.instance;
  var stories = db.collection('stories').orderBy('date').getDocuments();

  final _refreshController = RefreshController();

  final _headerConfig = RefreshConfig(
    completeDuration: 4,
    triggerDistance: 100.0,

  );

  var _future = db.collection('posts').orderBy('date').getDocuments();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
        
          final doc = snapshot.data.documents;
          
            return Material(
              elevation: 1,
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                headerConfig: _headerConfig,
                onRefresh: _refresh,
                child: ListView.builder(
                  itemCount: doc.length == null ? 0 : doc.length + 1,
                  itemBuilder: (_, index) {
                    if(index == 0) {
                      return Stories(
                        height: widget.height * .13,
                        width: widget.width,
                        user: user,
                        future: stories,
                      );
                    } else {
                      return PostsTile(
                        document:  (doc[index - 1]),
                        height: widget.height,
                      );
                    }
                  },
                ),
              ),
            );
          
        
      },

    );
  }
}


