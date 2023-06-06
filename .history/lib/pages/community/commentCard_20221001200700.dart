import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class CommentObject {
  String comment;
  String date;
  String userUid;
  List replies;

  CommentObject.fromMap()
}

class CommentCard extends StatelessWidget {
  final DataObject dataObject;

  const CommentCard({Key key, this.dataObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
