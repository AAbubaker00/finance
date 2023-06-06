import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  final DataObject dataObject;

  Feed({Key key, this.dataObject}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  DocumentSnapshot feed;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    feed = Provider.of<DocumentSnapshot>(context);

    if

    print(feed.data().toString());

    return Container();
  }
}
