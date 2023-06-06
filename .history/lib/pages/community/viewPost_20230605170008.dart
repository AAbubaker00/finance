import 'package:valuid/pages/community/socialPostCard.dart';
import 'package:valuid/pages/community/postCard.dart';
import 'package:valuid/services/database/database.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewPost extends StatefulWidget {
  final DataObject dataObject;
  final PostObject post;
  final String feedUid;

  ViewPost({
late     this.dataObject,
    this.post,
    this.feedUid,
  }) : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  final _auth = FirebaseAuth.instance;

  String comment = '';

  final _formKey = GlobalKey<FormState>();

  TextEditingController _editingController = TextEditingController();

  FocusNode _focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitle: '',
      bottomAppBarBorderColour: false,
      body: CWListView(
        children: [
          PostCard(
            viewAll: true,
            feedUid: widget.feedUid,
            dataObject: widget.dataObject,
            post: widget.post,
            viewPostContext: context,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(15),
            color: summaryColour,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Comments',
                    style:
                        CustomTextStyles( widget.dataObject.context).sectionHeader),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              'assets/icons/profile.png',
                              width: 25,
                              height: 25,
                              color: iconColour,
                            ),
                          ),
                          Flexible(
                            child: Container(
                              decoration: CustomDecoration().curvedContainerDecoration,
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: TextFormField(
                                validator: (txt) => txt.isEmpty ? 'Comment cannot be left blank' : null,
                                cursorHeight: 20,
                                controller: _editingController,
                                minLines: 1,
                                maxLines: 100,
                                focusNode: _focus,
                                onChanged: (txt) => setState(() => comment = txt),
                                style: CustomTextStyles( widget.dataObject.context)
                                    .seeAllTextStyle
                                    .copyWith(
                                        color: textColor,
                                        fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle:
                                      CustomTextStyles( widget.dataObject.context)
                                          .seeAllTextStyle
                                          .copyWith(
                                              color: textColor,
                                              fontWeight: FontWeight.w400),
                                  isDense: true,
                                  hintText: "Comment...",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  widget.post.comments.add({
                                    'text': comment,
                                    'date': DateTime.now().toString(),
                                    'replies': [],
                                    'reports': [],
                                    'userUid':_auth.currentUser.uid,
                                    'likes': [],
                                    'user': _auth.currentUser.displayName,
                                  });

                                  await DatabaseService()
                                      .updateFeed(post: widget.post, feedUid: widget.feedUid);

                                  _editingController.clear();

                                  setState(() {});
                                }
                              },
                              child: Image.asset(
                                'assets/icons/send.png',
                                width: 25,
                                height: 25,
                                color: purpleVarient
                                    .withOpacity(comment.isEmpty ? .5 : 1),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Column(
            children: widget.post.comments.reversed
                .map((comment) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CommentCard(
                        dataObject: widget.dataObject,
                        post: widget.post,
                        orginal: comment,
                        feedUid: widget.feedUid,
                        comment: CommentObject.fromMap(comment),
                      ),
                    ))
                .toList(),
          ),
          // Container(
          //   color: summaryColour,

          //   height: 200,child: Row(
          //   children: [],
          // ),)
        ],
      ),
    );
  }
}
