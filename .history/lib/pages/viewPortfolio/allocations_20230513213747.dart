import 'package:valuid/extensions/stringExt.dart';
import 'package:valuid/pages/viewPortfolio/sectorCard.dart';
import 'package:valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/GeneralObject/generalObject.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/charts/charts.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/pageLoaders/noHolding.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class Allocations extends StatefulWidget {
  final DataObject dataObject;

  Allocations({Key key, this.dataObject}) : super(key: key);

  @override
  State<Allocations> createState() => _AllocationsState();
}

class _AllocationsState extends State<Allocations> {
  @override
  void dispose() {
    diversificationCDT.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setDiversificationData();
  }

  void showDiversificationPanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: widget.dataObject.context,
        builder: (ctxt) => _allocationsOptionPanel(ctxt));
  }

  @override
  Widget build(BuildContext context) {
    return widget.dataObject.onPortfolio.holdings.length == 0
        ? NoHoldings()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: CustomDecoration().topWidgetDecoration,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(diversificationCDT[diversificationSelectedIndex].name,
                              style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle.copyWith(
                                  color: customColours[diversificationSelectedIndex],
                                  fontWeight: FontWeight.w600)),
                          Text(
                              diversificationCDT[diversificationSelectedIndex].weight.toStringAsFixed(2) +
                                  '%',
                              style: CustomTextStyles(widget.dataObject.context).holdingValueStyle)
                        ],
                      ),
                      SizedBox(
                        height: widget.dataObject.height * 0.07,
                        child: CustomCharts(widget.dataObject.context).createSampleData(
                          data: diversificationCDT,
                          dataObject: widget.dataObject,
                          selectedIndex: diversificationSelectedIndex,
                          centerData: diversificationCDT.isEmpty
                              ? ''
                              : diversificationCDT[diversificationSelectedIndex].weight.toStringAsFixed(2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(circularRadius)),
                                  onTap: () => showDiversificationPanel(),
                                  borderRadius: BorderRadius.circular(50),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Row(
                                      children: [
                                        Text(diversificationOption,
                                            style: CustomTextStyles(widget.dataObject.context)
                                                .portfolioNameStyle),
                                        Icon(Icons.keyboard_arrow_down_rounded)
                                      ],
                                    ),
                                  )),
                              Text('Invested',
                                  style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Ink(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView(
                    shrinkWrap: true,
                    children: diversificationCDT
                        .map((diverOption) => Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: diverOption == diversificationCDT.first ? 8 : 0,
                                      bottom: diverOption == diversificationCDT.last ? 8 : 0),
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(circularRadius),
                                      onTap: () {
                                        setState(() {
                                          diversificationSelectedIndex =
                                              diversificationCDT.indexOf(diverOption);
                                        });
                                      },
                                      child: SectorCard(
                                          dataObject: widget.dataObject,
                                          diverOption: diverOption,
                                          diversificationOption: diversificationOption,
                                          diversificationSelectedIndex: diversificationSelectedIndex,
                                          diversificationCDT: diversificationCDT)),
                                ),
                                diverOption == diversificationCDT.last
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
                                        child: CustomDivider())
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          );
  }

  List<GeneralObject> diversificationCDT = [];
  int diversificationSelectedIndex = 0;
  List diversificationOptions = ['Investments', 'Dividends', 'Sectors', 'Industries', 'Exchanges', 'Currencies'];

  String diversificationOption = 'Investments';

  setDiversificationData() async {
    diversificationCDT.clear();
    diversificationSelectedIndex = 0;

    switch (diversificationOption) {
      case 'Dividends':
        for (var holding in widget.dataObject.onPortfolio.holdings) {
          if (holding.dividendSupport) {
            if (diversificationCDT.isEmpty) {
              diversificationCDT.add(GeneralObject(
                  name: 'Dividends',
                  value: holding.invested,
                  assetList: [holding],
                  weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
            } else {
              var isObjectExist =
                  diversificationCDT.firstWhere((type) => type.name == 'Dividends', orElse: () => null);

              if (isObjectExist == null) {
                diversificationCDT.add(GeneralObject(
                    name: 'Dividends',
                    value: holding.invested,
                    assetList: [holding],
                    weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
              } else {
                diversificationCDT.remove(isObjectExist);

                diversificationCDT.add(GeneralObject(
                    name: isObjectExist.name,
                    value: isObjectExist.value + holding.invested,
                    assetList: isObjectExist.assetList + [holding],
                    weight: isObjectExist.weight +
                        (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
              }
            }
          } else {
            if (diversificationCDT.isEmpty) {
              diversificationCDT.add(GeneralObject(
                  name: 'Non-Dividends',
                  value: holding.invested,
                  assetList: [holding],
                  weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
            } else {
              var isObjectExist =
                  diversificationCDT.firstWhere((type) => type.name == 'Non-Dividends', orElse: () => null);

              if (isObjectExist == null) {
                diversificationCDT.add(GeneralObject(
                    name: 'Non-Dividends',
                    value: holding.invested,
                    assetList: [holding],
                    weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
              } else {
                diversificationCDT.remove(isObjectExist);

                diversificationCDT.add(GeneralObject(
                    name: isObjectExist.name,
                    value: isObjectExist.value + holding.invested,
                    assetList: isObjectExist.assetList + [holding],
                    weight: isObjectExist.weight +
                        (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
              }
            }
          }
        }
        break;
      case 'Investments':
        for (var holding in widget.dataObject.onPortfolio.holdings) {
          diversificationCDT.add(new GeneralObject(
              name: holding.name,
              value: holding.invested,
              weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
        }
        break;
      case 'Exchanges':
        for (var holding in widget.dataObject.onPortfolio.holdings) {
          if (diversificationCDT.isEmpty) {
            diversificationCDT.add(GeneralObject(
                name: holding.exchange.capitalizeAll(),
                value: holding.invested,
                assetList: [holding],
                weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
          } else {
            var isGeneralObjectExist = diversificationCDT.firstWhere(
                (region) => region.name == holding.exchange.toString().capitalizeAll(),
                orElse: () => null);

            if (isGeneralObjectExist == null) {
              diversificationCDT.add(GeneralObject(
                  name: holding.exchange.capitalizeAll(),
                  value: holding.invested,
                  assetList: [holding],
                  weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
            } else {
              diversificationCDT.remove(isGeneralObjectExist);

              diversificationCDT.add(GeneralObject(
                  name: isGeneralObjectExist.name,
                  value: isGeneralObjectExist.value + holding.invested,
                  assetList: isGeneralObjectExist.assetList + [holding],
                  weight: isGeneralObjectExist.weight +
                      (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
            }
          }
        }
        break;
      case 'Sectors':
        for (var holding in widget.dataObject.onPortfolio.holdings) {
          if (diversificationCDT.isEmpty) {
            diversificationCDT.add(GeneralObject(
                name: holding.sector,
                value: holding.invested,
                assetList: [holding],
                weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
          } else {
            var isGeneralObjectExist = diversificationCDT.firstWhere(
                (region) => region.name == holding.sector.capitalizeAll(),
                orElse: () => null);

            if (isGeneralObjectExist == null) {
              diversificationCDT.add(GeneralObject(
                  name: holding.sector,
                  value: holding.invested,
                  assetList: [holding],
                  weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
            } else {
              diversificationCDT.remove(isGeneralObjectExist);

              diversificationCDT.add(GeneralObject(
                  name: isGeneralObjectExist.name,
                  value: isGeneralObjectExist.value + holding.invested,
                  assetList: isGeneralObjectExist.assetList + [holding],
                  weight: isGeneralObjectExist.weight +
                      (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
            }
          }
        }
        break;
      case 'Industries':
        for (var holding in widget.dataObject.onPortfolio.holdings) {
          if (diversificationCDT.isEmpty) {
            diversificationCDT.add(GeneralObject(
                name: holding.industry,
                value: holding.invested,
                assetList: [holding],
                weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
          } else {
            var isGeneralObjectExist = diversificationCDT.firstWhere(
                (region) => region.name == holding.industry.toString().capitalizeAll(),
                orElse: () => null);

            if (isGeneralObjectExist == null) {
              diversificationCDT.add(GeneralObject(
                  name: holding.industry,
                  value: holding.invested,
                  assetList: [holding],
                  weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
            } else {
              diversificationCDT.remove(isGeneralObjectExist);

              diversificationCDT.add(GeneralObject(
                  name: isGeneralObjectExist.name,
                  value: isGeneralObjectExist.value + holding.invested,
                  assetList: isGeneralObjectExist.assetList + [holding],
                  weight: isGeneralObjectExist.weight +
                      (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
            }
          }
        }
        break;
      case 'Currencies':
        for (var holding in widget.dataObject.onPortfolio.holdings) {
          if (diversificationCDT.isEmpty) {
            diversificationCDT.add(GeneralObject(
                name: holding.currency,
                value: holding.invested,
                assetList: [holding],
                weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
          } else {
            var isGeneralObjectExist = diversificationCDT
                .firstWhere((region) => region.name == holding.currency, orElse: () => null);

            if (isGeneralObjectExist == null) {
              diversificationCDT.add(GeneralObject(
                  name: holding.currency,
                  assetList: [holding],
                  value: holding.invested,
                  weight: (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
            } else {
              diversificationCDT.remove(isGeneralObjectExist);

              diversificationCDT.add(GeneralObject(
                  name: isGeneralObjectExist.name,
                  value: isGeneralObjectExist.value + holding.invested,
                  assetList: isGeneralObjectExist.assetList + [holding],
                  weight: isGeneralObjectExist.weight +
                      (holding.invested / widget.dataObject.onPortfolio.invested) * 100));
            }
          }
        }
    }

    diversificationCDT.sort((a, b) => b.value.compareTo(a.value));
    setState(() {});
  }

  _allocationsOptionPanel(BuildContext ctxt) {
    return StatefulBuilder(builder: (context, state) {
      return MainCustomBottomSheet(
        ctxt: ctxt,
        showCreateBtn: false,
        widget: ListView(
          shrinkWrap: true,
          children: diversificationOptions
              .map((option) => Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(circularRadius),
                        onTap: () {
                          if (diversificationOption != option) {
                            diversificationOption = option;

                            setDiversificationData();
                            state(() {});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(option,
                                    style: CustomTextStyles(widget.dataObject.context).sectionHeader),
                                Container(
                                    decoration: BoxDecoration(
                                      color: summaryColour,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: customColours[diversificationOptions.indexOf(option)]),
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Icon(Icons.done,
                                        color: diversificationOption == option
                                            ? customColours[diversificationOptions.indexOf(option)]
                                            : Colors.transparent))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: CustomDivider(),
                      )
                    ],
                  ))
              .toList(),
        ),
      );
    });
  }
}
