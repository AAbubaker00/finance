import 'package:valuid/services/database/database.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  final DataObject dataObject;

  CreatePost({required this.dataObject});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appbarColourOption: 2,
      appBarTitle: 'Create post',
      body: CWListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: CustomDecoration().topWidgetDecoration,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        validator: (txt) => txt.isEmpty ? 'Title cannot be left empty' : null,
                        onChanged: (txt) => setState(() => title = txt),
                        maxLines: 100,
                        minLines: 1,
                        style: CustomTextStyles(widget.dataObject.context)
                            .appBarTitleStyle
                            .copyWith(fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: CustomTextStyles(widget.dataObject.context)
                                .appBarTitleStyle
                                .copyWith(color: textColorVarient))),
                    TextFormField(
                        validator: (txt) => txt?? 'Post cannot be left empty' : null,
                        onChanged: (txt) => setState(() => description = txt),
                        maxLines: 100,
                        minLines: 1,
                        style: CustomTextStyles(widget.dataObject.context).seeAllTextStyle,
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Got something on your mind?',
                            hintStyle: CustomTextStyles(widget.dataObject.context)
                                .appBarTitleStyle
                                .copyWith(color: textColor.withOpacity(.8), fontWeight: FontWeight.w400))),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: CWApplyButton(
              addBlur: false,
              isLinearGradient: true,
              isBgColurOn: false,
              customTextColour: summaryColour,
              customTextStyle: CustomTextStyles(widget.dataObject.context)
                  .appBarTitleStyle
                  .copyWith(letterSpacing: 1, color: summaryColour, fontWeight: FontWeight.w600),
              verticalPadding: 20,
              addBorder: false,
              isChange: title.isNotEmpty && description.isNotEmpty,
              btnText: 'POST',
              function: () async {
                if (_formKey.currentState.validate()) {
                  await DatabaseService().feedCollection.add({
                    'title': title,
                    'description': description,
                    'userUid': _auth.currentUser.uid,
                    'user': _auth.currentUser.displayName,
                    'img': '',
                    'section': '',
                    'comments': [],
                    'reports': [],
                    'likes': [],
                    'date': DateTime.now().toString()
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
