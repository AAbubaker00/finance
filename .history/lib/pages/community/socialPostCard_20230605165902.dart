import 'package:valuid/pages/community/postCard.dart';
import 'package:valuid/pages/community/report.dart';
import 'package:valuid/services/database/database.dart';
import 'package:valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valuid/extensions/stringExt.dart';

class CommentObject {
  late String text;
  String date;
  String userUid;
  String user;

  List replies;
  List likes;
  List reports;

  CommentObject();

  CommentObject.fromMap(Map comment)
      : text = comment['text'],
        date = comment['date'],
        userUid = comment['userUid'],
        user = comment['user'],
        likes = comment['likes'],
        reports = comment['reports'],
        replies = comment['replies'];

  Map commentObjectToMap(CommentObject comment) => {
        'date': comment.date,
        'replies': comment.replies,
        'likes': comment.likes,
        'reports': comment.reports,
        'text': comment.text,
        'user': comment.user,
        'userUid': comment.userUid,
      };
}

class CommentCard extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final DataObject dataObject;
  final CommentObject comment;
  final String feedUid;
  final PostObject post;
  final Map orginal;

  CommentCard({Key key, this.dataObject, this.comment, this.feedUid, this.post, this.orginal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showOptionsPanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: dataObject.context,
          builder: (ctxt) => MainCustomBottomSheet(
                ctxt: ctxt,
                showCreateBtn: false,
                customHeight: true,
                widget: Ink(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      comment.userUid == _auth.currentUser.uid
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(circularRadius),
                                    onTap: () async {
                                      // print(post.comments.length);

                                      post.comments.remove(orginal);

                                      await DatabaseService().updateFeed(
                                        post: post,
                                        feedUid: feedUid,
                                      );

                                      Navigator.pop(
                                        ctxt,
                                      );

                                      Navigator.pop(
                                        context,
                                      );
                                    },
                                    child: Ink(
                                      padding: EdgeInsets.symmetric(vertical: 20),
                                      decoration:
                                          CustomDecoration().curvedBaseContainerDecoration,
                                      child: Center(
                                        child: Text('Remove',
                                            style: CustomTextStyles( dataObject.context)
                                                .holdingValueStyle),
                                      ),
                                    ),
                                  ),
                                ),
                                CustomDivider(
                                ),
                              ],
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                CustomPageRouteSlideTransition(
                                    direction: AxisDirection.left,
                                    child: Report(
                                      dataObject: dataObject,
                                      feedUid: feedUid,
                                      post: post,
                                      comment: orginal,
                                    )));

                            Navigator.pop(ctxt);
                          },
                          borderRadius: BorderRadius.circular(circularRadius),
                          child: Ink(
                            decoration: CustomDecoration().curvedBaseContainerDecoration,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.report,
                                    size: iconSize,
                                    color: redVarient.withOpacity(.7)),
                                SizedBox(width: 5),
                                Text('Report',
                                    style: CustomTextStyles( dataObject.context)
                                        .holdingValueStyle
                                        .copyWith(
                                            color: redVarient.withOpacity(.7))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
    }

    return Ink(
      decoration: CustomDecoration()
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
                'By ' + comment.user,
                style: CustomTextStyles( dataObject.context).holdingSubValueStyle,
              ),
              InkWell(
                  borderRadius: BorderRadius.circular(circularRadius),
                  onTap: () => showOptionsPanel(),
                  child: Icon(Icons.more_horiz_rounded, color: iconColour))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 17),
            child: Text(
              comment.text.capitalizeFirst(),
              style: CustomTextStyles( dataObject.context).portfolioNameStyle,
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                getTimeDifferenceToString(),
                style: CustomTextStyles( dataObject.context).holdingSubValueStyle,
              ),
            ],
          )
        ],
      ),
    );
  }

  getTimeDifferenceToString() {
    Duration difference = DateTime.now().difference(DateTime.parse(comment.date));

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
