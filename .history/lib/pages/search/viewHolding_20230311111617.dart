import 'package:Valuid/models/portfolio/portfolio.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:Valuid/shared/themes/themes.dart';

class ViewHolding extends StatefulWidget {
  final DataObject dataObject;

  const ViewHolding({Key key, this.dataObject}) : super(key: key);
  @override
  _ViewHolding createState() => _ViewHolding();
}

class _ViewHolding extends State<ViewHolding> {
  getReturn() {
    // instrumentReturn = ((instrument['marketPrice'] / (instrumentExchange == 'LSE' ? 100 : 1)) - pp) * q;

    setState(() {});
  }

  double purchasePrice = 0, quantity = 0;

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedPortfolio = 'Select Portfolio', hintText_0 = '0', hintText_1 = '0';

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      dataObject: widget.dataObject,
      isCenter: false,
      scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
      appbarColourOption: 2,
      preferredSizeValue: 2.4,
      appBarBottomWidget: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 3.0,
                      ),
                      child: Text(
                        '${widget.dataObject.onHolding.currency}',
                        style: CustomTextStyles(widget.dataObject.context).overallCurrencyStyle,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.dataObject.onHolding.regularMarketPrice.toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          style: CustomTextStyles(widget.dataObject.context).overallValueStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0, left: 1),
                          child: Text(
                            '${(widget.dataObject.onHolding.regularMarketPrice - widget.dataObject.onHolding.regularMarketPrice.toInt()).toStringAsFixed(2).replaceRange(0, 1, '')}',
                            style: CustomTextStyles(widget.dataObject.context).overallCurrencyStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      ((widget.dataObject.onHolding.regularMarketPrice >= 0)
                              ? '+${widget.dataObject.onHolding.currency}${widget.dataObject.onHolding.regularMarketPrice.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                              : '-${widget.dataObject.onHolding.currency}${(widget.dataObject.onHolding.regularMarketPrice * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}') +
                          '(${(widget.dataObject.onHolding.regularMarketChange).toStringAsFixed(2)}%)',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: (widget.dataObject.onHolding.regularMarketPrice > 0)
                              ? greenVarient
                              : redVarient)),
                  Text(' DAILY', style: CustomTextStyles(widget.dataObject.context).tableHeaderStyle),
                ],
              ),
            ],
          ),
        ),
      ),
      appBarTitleWidget: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(widget.dataObject.onHolding.name,
                  style: CustomTextStyles(widget.dataObject.context).appBarTitleStyle),
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: CWListView(
          padding: const EdgeInsets.only(bottom: 20, top: 30),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Purchase/Average price',
                      style: CustomTextStyles(widget.dataObject.context)
                          .holdingValueStyle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      focusNode: focusNode_0,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      validator: (txt) {
                        if (txt.isEmpty || double.parse(txt) <= 0) {
                          return 'Purchase price cannot be empty or lower than 0.';
                        } else {
                          return null;
                        }
                      },
                      style: CustomTextStyles(widget.dataObject.context)
                          .overallCurrencyStyle
                          .copyWith(fontWeight: FontWeight.w800, color: blueVarient),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        hintStyle: CustomTextStyles(widget.dataObject.context)
                            .overallCurrencyStyle
                            .copyWith(fontWeight: FontWeight.w800, color: blueVarient.withOpacity(.3)),
                        hintText: hintText_0,
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: border)),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onChanged: (txt) {
                        purchasePrice = double.parse(txt.isEmpty ? '0.0' : txt);
                        pp = double.parse(txt.isEmpty ? '0.0' : txt);
                        getReturn();
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CustomDivider(
                    dataObject: widget.dataObject,
                    color: seperator.withOpacity(.4),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Aquired shares',
                      style: CustomTextStyles(widget.dataObject.context)
                          .holdingValueStyle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      focusNode: focusNode_1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      validator: (txt) {
                        if (txt.isEmpty || double.parse(txt) <= 0) {
                          return 'Quantity cannot be empty or lower than 0.';
                        } else {
                          return null;
                        }
                      },
                      style: CustomTextStyles(widget.dataObject.context)
                          .overallCurrencyStyle
                          .copyWith(fontWeight: FontWeight.w800, color: blueVarient),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        hintStyle: CustomTextStyles(widget.dataObject.context)
                            .overallCurrencyStyle
                            .copyWith(fontWeight: FontWeight.w800, color: blueVarient.withOpacity(.3)),
                        hintText: hintText_1,
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: border)),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onChanged: (txt) {
                        quantity = double.parse(txt.isEmpty ? '0.0' : txt);
                        q = double.parse(txt.isEmpty ? '0.0' : txt);
                        getReturn();
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CustomDivider(
                    dataObject: widget.dataObject,
                    color: seperator.withOpacity(.4),
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    'EARNINGS',
                    style: CustomTextStyles(widget.dataObject.context).holdingSubValueStyle,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    '${widget.dataObject.onHolding.currency}${instrumentReturn.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: instrumentReturn >= 0 ? greenVarient : redVarient),
                  ),
                ]),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 20),
              child: CWApplyButton(
                addBlur: false,
                isLinearGradient: true,
                dataObject: widget.dataObject,
                isBgColurOn: false,
                customTextColour: summaryColour,
                customTextStyle: CustomTextStyles(widget.dataObject.context)
                    .holdingValueStyle
                    .copyWith(letterSpacing: 1, color: summaryColour, fontWeight: FontWeight.w600),
                verticalPadding: 20,
                addBorder: false,
                isChange: purchasePrice != 0 && quantity != 0,
                function: () async {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
