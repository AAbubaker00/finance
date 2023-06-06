import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
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
        likes = post['likes'];
}

class PostCard extends StatelessWidget {
  final DataObject dataObject;
  final PostObject post;

  PostCard({Key key, this.dataObject, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomDecoration(dataObject.theme)
          .baseContainerDecoration
          .copyWith(border: Border.all(color: Colors.transparent)),
          padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(post.user,style: CustomTextStyles(dataObject.theme, widget.dataObject.context)
                              .holdingSubValueStyle, ,),
              Text(DateTime.now().difference(DateTime.parse(post.date)).toString())
            ],
          ),
          Text(post.title),
          Text(post.description),
          Row(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/like.png',
                    width: 20,
                    height: 20,
                    color: UserThemes(dataObject.theme).iconColour,
                  ),
                  Text(post.likes.toString())
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/comment.png',
                    width: 20,
                    height: 20,
                    color: UserThemes(dataObject.theme).iconColour,
                  ),
                  Text(post.comments.length.toString())
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
