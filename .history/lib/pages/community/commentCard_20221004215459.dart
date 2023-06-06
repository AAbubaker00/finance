import 'package:Valuid/pages/community/postCard.dart';
import 'package:Valuid/pages/community/report.dart';
import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:Valuid/extensions/stringExt.dart';

class CommentObject {
  String text;
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
                dataObject: dataObject,
                showCreateBtn: false,
                customHeight: true,
                widget: Ink(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      comment.userUid == dataObject.user.uid
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(Units().circularRadius),
                                    onTap: () async {
                                      // print(post.comments.length);

                                      post.comments.remove(orginal);

                                      await DatabaseService()
                                          .feedCollection
                                          .doc(feedUid)
                                          .set(PostObject().postObjectToMap(post));

                                          setSt

                                      Navigator.pop(ctxt);
                                    },
                                    child: Ink(
                                      padding: EdgeInsets.symmetric(vertical: 20),
                                      decoration:
                                          CustomDecoration(dataObject.theme).curvedBaseContainerDecoration,
                                      child: Center(
                                        child: Text('Remove',
                                            style: CustomTextStyles(dataObject.theme, dataObject.context)
                                                .holdingValueStyle),
                                      ),
                                    ),
                                  ),
                                ),
                                CustomDivider(
                                  theme: dataObject.theme,
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
                                      comment: comment,
                                    )));

                            Navigator.pop(ctxt);
                          },
                          borderRadius: BorderRadius.circular(Units().circularRadius),
                          child: Ink(
                            decoration: CustomDecoration(dataObject.theme).curvedBaseContainerDecoration,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.report,
                                    size: Units().iconSize,
                                    color: UserThemes(dataObject.theme).redVarient.withOpacity(.7)),
                                SizedBox(width: 5),
                                Text('Report',
                                    style: CustomTextStyles(dataObject.theme, dataObject.context)
                                        .holdingValueStyle
                                        .copyWith(
                                            color: UserThemes(dataObject.theme).redVarient.withOpacity(.7))),
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
                'By ' + comment.user,
                style: CustomTextStyles(dataObject.theme, dataObject.context).holdingSubValueStyle,
              ),
              InkWell(
                  onTap: () => showOptionsPanel(),
                  child: Icon(Icons.more_horiz_rounded, color: UserThemes(dataObject.theme).iconColour))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 17),
            child: Text(
              comment.text.capitalizeFirst(),
              style: CustomTextStyles(dataObject.theme, dataObject.context).portfolioNameStyle,
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                getTimeDifferenceToString(),
                style: CustomTextStyles(dataObject.theme, dataObject.context).holdingSubValueStyle,
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
