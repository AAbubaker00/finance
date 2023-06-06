import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
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
  final CommentObject comment;

  var post;

  const CommentCard({Key key, this.dataObject, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
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
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(Units().circularRadius),
                    onTap: () async {
                      post.likes.contains(dataObject.user.uid)
                          ? post.likes.remove(dataObject.user.uid)
                          : post.likes.add(dataObject.user.uid);
                      // post.likes.add(dataObject.user.uid);

                      // print(PostObject().postObjectToMap(post));
                      await DatabaseService()
                          .feedCollection
                          .doc(feedUid)
                          .set(PostObject().postObjectToMap(post));
                    },
                    child: Image.asset(
                      post.likes.contains(dataObject.user.uid)
                          ? 'assets/icons/likeOn.png'
                          : 'assets/icons/like.png',
                      width: 22,
                      height: 22,
                      color: post.likes.contains(dataObject.user.uid)
                          ? UserThemes(dataObject.theme).blueVarient
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
