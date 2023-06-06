import 'package:Valuid/pages/Feed/postCard.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
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
            padding: EdgeInsets.all(15),
            decoration: CustomDecoration(widget.dataObject.theme)
                .baseContainerDecoration
                .copyWith(border: Border.all(color: Colors.transparent)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Comments',
                    style:
                        CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).sectionHeader),
                Form(
                    child: Container(
                  decoration: CustomDecoration(widget.dataObject.theme).curvedContainerDecoration,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/profile.png',
                        width: 25,
                        height: 25,
                        color: UserThemes(widget.dataObject.theme).iconColour,
                      ),
                      TextField(
                            focusNode: _focusNode,
                            cursorHeight: 20,
                            onTap: () => setState(() => isActive = true),
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .tableHeaderStyle
                                .copyWith(
                                    color: UserThemes(widget.dataObject.theme).textColor,
                                    fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 10,
                              ),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                  .tableHeaderStyle
                                  .copyWith(
                                      color: UserThemes(widget.dataObject.theme).textColor,
                                      fontWeight: FontWeight.w400),
                              isDense: true,
                              hintText: "Search Investments...",
                            ),
                            onChanged: (txt) async {
                              txt = txt.toLowerCase();

                              for (var holdingType in widget.dataObject.onPortfolio['assets']) {
                                if (holdingType['id'] == 'stocks') {
                                  widget.dataObject.onStockHoldings = holdingType['items'].where((holding) {
                                    String quoteName =
                                        holding['marketData']['quote']['longName'].toLowerCase();
                                    print(quoteName);

                                    return quoteName.contains(txt);
                                  }).toList();
                                } else if (holdingType['id'] == 'cryptos') {
                                  widget.dataObject.onCryptoHoldings = holdingType['items'].where((holding) {
                                    String quoteName = holding['marketData']['name'].toLowerCase();
                                    return quoteName.contains(txt);
                                  }).toList();
                                }
                              }

                              setState(() {});
                            },
                          ),
                    ],
                  ),
                )),
                // Column(
                //   children: widget.post.comments.map((e) => Text('ss')).toList(),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
