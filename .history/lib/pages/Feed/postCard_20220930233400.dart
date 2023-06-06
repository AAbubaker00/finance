import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class PostObject {
  final String title;
  final String description;
  final int likes;
  final String user;
  final String userUid;
  final String date;
  final String img;
  final String section;
  final List comments;

  PostObject(
      this.title, this.description, this.likes, this.user, this.userUid, this.date, this.img, this.section, this.comments);

      PostObject
}

class PostCard extends StatefulWidget {
  final DataObject dataObject;
  final Map post;

  PostCard({Key key, this.dataObject, this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [Text()],
          )
        ],
      ),
    );
  }
}
