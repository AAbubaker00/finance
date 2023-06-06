import 'package:Valuid/pages/Feed/postCard.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class ViewPost extends StatefulWidget {
  final DataObject dataObject;
  final PostObject post;
  final String feedUid;

  ViewPost({Key key, this.dataObject, this.post, this.feedUid}) : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      
    );
  }
}
