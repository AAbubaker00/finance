import 'package:Onvest/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvest/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvest/shared/TextStyle/customTextStyles.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:Onvest/shared/decoration/customDecoration.dart';
import 'package:Onvesting/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InstrumentInfo extends StatelessWidget {
  final Map instrument;
  final DataObject dataObject;
  final String currencySymbol;

  const InstrumentInfo({Key key, this.instrument, this.dataObject, this.currencySymbol}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      bottomAppBarBorderColour: false,
      dataObject: dataObject,
      appBarTitle: 'Information',
      body: CWListView(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Container(
              decoration: CustomDecoration(dataObject.theme).topWidgetDecoration,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   'NAME',
                        //   style: CustomTextStyles(dataObject.theme).holdingSubValueStyle,
                        // ),
                        // // SizedBox(height: 5),
                        Flexible(
                          child: Text(
                            instrument['quote'].containsKey('longName')
                                ? instrument['quote']['longName']
                                : instrument['quote']['shortName'],
                                overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles(dataObject.theme)
                                .tableValueStyle
                                .copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: .8, color: UserThemes(dataObjectdataObject.theme).seperator.withOpacity(.5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SYMBOL',
                          style: CustomTextStyles(dataObject.theme).holdingSubValueStyle,
                        ),
                        // SizedBox(height: 5),
                        Text(
                          instrument['quote']['symbol'],
                          style: CustomTextStyles(dataObject.theme)
                              .tableValueStyle
                              .copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: .8, color: UserThemes(dataObjectdataObject.theme).seperator.withOpacity(.5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EXCHANGE',
                          style: CustomTextStyles(dataObject.theme).holdingSubValueStyle,
                        ),
                        // SizedBox(height: 5),
                        Text(
                          instrument['quote']['fullExchangeName'],
                          style: CustomTextStyles(dataObject.theme)
                              .tableValueStyle
                              .copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: .8, color: UserThemes(dataObjectdataObject.theme).seperator.withOpacity(.5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ASSET CLASS',
                          style: CustomTextStyles(dataObject.theme).holdingSubValueStyle,
                        ),
                        // SizedBox(height: 5),
                        Text(
                          instrument['quote']['quoteType'],
                          style: CustomTextStyles(dataObject.theme)
                              .tableValueStyle
                              .copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: CustomDecoration(dataObject.theme).baseContainerDecoration,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MARKET CAP',
                      style: CustomTextStyles(dataObject.theme).holdingSubValueStyle,
                    ),
                    // SizedBox(height: 5),
                    Text(
                      instrument['quote'].containsKey('marketCap')
                          ? NumberFormat.compact().format(instrument['quote']['marketCap']).toString()
                          : 'na',
                      style: CustomTextStyles(dataObject.theme)
                          .tableValueStyle
                          .copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Divider(thickness: .8, color: UserThemes(dataObjectdataObject.theme).seperator.withOpacity(.5)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'P/E RATIO',
                      style: CustomTextStyles(dataObject.theme).holdingSubValueStyle,
                    ),
                    // SizedBox(height: 5),
                    Text(
                      instrument['quote'].containsKey('trailingPE')
                          ? instrument['quote']['trailingPE'].toStringAsFixed(2)
                          : 'na',
                      style: CustomTextStyles(dataObject.theme)
                          .tableValueStyle
                          .copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Divider(thickness: .8, color: UserThemes(dataObjectdataObject.theme).seperator.withOpacity(.5)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EPS',
                      style: CustomTextStyles(dataObject.theme).holdingSubValueStyle,
                    ),
                    Text(
                      instrument['quote'].containsKey('epsCurrentYear')
                          ? '$currencySymbol${instrument['quote']['epsCurrentYear'].toString()}'
                          : 'na',
                      style: CustomTextStyles(dataObject.theme)
                          .tableValueStyle
                          .copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Divider(thickness: .8, color: UserThemes(dataObjectdataObject.theme).seperator.withOpacity(.5)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SHARES OUTSTANDING',
                      style: CustomTextStyles(dataObject.theme).holdingSubValueStyle,
                    ),
                    Text(
                      instrument['quote'].containsKey('sharesOutstanding')
                          ? NumberFormat.compact().format(instrument['quote']['sharesOutstanding']).toString()
                          : 'na',
                      style: CustomTextStyles(dataObject.theme)
                          .tableValueStyle
                          .copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Divider(thickness: .8, color: UserThemes(dataObjectdataObject.theme).seperator.withOpacity(.5)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BETA',
                      style: CustomTextStyles(dataObject.theme).holdingSubValueStyle,
                    ),
                    Text(
                      instrument['defaultKeyStat'].containsKey('beta')
                          ? '${(instrument['defaultKeyStat']['beta']['fmt'])}'
                          : 'na',
                      style: CustomTextStyles(dataObject.theme)
                          .tableValueStyle
                          .copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Divider(thickness: .8, color: UserThemes(dataObjectdataObject.theme).seperator.withOpacity(.5)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DIVIDEND YIELD',
                      style: CustomTextStyles(dataObject.theme).holdingSubValueStyle,
                    ),
                    Text(
                      instrument['quote'].containsKey('trailingAnnualDividendYield')
                          ? '${(instrument['quote']['trailingAnnualDividendYield'] * 100).toStringAsFixed(2)}%'
                          : 'na',
                      style: CustomTextStyles(dataObject.theme)
                          .tableValueStyle
                          .copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
