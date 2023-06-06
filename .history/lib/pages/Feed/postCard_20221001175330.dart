import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/extensions/stringExt.dart';
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
    return InkWell(
      onTap: () => print('s'),
      child: Container(
        decoration: CustomDecoration(dataObject.theme)
            .baseContainerDecoration
            .copyWith(border: Border.all(color: Colors.transparent)),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post.user,
                  style: CustomTextStyles(dataObject.theme, dataObject.context).holdingSubValueStyle,
                ),
                Text(
                  DateTime.now().difference(DateTime.parse(post.date)).toString(),
                  style: CustomTextStyles(dataObject.theme, dataObject.context).holdingSubValueStyle,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                post.title.capitalizeFirst(),
                style: CustomTextStyles(dataObject.theme, dataObject.context).holdingValueStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 15),
              child: Text(
                post.description,
                style: CustomTextStyles(dataObject.theme, dataObject.context).portfolioNameStyle,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
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
                    Text(
                      post.likes.toString(),
                      style: CustomTextStyles(dataObject.theme, dataObject.context).holdingSubValueStyle,
                    )
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
                    Text(
                      post.comments.length.toString(),
                      style: CustomTextStyles(dataObject.theme, dataObject.context).holdingSubValueStyle,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getTimeDifferenceToString() {
    Duration difference = DateTime.now().difference(DateTime.parse(post.date));

    if (difference.inDays >= 1) {
      return difference.inDays.toInt().toString();
    } else if (difference.inHours <= 24 && difference.inHours >= 1) {
      return difference.inHours.toInt().toString();
    }else if()

    return '';
  }
}
