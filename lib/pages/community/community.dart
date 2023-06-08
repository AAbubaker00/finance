// ignore_for_file: unnecessary_null_comparison

import 'package:valuid/pages/community/createPost.dart';
import 'package:valuid/pages/community/postCard.dart';
import 'package:valuid/pages/community/viewPost.dart';
import 'package:valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/pageLoaders/noPosts.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Community extends StatefulWidget {
  final DataObject dataObject;

  Community({required this.dataObject});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  late QuerySnapshot feed;

  @override
  Widget build(BuildContext context) {
    feed = Provider.of<QuerySnapshot>(context);

    return FutureBuilder<bool>(
        future: feed != null ? Future.value(true) : Future.value(false),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return CWScaffold(
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
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: summaryColour,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ]),
                    child: Image.asset(
                      'assets/icons/write.png',
                      width: iconSize,
                      height: iconSize,
                      color: iconColour,
                    )),
              ),
              body: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: feed.docs.isEmpty
                        ? [NoPosts()]
                        : [
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
                                              viewPostContext: context,
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
            return Loading();
          }
        });
  }
}
