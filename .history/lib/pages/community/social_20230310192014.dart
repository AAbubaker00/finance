import 'package:Valuid/pages/community/createPost.dart';
import 'package:Valuid/pages/community/postCard.dart';
import 'package:Valuid/pages/community/viewPost.dart';

import 'package:Valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:Valuid/shared/Custome_Widgets/restricted/restricted.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/ads/ad_helper.dart';
import 'package:Valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class Community extends StatefulWidget {
  final DataObject dataObject;

  Community({Key key, this.dataObject}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  QuerySnapshot feed;

  @override
  Widget build(BuildContext context) {
    feed = Provider.of<QuerySnapshot>(context);

    return FutureBuilder<bool>(
        future: feed != null ? Future.value(true) : Future.value(false),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return CWScaffold(
              dataObject: widget.dataObject,
              appBarTitle: 'Social',
              floatingActionButttonLocation: FloatingActionButtonLocation.endFloat,
              showFloatingBtn: true,
              customFloatingActionButton: true,
              customFloatinfActionButtonWidget: InkWell(
                onTap: () => Navigator.push(
                    context,
                    CustomPageRouteSlideTransition(
                        direction: AxisDirection.left, child: CreatePost(dataObject: widget.dataObject))),
                child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                        color: purpleVarient),
                    padding: EdgeInsets.all(15),
                    child: Image.asset(
                      'assets/icons/add.png',
                      width: 25,
                      height: 25,
                      color: summaryColour,
                    )),
              ),
              body: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: feed.docs.isEmpty
                              ? [
                                  Expanded(
                                    child: Container(
                                        color: summaryColour,
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                                child: Image.asset(
                                              'assets/icons/feed.png',
                                              width: 100,
                                              height: 100,
                                              color: chartTextColour,
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                            Text(
                                              'No posts yet.',
                                              style: CustomTextStyles(
                                                       widget.dataObject.context)
                                                  .holdingValueStyle
                                                  .copyWith(
                                                    color:
                                                        chartTextColour,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Be the first to post on the social.',
                                              style: CustomTextStyles(
                                                       widget.dataObject.context)
                                                  .portfolioNameStyle
                                                  .copyWith(
                                                    color:
                                                        chartTextColour,
                                                  ),
                                            )
                                          ],
                                        )),
                                  )
                                ]
                              : [
                                  checkBannerAdStatus(),
                                  Expanded(
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: feed.docs
                                          .map((DocumentSnapshot post) => Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: InkWell(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      CustomPageRouteSlideTransition(
                                                          direction: AxisDirection.left,
                                                          child: ViewPost(
                                                            feedUid: post.id.toString(),
                                                            post: PostObject.fromMap(post.data() as Map),
                                                            dataObject: widget.dataObject,
                                                          ))),
                                                  child: PostCard(
                                                    // isFirst: (feed.docs.first.data()) == post.data(),
                                                    feedUid: post.id.toString(),
                                                    dataObject: widget.dataObject,
                                                    post: PostObject.fromMap(post.data() as Map),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  )
                                ]),
                    ),
            );
          } else {
            return Loading(
            );
          }
        });
  }
}
