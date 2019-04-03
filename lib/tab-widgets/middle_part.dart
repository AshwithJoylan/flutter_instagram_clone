import 'package:flutter/material.dart';

class MiddlePart extends StatefulWidget {

  final String image;
  final double height;

  MiddlePart({
    @required this.image,
    @required this.height
  });

  @override
  _MiddlePartState createState() => _MiddlePartState();
}

class _MiddlePartState extends State<MiddlePart> {
  @override
  Widget build(BuildContext context) {
    print(widget.image);
    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: NetworkImage(
            widget.image,
          )
        )
      ),
    );
  }
}