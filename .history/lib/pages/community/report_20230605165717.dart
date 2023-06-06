import 'package:valuid/pages/community/postCard.dart';
import 'package:valuid/services/database/database.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  late DataObject dataObject;
  late PostObject post;
  late String feedUid;
  final Map comment;

  Report({required this.dataObject, required this.post, required this.feedUid, required this.comment});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _editingController = TextEditingController();

  FocusNode _focus = FocusNode();

  List reasons = [
    'Posting annoying content',
    'Posting inappropriate content',
    'False information',
    'Posting spam',
    'Hate Speech or symbols',
    'Something else'
  ];

  String reason = '';

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appbarColourOption: 2,
      scaffoldBgColour: BgTheme.LIGHT,
      appBarTitle: 'Report',
      body: CWListView(
        padding: EdgeInsets.all(15),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0, top: 10),
            child: Text('Why are you reporting this post?',
                style: CustomTextStyles(widget.dataObject.context).holdingValueStyle),
          ),
          Column(
              children: reasons
                  .map((res) => Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: InkWell(
                          onTap: () => setState(() => reason = res),
                          borderRadius: BorderRadius.circular(circularRadius),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: reason == res ? blueVarient.withOpacity(.7) : backgroundColour,
                                      borderRadius: BorderRadius.circular(circularRadius),
                                      border: Border.all(
                                          color: reason == res ? blueVarient : seperator.withOpacity(.7),
                                          width: .7)),
                                ),
                                SizedBox(width: 15),
                                Text(res,
                                    style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle)
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList()),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15),
            child: Form(
              key: _formKey,
              child: Container(
                decoration: CustomDecoration()
                    .curvedContainerDecoration
                    .copyWith(border: Border.all(color: seperator.withOpacity(.7), width: .7)),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: TextFormField(
                  validator: (txt!) =>
                      reason == 'Other' && txt.isEmpty ? 'Report must not be left blank' : null,
                  cursorHeight: 20,
                  controller: _editingController,
                  minLines: 5,
                  maxLines: 10,
                  enabled: reason == 'Other',
                  focusNode: _focus,
                  onChanged: (txt) => setState(() => reason = txt),
                  style: CustomTextStyles(widget.dataObject.context)
                      .seeAllTextStyle
                      .copyWith(color: textColor, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 10,
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: CustomTextStyles(widget.dataObject.context)
                        .seeAllTextStyle
                        .copyWith(color: textColorVarient, fontWeight: FontWeight.w400),
                    isDense: true,
                    hintText: "Other reasons...",
                  ),
                ),
              ),
            ),
          ),
          CWApplyButton(
            function: () async {
              if (_formKey.currentState.validate() && reason != '') {
                if (widget.comment == null) {
                  widget.post.reports.add({'reason': reason});
                } else {
                  widget.post.comments
                      .firstWhere((comment) => comment == widget.comment)['reports']
                      .add({'reason': reason});
                }

                await DatabaseService().updateFeed(
                    post: widget.post,
                    feedUid: widget.feedUid,
                    isCommentUpdate: !(widget.comment == null),
                    originalComment: widget.comment);

                Navigator.pop(context);
              }
            },
            customTextStyle:
                CustomTextStyles(widget.dataObject.context).appBarTitleStyle.copyWith(color: Colors.white),
            btnText: 'Submit Report',
            verticalPadding: 20,
          )
        ],
      ),
    );
  }
}
