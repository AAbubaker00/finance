import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class CommentObject {
  String comment;
  String date;
  String userUid;
  List replies;
  List likes;

  CommentObject.fromMap(Map post)
      : comment = post['comment'],
        date = post['date'],
        userUid = post['userUid'],
        likes = post['likes'],
        replies = post['replies'];
}

class CommentCard extends StatelessWidget {
  final DataObject dataObject;
  final Comment

  const CommentCard({Key key, this.dataObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
