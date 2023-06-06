import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class ViewPost extends StatefulWidget {
  final DataObject dataObject;
  // final Post
  
  ViewPost({Key key, this.dataObject}) : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
