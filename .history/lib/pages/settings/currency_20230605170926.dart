import 'package:valuid/services/database/database.dart';
import 'package:valuid/services/forex/forex_conversion.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  final DataObject dataObject;

  CurrencyPage({Key key,required this.dataObject}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitle: 'Account Currency',
      bottomAppBarBorderColour: true,
      appbarColourOption: 2,
      scaffoldBgColour: BgTheme.LIGHT,
      body: CWListView(
        padding: EdgeInsets.only(top: 15),
        children: ForexConversion().currencySymbols.map<Widget>((currency) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: InkWell(
                    borderRadius: BorderRadius.circular(circularRadius),
                    onTap: () async {
                      widget.dataObject.account.currency = currency['short'];

                      widget.dataObject.isLoaded = false;

                      await DatabaseService(uid: widget.dataObject.user.uid)
                          .updateUserData(data: widget.dataObject);

                      setState(() {});
                    },
                    child: Ink(
                      padding: EdgeInsets.symmetric(vertical: 17),
                      decoration: CustomDecoration().curvedContainerDecoration.copyWith(
                          color: widget.dataObject.userCurrencySymbol == currency['symbol']
                              ? blueVarient
                              : summaryColour),
                      child: Column(
                        children: [
                          Text(
                            currency['symbol'],
                            style: CustomTextStyles(widget.dataObject.context).holdingValueStyle.copyWith(
                                color: widget.dataObject.userCurrencySymbol == currency['symbol']
                                    ? summaryColour
                                    : textColorVarient),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              '${currency['short']} - ${currency['name']}',
                              style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle.copyWith(
                                  color: widget.dataObject.userCurrencySymbol == currency['symbol']
                                      ? summaryColour
                                      : textColorVarient),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              ForexConversion().currencySymbols.last == currency
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3.0,
                      ),
                      child: CustomDivider(),
                    ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
