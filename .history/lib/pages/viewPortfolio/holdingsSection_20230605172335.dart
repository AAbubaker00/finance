import 'package:flutter/material.dart';
import 'package:valuid/pages/viewPortfolio/viewHolding.dart';
import 'package:valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/cards/holdingCard.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/inputDecoration/inputDecoration.dart';
import 'package:valuid/shared/pageLoaders/noHolding.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';

class HoldingsSection extends StatefulWidget {
  const HoldingsSection({required this.dataObject});

  final DataObject dataObject;

  @override
  State<HoldingsSection> createState() => _HoldingsSectionState();
}

class _HoldingsSectionState extends State<HoldingsSection> {
  List sortOptions = ['A-Z', 'Return', 'Invested', 'Shares'];
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _focusNode.unfocus();
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: backgroundColour,
                  borderRadius: BorderRadius.circular(circularRadius),
                  border: Border.all(color: seperator, width: .5)),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      focusNode: _focusNode,
                      style: CustomTextStyles(widget.dataObject.context).seeAllTextStyle,
                      decoration: CustomInputDecoration("Search investments", context,
                          borderOpacity: 0,
                          fillColor: Colors.transparent,
                          focusedBorderColor: Colors.transparent,
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
                        setState(() {
                          widget.dataObject.displayHolding = txt == ''
                              ? widget.dataObject.onPortfolio!.holdings
                              : widget.dataObject.onPortfolio.holdings
                                  .where((holding) => holding.name.toLowerCase().contains(txt.toLowerCase()))
                                  .toList();
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(border: Border(left: BorderSide(color: seperator))),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(buttonRadius),
                      onTap: () => viewSortOptions(
                        setState: setState,
                        dataObject: widget.dataObject,
                        sortOptions: sortOptions,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/icons/sort.png',
                            width: iconSize + 2,
                            height: iconSize + 2,
                            color: iconColour,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget.dataObject.onPortfolio.holdings.length == 0
                ? Expanded(child: NoHoldings())
                : Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: widget.dataObject.displayHolding
                          .map<Widget>((holding) => Padding(
                                padding: EdgeInsets.only(
                                    top: widget.dataObject.displayHolding.first == holding ? 10 : 0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        widget.dataObject.onHolding = holding;
                                        await Navigator.push(
                                                context,
                                                CustomPageRouteSlideTransition(
                                                    direction: AxisDirection.left,
                                                    child: ViewHolding(dataObject: widget.dataObject)))
                                            .then((feedback) {
                                          if (feedback != null) {
                                            setState(() {});
                                          }
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(circularRadius),
                                      child: HoldingCard(
                                        index: widget.dataObject.onPortfolio.holdings.indexOf(holding),
                                        holding: holding,
                                        dataObject: widget.dataObject,
                                      ),
                                    ),
                                    CustomDivider()
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
            CWApplyButton(
              addBlur: false,
              isLinearGradient: true,
              isBgColurOn: false,
              customTextColour: summaryColour,
              customTextStyle: CustomTextStyles(widget.dataObject.context)
                  .holdingValueStyle
                  .copyWith(letterSpacing: 1, color: summaryColour, fontWeight: FontWeight.w600),
              verticalPadding: 20,
              addBorder: false,
              btnText: 'ADD INVESTMENTS',
              function: () => widget.dataObject.changePage(2),
            )
          ],
        ),
      ),
    );
    ;
  }
}
