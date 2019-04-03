import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Stories extends StatefulWidget {

  final height, width;
  final user;
  final future;

  Stories({
    @required this.height,
    @required this.width,
    @required this.user,
    @required this.future
  }); 

  @override
  _StoriesState createState() => _StoriesState();
}

// Instagram Stories
class _StoriesState extends State<Stories> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Container(
        width: widget.width,
        height: widget.height + 6,
        color: Colors.white,
        child: FutureBuilder(
          future: widget.future,
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
             final doc = snapshot.data.documents;
              print("imagevgvgvgvgvgv"+ doc[0].data['thumbImage']);
              return Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: doc.length == null ? 0 : doc.length  + 1,
                  itemBuilder: (_, index) {
                    return index == 0 ? Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Container(
                      height: widget.height,
                        color: Colors.transparent,
                        child: MaterialButton(
                          color: Colors.transparent,
                            child: Center(
                              child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[ 
                                      Container(
                                      padding: EdgeInsets.all(2),
                                      width: widget.height * .7,
                                      height: widget.height * .7,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        
                                        border: Border.all(color: Colors.red,width: 2.0)
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage (
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                            image: NetworkImage(
                                              doc[0].data['thumbImage']
                                              )
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: widget.height * .5, left: widget.height * .5),
                                        child: Container(
                                          width: widget.height * 0.2,
                                          height: widget.height * 0.2,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                          child: Icon(Icons.add, color: Colors.white, size: widget.height * 0.12,),
                                        )
                                      ),
                                    ]
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text('Your Story', style: TextStyle(
                                      fontSize: widget.height * .14,fontWeight: FontWeight.normal
                                    ),),
                                  )
                                ]
                              ),
                          ),
                            ),
                          highlightColor: Colors.transparent,
                          highlightElevation: 0.0,
                          splashColor: Colors.transparent,
                          height: widget.height,
                          elevation: 0,
                          onPressed: () => print('Story Added'),                      ),
                        ),
                    )
                    : MaterialButton(
                      highlightColor: Colors.transparent,
                      highlightElevation: 0.0,
                      splashColor: Colors.transparent,
                      height: widget.height,
                        elevation: 0,
                        color: Colors.transparent,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(2),
                                  width: widget.height * .7,
                                  height: widget.height * .7,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red, width: 2.0, style: BorderStyle.solid),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                        image: NetworkImage(
                                        doc[index - 1].data['thumbImage']
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    doc[index - 1].data['name'].toString().length > 10 ? 
                                    doc[index - 1].data['name'].toString().replaceRange(10, 
                                    doc[index - 1].data['name'].toString().length, ".."): doc[index - 1].data['name'], style: TextStyle(
                                    fontSize: widget.height * 0.14, fontWeight: FontWeight.normal, 

                                  ),),
                                )
                              ]
                            ),
                          ),
                        ),
                        onPressed: () => print(index),
                    );
                  },
                  
                ),
              );
          },  
        ),
      ),      
    );
  }
}