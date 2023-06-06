import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/extensions/stringExt.dart';
import 'package:flutter/material.dart';

class PostObject {
  String title;
  String description;
  List likes;
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

  Map postObjectToMap(PostObject post) => {
        'title': post.title,
        'description': post.description,
        'userUid': post.userUid,
        'user': post.user,
        'img': post..img,
        'section': post.section,
        'comments': post.comments,
        'likes': post.likes,
        'date': post.date
      };
}

class PostCard extends StatelessWidget {
  final DataObject dataObject;
  final PostObject post;
  final String feedUid;

  PostCard({
    Key key,
    this.dataObject,
    this.post,
    this.feedUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(feedUid);
    return InkWell(
      onTap: () => print('s'),
      child: Ink(
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
                  'By ' + post.user,
                  style: CustomTextStyles(dataObject.theme, dataObject.context).holdingSubValueStyle,
                ),
                Text(
                  getTimeDifferenceToString(),
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
              padding: const EdgeInsets.only(top: 10.0, bottom: 17),
              child: Text(
                post.description.capitalizeFirst(),
                style: CustomTextStyles(dataObject.theme, dataObject.context).portfolioNameStyle,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () async { post.likes.add(data) await DatabaseService().feedCollection.doc(feedUid).set(data)},
                      child: Image.asset(
                        'assets/icons/like.png',
                        width: 20,
                        height: 20,
                        color: post.likes.contains(post.userUid)
                            ? UserThemes(dataObject.theme).goldVarient
                            : UserThemes(dataObject.theme).textColorVarient.withOpacity(.7),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      post.likes.length.toString(),
                      style: CustomTextStyles(dataObject.theme, dataObject.context).holdingValueStyle,
                    )
                  ],
                ),
                SizedBox(width: 15),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/comment.png',
                      width: 19,
                      height: 19,
                      color: UserThemes(dataObject.theme).textColorVarient.withOpacity(.7),
                    ),
                    SizedBox(width: 5),
                    Text(
                      post.comments.length.toString(),
                      style: CustomTextStyles(dataObject.theme, dataObject.context).holdingValueStyle,
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
      return difference.inDays.toInt().toString() + ' days ago';
    } else if (difference.inHours <= 24 && difference.inHours >= 1) {
      return difference.inHours.toInt().toString() + ' hours ago';
    } else if (difference.inMinutes <= 60 && difference.inMinutes >= 1) {
      return difference.inMinutes.toInt().toString() + ' minutes ago';
    } else {
      return difference.inSeconds.toString() + ' seconds';
    }
  }
}
