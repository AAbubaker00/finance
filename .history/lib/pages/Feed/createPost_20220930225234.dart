import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
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

  String title = '';
  String description = '';

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
                      validator: (txt) => txt.isEmpty ? 'Title cannot be left empty' : null,
                      onChanged: (txt) => setState(() => title = txt),
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .appBarTitleStyle
                              .copyWith(color: UserThemes(widget.dataObject.theme).textColorVarient))),
                  TextFormField(
                      validator: (txt) => txt.isEmpty ? 'Post cannot be left empty' : null,
                      onChanged: (txt) => setState(() => description = txt),
                      decoration: InputDecoration(
                          hintText: 'Got something on your mind?',
                          hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .appBarTitleStyle
                              .copyWith(color: UserThemes(widget.dataObject.theme).textColorVarient))),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CWApplyButton(
                      addBlur: false,
                      isLinearGradient: true,
                      dataObject: widget.dataObject,
                      isBgColurOn: false,
                      // customColour: UserThemes(widget.dataObject.theme).blueVarient,
                      customTextColour: UserThemes(widget.dataObject.theme).summaryColour,
                      customTextStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                          .appBarTitleStyle
                          .copyWith(
                              letterSpacing: 1,
                              color: UserThemes(widget.dataObject.theme).summaryColour,
                              fontWeight: FontWeight.w600),
                      verticalPadding: 20,
                      addBorder: false,
                      isChange: title.isNotEmpty && description.isNotEmpty,
                      btnText: 'POST',
                      function: () async {
                        if (_formKey.currentState.validate()) {
                          DatabaseService().feedCollection.doc('posts').update({data});
                        }
                      },
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
