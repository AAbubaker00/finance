import 'package:Onvesting/pages/search/viewInstrument.dart';
import 'package:Onvesting/services/database/database.dart';
import 'package:Onvesting/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvesting/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Onvesting/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvesting/shared/TextStyle/customTextStyles.dart';
import 'package:Onvesting/shared/customPageRoute/customePageRoute.dart';
import 'package:Onvesting/shared/dataObject/data_object.dart';
import 'package:Onvesting/shared/decoration/customDecoration.dart';
import 'package:Onvesting/shared/themes/themes.dart';
import 'package:Onvesting/shared/units/units.dart';
import 'package:Onvesting/shared/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HoldingsPage extends StatefulWidget {
  final DataObject dataObject;
  final Map onPortfolio;

  HoldingsPage({Key key, this.dataObject, this.onPortfolio}) : super(key: key);

  @override
  State<HoldingsPage> createState() => _HoldingsPageState();
}

class _HoldingsPageState extends State<HoldingsPage> {
  List holdings = [], adsGenerated = [], holdingsSearch = [];

  String selectedSortOption = 'Earners';
  List<String> sortOptions = [
    'Investments',
    'Earners',
    'Shares',
  ];

  @override
  void initState() {
    super.initState();

    holdings.clear();

    for (var holdingType in widget.dataObject.onPortfolio['assets']) {
      holdings += holdingType['items'];
    }

    widget.dataObject.onHoldings = holdings;
    widget.dataObject.onHoldingSymbols =
        List.generate(holdings.length, (index) => holdings[index]['symbol'].replaceAll('.L', ''));

    print(widget.dataObject.onHoldingSymbols);

    holdingsSearch = widget.dataObject.onHoldings;

    // cagrData =
    // await CAGR().setCAGRData({'currency': 'USD', 'rates': widget.dataObject.rates, 'assets': holdings});

    // print(cagrData);

    // var inceptionDate = InceptionDate().getInceptionDae(widget.dataObject.onHoldings);

    setSort();
  }

  setSort() {
    if (!mounted) return;

    if (holdingsSearch.length > 2) {
      if (selectedSortOption == 'Investments') {
        holdingsSearch.sort((a, b) {
          return a['Invested'].compareTo(b['Invested']);
        });

        holdingsSearch = holdingsSearch.reversed.toList();
      } else if (selectedSortOption == 'Earners') {
        holdingsSearch.sort((a, b) {
          return a['change'].compareTo(b['change']);
        });

        holdingsSearch = holdingsSearch.reversed.toList();
      } else if (selectedSortOption == 'Buy Date') {
        holdings.sort((a, b) {
          return DateTime.parse(a['buyDate']).compareTo(DateTime.parse(b['buyDate']));
        });

        holdingsSearch = holdingsSearch.reversed.toList();
      } else if (selectedSortOption == 'Shares') {
        holdingsSearch.sort((a, b) {
          return a['shares'].compareTo(b['shares']);
        });

        holdingsSearch = holdingsSearch.reversed.toList();
      } else if (selectedSortOption == 'A-Z') {
        holdingsSearch.sort((a, b) {
          return a['symbol'][0].compareTo(b['symbol'][0]);
        });
      }
    }

    setState(() {});
  }

  var _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  Map removeHolding = {};
  bool isPrivate = false;
  String returnOption = 'Max';
  List<String> returnOptions = ['24H', 'Max'];

  bool isEditMode = false;
  bool isMainLoaded = false;

  Function showSortFunction, showreturnOptions, diversificationFuction;
  Function _showDeleteHoldingConfirmPanelFunction;

  @override
  Widget build(BuildContext context) {
    void showReturnOptionPanel() {
      showModalBottomSheet(
          context: widget.dataObject.context, builder: (ctxt) => _showReturnOptionPanel(ctxt));
    }

    
    void _showDeleteHoldingConfirmPanel() {
      showModalBottomSheet(
          context: widget.dataObject.context,
          builder: (ctxt) {
            return CWConfirmBottomSheetButton(
              dataObject: widget.dataObject,
              context: ctxt,
              btnText:
                  'Are you sure you want to delete ${removeHolding['marketData']['quote'].containsKey('longName') ? removeHolding['marketData']['quote']['longName'] : removeHolding['marketData']['quote']['shortName']} investment from ${widget.dataObject.onPortfolio['name']} portfolio?',
              function: () async {
                widget.dataObject.isUpdating = true;

                for (var portfolio in widget.dataObject.databaseData['portfolios']) {
                  if (portfolio['name'] == widget.dataObject.onPortfolio['name']) {
                    var removeholding, holdingTypeIndex;

                    for (var holdingType in portfolio['assets']) {
                      for (var holding in holdingType['items']) {
                        if (holding['symbol'] == removeHolding['symbol']) {
                          holdingTypeIndex = portfolio['assets'].indexOf(holdingType);
                          removeholding = holding;
                        }
                      }
                    }

                    portfolio['assets'][holdingTypeIndex]['items'].remove(removeholding);
                  }
                }

                for (var portfolio in widget.dataObject.portfolios) {
                  if (portfolio['name'] == widget.dataObject.onPortfolio['name']) {
                    var removeholding, holdingTypeIndex;

                    for (var holdingType in portfolio['assets']) {
                      for (var holding in holdingType['items']) {
                        if (holding['symbol'] == removeHolding['symbol']) {
                          holdingTypeIndex = portfolio['assets'].indexOf(holdingType);
                          removeholding = holding;
                        }
                      }
                    }

                    portfolio['assets'][holdingTypeIndex]['items'].remove(removeholding);
                  }
                }

                // isMainLoaded = false;
                final _auth = FirebaseAuth.instance;

                User currentUser = _auth.currentUser;

                // print(currentUser.uid);

                widget.dataObject.lastCalenderUpdate = '';

                DatabaseService(uid: currentUser.uid).updateChange(widget.dataObject);

                // Navigator.pop(context);
                // Navigator.pop(ctxt, true);

                widget.dataObject.isUpdating = false;
              },
            );
          });
    }


    void showSortPanel() {
      showModalBottomSheet(
          context: widget.dataObject.context,
          builder: (ctxt) => StatefulBuilder(
                builder: (context, retrunOptionSetState) => _sortOptionPanel(ctxt, retrunOptionSetState),
              ));
    }

    showreturnOptions = showReturnOptionPanel;
    showSortFunction = showSortPanel;
    _showDeleteHoldingConfirmPanelFunction = _showDeleteHoldingConfirmPanel;


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
                                    var quoteName = holding['marketData']['quote']['longName'].toLowerCase();
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
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: IntrinsicHeight(
                      child: Ink(
                        decoration: CustomDecoration(widget.dataObject.theme).curvedContainerDecoration,
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => showSortFunction(),
                              borderRadius: BorderRadius.circular(Units().circularRadius),
                              child: Ink(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.filter_list_rounded,
                                  color: UserThemes(widget.dataObject.theme).iconColour,
                                  size: Units().iconSize - 5,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3.0),
                              child: VerticalDivider(
                                color: UserThemes(widget.dataObject.theme).seperator,
                                width: 2,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() => isEditMode = !isEditMode);
                              },
                              borderRadius: BorderRadius.circular(Units().circularRadius),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: isEditMode
                                    ? ClipRRect(
                                        child: Image.asset(
                                        'assets/icons/confirm.png',
                                        width: 20,
                                        height: 20,
                                        color: UserThemes(widget.dataObject.theme).greenVarient,
                                      ))
                                    : ClipRRect(
                                        child: Image.asset(
                                        'assets/icons/edit.png',
                                        width: 20,
                                        height: 20,
                                        color: UserThemes(widget.dataObject.theme).iconColour,
                                      )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
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

                                          // _showDeleteHoldingConfirmPanelFunction();
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

  _showReturnOptionPanel(BuildContext ctxt) {
    return Ink(
      decoration: BoxDecoration(
          color: UserThemes(widget.dataObject.theme).summaryColour,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Units().circularRadius),
              topRight: Radius.circular(Units().circularRadius))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10),
            child: Container(
                width: 70,
                padding: EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                    border: Border.all(color: UserThemes(widget.dataObject.theme).seperator),
                    color: UserThemes(widget.dataObject.theme).backgroundColour,
                    borderRadius: BorderRadius.circular(Units().circularRadius)),
                child: Row(
                  children: [],
                )),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: returnOptions
                .map((option) => Column(
                      children: [
                        InkWell(
                          onTap: () => setState(() {
                            returnOption = option;

                            // setSort();

                            Navigator.pop(ctxt);
                          }),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(option,
                                style: CustomTextStyles(widget.dataObject.theme).holdingValueStyle.copyWith(
                                    color: option == returnOption
                                        ? UserThemes(widget.dataObject.theme).textColor
                                        : UserThemes(widget.dataObject.theme).textColorVarient)),
                          )),
                        ),
                        returnOptions.last == option
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Divider(
                                    thickness: .8,
                                    color: UserThemes(widget.dataObject.theme).seperator.withOpacity(.2)),
                              )
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  _sortOptionPanel(BuildContext ctxt, Function retrunOptionSetState) {
    return Ink(
      decoration: BoxDecoration(
          color: UserThemes(widget.dataObject.theme).summaryColour,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Units().circularRadius),
              topRight: Radius.circular(Units().circularRadius))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10),
            child: Container(
                width: 70,
                padding: EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                    border: Border.all(color: UserThemes(widget.dataObject.theme).seperator),
                    color: UserThemes(widget.dataObject.theme).backgroundColour,
                    borderRadius: BorderRadius.circular(Units().circularRadius)),
                child: Row(
                  children: [],
                )),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sortOptions
                .map((option) => Column(
                      children: [
                        InkWell(
                          onTap: () {
                            selectedSortOption = option;

                            setSort();

                            Navigator.pop(ctxt);
                          },
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(option,
                                style: CustomTextStyles(widget.dataObject.theme).holdingValueStyle.copyWith(
                                    color: option == selectedSortOption
                                        ? UserThemes(widget.dataObject.theme).textColor
                                        : UserThemes(widget.dataObject.theme).textColorVarient)),
                          )),
                        ),
                        sortOptions.last == option
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Divider(
                                    thickness: .8,
                                    color: UserThemes(widget.dataObject.theme).seperator.withOpacity(.2)),
                              )
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
