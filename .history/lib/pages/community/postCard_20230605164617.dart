import 'package:valuid/pages/community/report.dart';
import 'package:valuid/services/database/database.dart';
import 'package:valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/dateFormat/customeDateFormatter.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/extensions/stringExt.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostObject {
  late String title;
  late String description;
  late String user;
  late String userUid;
  late String date;
  late String img;
  late String section;

  late List comments;
  late List likes;
  late List reports = [];

  PostObject();

  PostObject.fromMap(Map post)
      : title = post['title'],
        reports = post['reports'],
        description = post['description'],
        user = post['user'],
        userUid = post['userUid'],
        date = post['date'],
        img = post['img'],
        comments = post['comments'],
        section = post['section'],
        likes = post['likes'];

  Map<String, dynamic> postObjectToMap(PostObject post) => {
        'title': post.title,
        'description': post.description,
        'userUid': post.userUid,
        'user': post.user,
        'img': post.img,
        'section': post.section,
        'reports': post.reports,
        'comments': post.comments,
        'likes': post.likes,
        'date': post.date
      };
}

// ignore: must_be_immutable
class PostCard extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final DataObject dataObject;
  final PostObject post;
  final String feedUid;
  final bool viewAll;
  final BuildContext viewPostContext;
  final bool isFirst;

  PostCard({
    this.dataObject,
    this.post,
    this.feedUid,
    this.viewAll = false,
    this.viewPostContext,
    this.isFirst,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showOptionsPanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: dataObject.context,
          builder: (ctxt) => MainCustomBottomSheet(
                ctxt: ctxt,
                showCreateBtn: false,
                // customHeight: true,
                widget: Ink(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      post.userUid == _auth.currentUser.uid
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(circularRadius),
                                    onTap: () async {
                                      await DatabaseService().feedCollection.doc(feedUid).delete();

                                      if (viewAll) {
                                        Navigator.pop(viewPostContext);
                                      }

                                      Navigator.pop(ctxt);
                                    },
                                    child: Ink(
                                      padding: EdgeInsets.symmetric(vertical: 20),
                                      decoration: CustomDecoration().curvedBaseContainerDecoration,
                                      child: Center(
                                        child: Text('Remove',
                                            style: CustomTextStyles(dataObject.context).holdingValueStyle),
                                      ),
                                    ),
                                  ),
                                ),
                                CustomDivider(),
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
                                Icon(Icons.report, size: iconSize, color: redVarient.withOpacity(.7)),
                                SizedBox(width: 5),
                                Text('Report',
                                    style: CustomTextStyles(dataObject.context)
                                        .holdingValueStyle
                                        .copyWith(color: redVarient.withOpacity(.7))),
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
      decoration:
          CustomDecoration().baseContainerDecoration.copyWith(border: Border.all(color: Colors.transparent)),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'By ' + post.user,
                style: CustomTextStyles(dataObject.context).holdingSubValueStyle,
              ),
              InkWell(
                  borderRadius: BorderRadius.circular(circularRadius),
                  onTap: () => showOptionsPanel(),
                  child: Icon(Icons.more_horiz_rounded, color: iconColour))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              post.title.capitalizeFirst(),
              style: CustomTextStyles(dataObject.context).holdingValueStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 17),
            child: Text(
              post.description.capitalizeFirst(),
              style: CustomTextStyles(dataObject.context).portfolioNameStyle,
              maxLines: viewAll ? 100 : 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(circularRadius),
                        onTap: () async {
                          post.likes.contains(_auth.currentUser.uid)
                              ? post.likes.remove(_auth.currentUser.uid)
                              : post.likes.add(_auth.currentUser.uid);
                          // post.likes.add(_auth.currentUser.uid);

                          // print(PostObject().postObjectToMap(post));
                          await DatabaseService().updateFeed(post: post, feedUid: feedUid);
                        },
                        child: Image.asset(
                          post.likes.contains(_auth.currentUser.uid)
                              ? 'assets/icons/likeOn.png'
                              : 'assets/icons/like.png',
                          width: 22,
                          height: 22,
                          color: post.likes.contains(_auth.currentUser.uid)
                              ? blueVarient
                              : textColorVarient.withOpacity(.7),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        post.likes.length.toString(),
                        style: CustomTextStyles(dataObject.context).holdingValueStyle,
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
                        color: textColorVarient.withOpacity(.7),
                      ),
                      SizedBox(width: 5),
                      Text(
                        post.comments.length.toString(),
                        style: CustomTextStyles(dataObject.context).holdingValueStyle,
                      )
                    ],
                  )
                ],
              ),
              Text(
                CustomDateFormatter().getTimeDifferenceToString(post.date),
                style: CustomTextStyles(dataObject.context).holdingSubValueStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
