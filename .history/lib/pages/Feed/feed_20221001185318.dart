import 'package:Valuid/pages/Feed/createPost.dart';
import 'package:Valuid/pages/Feed/postCard.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  final DataObject dataObject;

  Feed({Key key, this.dataObject}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  QuerySnapshot feed;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    feed = Provider.of<QuerySnapshot>(context);

    if (feed != null && feed.docs.isNotEmpty) {
      print(feed.docChanges.first.doc.data());
    }

    return FutureBuilder<bool>(
        future: feed != null && feed.docs.isNotEmpty ? Future.value(true) : Future.value(false),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return CWScaffold(
              dataObject: widget.dataObject,
              appBarTitleWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Community',
                        style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                            .appBarTitleStyle),
                    Image.asset(
                      'assets/icons/notifOn.png',
                      width: 25,
                      height: 25,
                      // color: UserThemes(widget.dataObject.theme).blueVarient,
                    )
                  ],
                ),
              ),
              // scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
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
                            color: widget.dataObject.theme
                                ? Colors.black.withOpacity(.4)
                                : Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                        color: UserThemes(widget.dataObject.theme).blueVarient),
                    padding: EdgeInsets.all(15),
                    child: Image.asset(
                      'assets/icons/add.png',
                      width: 25,
                      height: 25,
                      color: UserThemes(widget.dataObject.theme).summaryColour,
                    )),
              ),
              body: CWListView(
                children: feed.docs.reversed
                    .map((post) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: PostCard(
                            dataObject: widget.dataObject,
                            post: PostObject.fromMap(post.data() as Map),
                          ),
                        ))
                    .toList(),
              ),
            );
          } else {
            return Loading(
              theme: widget.dataObject.theme,
            );
          }
        });
  }
}
