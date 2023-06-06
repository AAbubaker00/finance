import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final DataObject dataObject;

  PostCard({Key key, this.dataObject}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
