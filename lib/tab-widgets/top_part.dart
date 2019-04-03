import 'package:flutter/material.dart';

class TopPart extends StatefulWidget {

  final Map<String, dynamic> document;
  final height;

  TopPart({
    @required this.document,
    @required this.height
  });

  @override
  _TopPartState createState() => _TopPartState();
}

class _TopPartState extends State<TopPart> {


  @override
  Widget build(BuildContext context) {
    final height = widget.height * .08;
    print(widget.document['name']);
    return Material(
      elevation: 1,
      child: Container(
        color: Colors.white,
        height: height,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: height * .6,
                    height: height * .6,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.document['profileImage'],
                        )
                      )
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                      widget.document['name'].toString().length > 16 ?
                      widget.document['name'].toString().replaceRange(16, widget.document['name'].toString().length ,"..") :
                      widget.document['name'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.height * 0.045 * 0.5
                      ),)
                ],
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.black,),
                onPressed: () => print('More Options'),
              )
            ],
          ),
        ),
      ),
    );
  }
}