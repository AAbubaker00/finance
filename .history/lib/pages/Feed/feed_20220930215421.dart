import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  final DataObject dataObject;

  Feed({Key key, this.dataObject}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  DocumentSnapshot feed;

  init
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
