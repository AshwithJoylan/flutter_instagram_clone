import 'package:fire/insta_icons_icons.dart';
import 'package:fire/tab-widgets/middle_part.dart';
import 'package:fire/tab-widgets/top_part.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Posts Tile
class PostsTile extends StatefulWidget {

  final DocumentSnapshot document;
  final double height;

  PostsTile({
    @required this.document,
    @required this.height
  });

  @override
  _PostsTileState createState() => _PostsTileState();
}

class _PostsTileState extends State<PostsTile> {

  final db = Firestore.instance;
  var userId;
  Map<String, dynamic> currentUserDetail;
  var isLiked = false;

  void _likePost() {
    String docId = widget.document.documentID.toString();
    
    db.collection('posts').document(docId).collection('likes').document(userId).setData(
      {
        'name': currentUserDetail['name'],
        'profileImage': currentUserDetail['profileImage']
      }
    ).then((value) {
      print("liked");
      setState(() {
              isLiked = true;
            });
      }  
    );
  }


  @override
  Widget build(BuildContext context) {

    FirebaseAuth.instance.currentUser().then((user) => this.userId = user.uid);
    db.collection('users').document(userId).get().then((doc) {
      this.currentUserDetail = doc.data;
    });
    print(currentUserDetail);
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Container(
        child: Column(
          children: <Widget>[
            TopPart(
              document: widget.document.data,
              height: widget.height,
            ),
            GestureDetector(
              onDoubleTap: _likePost,
                child: MiddlePart(
                height: widget.height * .5,
                image: widget.document.data['image']
                ),
            ),
            BottomPart(
              userId: userId,
              height: widget.height,
              document: widget.document,
              likePost: _likePost,
              isLiked: isLiked,
              currentUser: currentUserDetail,
            ),
          ],
        )
      ),
    );
  }
}

class BottomPart extends StatefulWidget {

  final height;
  final DocumentSnapshot document;
  final likePost;
  final userId;
  final isLiked;
  final currentUser;

  BottomPart({
    @required this.height,
    @required this.document,
    @required this.likePost,
    @required this.userId, 
    @required this.isLiked, 
    @required this.currentUser
  });

  @override
  _BottomPartState createState() => _BottomPartState();
}

class _BottomPartState extends State<BottomPart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LikeCommentBar(
          document: widget.document,
          height: widget.height,
          likePost: widget.likePost,
          userId: widget.userId,
          currentUser: widget.currentUser, 
          isLiked: widget.isLiked,
        )
      ],
    );
  }
}

class LikeCommentBar extends StatefulWidget {

  final height;
  final DocumentSnapshot document;
  final likePost;
  final userId;
  final isLiked;
  final currentUser;

  LikeCommentBar({
    @required this.height,
    @required this.document,
    @required this.likePost,
    @required this.userId,
    @required this.isLiked, 
    @required this.currentUser
  });

  @override
  _LikeCommentBarState createState() => _LikeCommentBarState();
}

class _LikeCommentBarState extends State<LikeCommentBar> {

  final db = Firestore.instance;
  var liked;

  void unLikePost() {
    db.collection('posts').document(widget.document.documentID)
    .collection('likes').document(widget.userId).delete().then(
      (value) {
        print('Unliked');
        setState(() {
          liked = false;
        });
      }
    );
  }

  void likePost() {
    String docId = widget.document.documentID.toString();
    
    db.collection('posts').document(docId).collection('likes').document(widget.userId).setData(
      {
        'name': widget.currentUser['name'],
        'profileImage': widget.currentUser['profileImage']
      }
    ).then((value) {
      print("liked");
      setState(() {
              liked = true;
            });
      }  
    );
  }


  @override
  Widget build(BuildContext context) {

  final height = widget.height * .08;

  db.collection('posts').document(widget.document.documentID)
  .collection('likes').document(widget.userId).get().then(
    (doc) {
      setState(() {
        doc.exists ? liked = true : liked = false;
        print(doc);
      });
    }
  );


  return Column(
      children: <Widget>[
         Material(
        elevation: 1,
        child: Container(
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: liked ? Icon(Icons.favorite, color: Colors.red,size: height * .5,)
                : Icon(Icons.favorite_border, color: Colors.black, size: height * .5),
                onPressed: liked ? 
                unLikePost : likePost,
              ),
              SizedBox(
                width: height * .04,
              ),
              IconButton(
                icon: Icon(Icons.comment, size: height * .5),
                onPressed: () => print("Comment Success"),
              ),
              SizedBox(
                width: height * .04,
              ),
              IconButton(
                icon: Icon(Icons.share, size: height * .5,),
                onPressed: () => print("Shared"),
              ),
            ],
          ),
        ),
        ),
      ),
      LikedBy(
              height: widget.height,
              db: db,
              docId: widget.document.documentID,
            ),
    ]
  );
  }
}

class LikedBy extends StatefulWidget {

  final height;
  final Firestore db;
  final docId;

  const LikedBy({
    Key key, 
    @required this.height,
    @required this.db,
    @required this.docId}) : super(key: key);

  @override
  _LikedByState createState() => _LikedByState();
}

class _LikedByState extends State<LikedBy> {

  List<DocumentSnapshot> doc;
  double height;

  @override
  Widget build(BuildContext context) {

    height = widget.height * .05;
    widget.db.collection('posts').document(widget.docId).collection('likes').getDocuments().then(
      (snapshot) {
        doc = snapshot.documents.sublist(0, snapshot.documents.length > 2 ? 2 : snapshot.documents.length);
      }
    );
    print(doc.length);

    return Container(
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.height * .04),
        child: Row(
          children: <Widget>[
            Container(
              width: 3 * height,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: LikedImages(
                      height: height,
                      imageUrl: doc[0].data['profileImage'],
                    )),
                  ]
                  )
              ),
          ],
        ),
      ),
    );
  }
}

class LikedImages extends StatelessWidget {

  final double height;
  final String imageUrl;

  const LikedImages({Key key, this.height, this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2, style: BorderStyle.solid),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            imageUrl
          )
        )
      ),
    );
  }
}


