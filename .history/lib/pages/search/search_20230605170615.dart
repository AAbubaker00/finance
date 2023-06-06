import 'package:valuid/pages/search/viewResult.dart';
import 'package:valuid/services/Network/network.dart';
import 'package:valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/cards/searchResultCard.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/inputDecoration/inputDecoration.dart';
import 'package:valuid/shared/pageLoaders/noSearchResult.dart';
import 'package:valuid/shared/pageLoaders/offline.dart';
import 'package:valuid/shared/pageLoaders/searchWelcome.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:valuid/shared/themes/themes.dart';

class Search extends StatefulWidget {
  final DataObject dataObject;

  const Search({Key key, required this.dataObject}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List displayedData = [];

  String searchString = '';
  bool isOnline = true;

  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _focusNode.unfocus();
        });
      },
      child: CWScaffold(
        scaffoldBgColour: BgTheme.LIGHT,
        preferredSizeValue: 1.4,
        appBarBottomWidget: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
            child: TextField(
              focusNode: _focusNode,
              style: CustomTextStyles(widget.dataObject.context).seeAllTextStyle,
              decoration: CustomInputDecoration("Search for investments...", context,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10.0),
                    child: ClipRRect(
                        child: Image.asset(
                      'assets/icons/search.png',
                      color: iconColour,
                    )),
                  ),
                  contentPadding: EdgeInsets.only(left: 15, top: 12, bottom: 12),
                  radius: circularRadius),
              onChanged: (txt) async {
                searchString = txt.toLowerCase();
                if (await Network().getConnectionStatus()) {
                  isOnline = true;
                  displayedData = await YahooApiService().getTickerSearchResultUpdated(search: txt);
                } else {
                  isOnline = false;
                }
                setState(() {});
              },
            ),
          ),
        ),
        body: Ink(
          color: summaryColour,
          child: CWListView(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
            centerWidget: searchString == '' && displayedData.isEmpty
                ? SearchWelcome()
                : isOnline
                    ? (searchString != '' && displayedData.isEmpty ? NoSearchResults() : null)
                    : Offline(),
            children: displayedData.map<Widget>((result) {
              return result['typeDisp'] == 'Currency'
                  ? Container()
                  : Column(
                      children: [
                        InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(circularRadius),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                CustomPageRouteSlideTransition(
                                    direction: AxisDirection.left,
                                    child: ViewResult(
                                      dataObject: widget.dataObject,
                                      result: result,
                                    ))),
                            child: SearchResultCard(
                              dataObject: widget.dataObject,
                              result: result,
                            )),
                        result == displayedData.last ? Container() : CustomDivider(),
                      ],
                    );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
