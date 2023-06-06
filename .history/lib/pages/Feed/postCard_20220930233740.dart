import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class PostObject {
  String title;
  String description;
  int likes;
  String user;
  String userUid;
  String date;
  String img;
  String section;
  List comments;

  PostObject(this.title, this.description, this.likes, this.user, this.userUid, this.date, this.img,
      this.section, this.comments);

  PostObject.fromMap(Map post)
      : title = post['title'],
        description = post['description'],
        user = post['user'],
        userUid = post['userUid'],
        date = post['date'],
        img = post['img'],
        comments = post['comments'],
        section = post['section'],
        likes = post[''];
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
            children: [Text('')],
          )
        ],
      ),
    );
  }
}
