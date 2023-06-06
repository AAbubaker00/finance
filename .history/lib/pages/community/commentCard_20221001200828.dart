import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class CommentObject {
  String comment;
  String date;
  String userUid;
  List replies;

  CommentObject.fromMap(Map post)
      : comment = post['com'],
        date = post['date'],
        userUid = post['userUid'],
        replies = post['replies'];
}

class CommentCard extends StatelessWidget {
  final DataObject dataObject;

  const CommentCard({Key key, this.dataObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
