import 'package:Onvesting/pages/search/viewInstrument.dart';
import 'package:Onvesting/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvesting/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvesting/shared/TextStyle/customTextStyles.dart';
import 'package:Onvesting/shared/customPageRoute/customePageRoute.dart';
import 'package:Onvesting/shared/dataObject/data_object.dart';
import 'package:Onvesting/shared/themes/themes.dart';
import 'package:Onvesting/shared/units/units.dart';
import 'package:Onvesting/shared/widgets.dart';
import 'package:flutter/material.dart';

class HoldingsPage extends StatefulWidget {
  final DataObject dataObject;
  final Map onPortfolio;

  HoldingsPage({Key key, this.dataObject, this.onPortfolio}) : super(key: key);

  @override
  State<HoldingsPage> createState() => _HoldingsPageState();
}

class _HoldingsPageState extends State<HoldingsPage> {
  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitle: 'Holdings',
      dataObject: widget.dataObject,
      body: CWListView(
        children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: CustomDecoration(widget.dataObject.theme).curvedBaseContainerDecoration,
                  child: Row(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5.0,
                              ),
                              child: ClipRRect(
                                  child: Image.asset(
                                'assets/icons/search.png',
                                color: UserThemes(widget.dataObject.theme).iconColour,
                                width: 20,
                                height: 20,
                              )),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7.0, bottom: 7),
                                child: TextField(
                                  controller: _textEditingController,
                                  focusNode: _focusNode,
                                  style: CustomTextStyles(widget.dataObject.theme).tableHeaderStyle.copyWith(
                                      fontSize: 18,
                                      color: UserThemes(widget.dataObject.theme).textColor,
                                      fontWeight: FontWeight.w300),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: CustomTextStyles(widget.dataObject.theme)
                                        .tableHeaderStyle
                                        .copyWith(
                                            color: UserThemes(widget.dataObject.theme).textColorVarient,
                                            fontWeight: FontWeight.w300),
                                    isDense: true,
                                    labelStyle: CustomTextStyles(widget.dataObject.theme)
                                        .tableHeaderStyle
                                        .copyWith(
                                            color: UserThemes(widget.dataObject.theme).textColorVarient,
                                            fontWeight: FontWeight.w300),
                                    hintText: "Search Investments...",
                                  ),
                                  onChanged: (txt) async {
                                    txt = txt.toLowerCase();
                                    setState(() {
                                      holdingsSearch = holdings.where((holding) {
                                        var quoteName =
                                            holding['marketData']['quote']['longName'].toLowerCase();
                                        return quoteName.contains(txt);
                                      }).toList();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
         
           Ink(
            // padding: EdgeInsets.all(5),
            child: ListView(
              // padding: EdgeInsets.symmetric(horizontal: 5),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: holdingsSearch.isEmpty
                  ? [Container()]
                  : holdingsSearch.map<Widget>((holding) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              isEditMode
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            removeHolding = holding;
                                          });

                                          _showDeleteHoldingConfirmPanelFunction();
                                        },
                                        borderRadius: BorderRadius.circular(50),
                                        child: ClipRRect(
                                            child: Image.asset(
                                          'assets/icons/remove.png',
                                          width: 20,
                                          height: 20,
                                          color:
                                              UserThemes(widget.dataObject.theme).redVarient.withOpacity(.7),
                                        )),
                                      ),
                                    )
                                  : Container(),
                              Flexible(
                                child: InkWell(
                                  onTap: () async {
                                    bool result;

                                    widget.dataObject.onHolding = holding;
                                    await Navigator.push(
                                            context,
                                            CustomPageRouteSlideTransition(
                                                direction: AxisDirection.left,
                                                child: ViewInstrument(
                                                  dataObject: widget.dataObject,
                                                  isView: true,
                                                ),
                                                settings: RouteSettings(arguments: {'onHolding': holding})))
                                        .then((value) {
                                      for (var holdingType in widget.dataObject.onPortfolio['assets']) {
                                        result = holdingType['items'].contains(widget.dataObject.onHolding);
                                      }
                                    });

                                    if (result == false) {
                                      isMainLoaded = false;
                                      setState(() {});
                                    } else {
                                      // widget.dataObject.onHolding = null;
                                    }
                                  }, //viewHoldingFunction(holding),
                                  borderRadius: BorderRadius.circular(Units().circularRadius),
                                  child: Investment().getInvestment(
                                      isPrivate: isPrivate,
                                      holding: holding,
                                      currencySymbol: widget.dataObject.userCurrencySymbol,
                                      theme: widget.dataObject.theme,
                                      dataObject: widget.dataObject,
                                      context: context,
                                      returnOption: returnOption),
                                ),
                              ),
                            ],
                          ),
                          holdingsSearch.last != holding
                              ? Padding(
                                  padding: EdgeInsets.only(left: 10.0, right: 10),
                                  child: Divider(
                                      thickness: .8,
                                      color: UserThemes(widget.dataObject.theme).seperator.withOpacity(.5)),
                                )
                              : Container(),
                        ],
                      );
                    }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
