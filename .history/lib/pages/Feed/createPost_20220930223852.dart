import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/inputDecoration/inputDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
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
      appbarColourOption: 2,
      appBarTitle: 'Create post',
      scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
      body: CWListView(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      validator: (txt) => txt.isEmpty ? 'Post cannot be empty' : null,
                      decoration: InputDecoration(
                        e
                        enabledBorder: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .appBarTitleStyle
                              .copyWith(color: UserThemes(widget.dataObject.theme).textColorVarient))),
                  TextFormField(
                      validator: (txt) => txt.isEmpty ? 'Post cannot be empty' : null,
                      decoration: InputDecoration(
                          hintText: 'Got something on your mind?',
                          hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .appBarTitleStyle
                              .copyWith(color: UserThemes(widget.dataObject.theme).textColorVarient))),
                ],
              ))
        ],
      ),
    );
  }
}
