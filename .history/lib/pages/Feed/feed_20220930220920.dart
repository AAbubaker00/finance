import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
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
  DocumentSnapshot feed;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    feed = Provider.of<DocumentSnapshot>(context);

    if (feed != null) {
      print(feed.data().toString());
    }

    return CWScaffold(
      dataObject: widget.dataObject,
      appBarTitle: 'Feed',
      floatingActionButttonLocation: FloatingActionButtonLocation.endFloat,
      showFloatingBtn: true,
      customFloatingActionButton: true,
      customFloatinfActionButtonWidget: InkWell(
        child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: widget.dataObject.theme ? Colors.black.withOpacity(.4) : Colors.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ], borderRadius: BorderRadius.circular(50), color: UserThemes(widget.dataObject.theme).blueVarient),
            padding: EdgeInsets.all(10),
            child: Image.asset(
              'assets/icons/post.png',
              width: 40,
              height: 40,
              color: UserThemes(widget.dataObject.theme).summaryColour,
            )),
      ),
    );
  }
}
