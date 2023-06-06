import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final DataObject dataObject;
  final 

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
