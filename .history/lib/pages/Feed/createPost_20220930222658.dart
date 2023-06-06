import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  final DataObject dataObject;

  CreatePost({this.dataObject, Key key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      dataObject: widget.dataObject,
      scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
      body: CWListView(

        children: [
 Form(child: tEXTf)
        ],
      ),
    );
  }
}
