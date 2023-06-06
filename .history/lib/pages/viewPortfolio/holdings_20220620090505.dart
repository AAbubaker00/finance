import 'package:Onvesting/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvesting/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvesting/shared/dataObject/data_object.dart';
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
