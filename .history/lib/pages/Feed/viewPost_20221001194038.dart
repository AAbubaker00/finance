import 'package:Valuid/pages/Feed/postCard.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:flutter/material.dart';

class ViewPost extends StatefulWidget {
  final DataObject dataObject;
  final PostObject post;
  final String feedUid;

  ViewPost({Key key, this.dataObject, this.post, this.feedUid}) : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitle: '',
      bottomAppBarBorderColour: false,
      dataObject: widget.dataObject,
      body: CWListView(
        children: [
          PostCard(
            viewAll: true,
            feedUid: widget.feedUid,
            dataObject: widget.dataObject,
            post: widget.post,
          ),
          SizedBox(height: 8),
          Container(
            padding: Edge,
            decoration: CustomDecoration(widget.dataObject.theme)
                .baseContainerDecoration
                .copyWith(border: Border.all(color: Colors.transparent)),
                child: Column(
                  children: [
                      Text('Comments',
                        style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                            .appBarTitleStyle),
                  ],
                ),
          )
        ],
      ),
    );
  }
}
