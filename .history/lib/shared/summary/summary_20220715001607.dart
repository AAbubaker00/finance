import 'package:Onvest/shared/TextStyle/customTextStyles.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  final DataObject dataObject;

  Overview({Key key, this.dataObject}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
      child: CWListView(
        children: [
          Ink(
            decoration: CustomDecoration(widget.dataObject.theme).topWidgetDecoration,
            // .copyWith(color: UserThemes(widget.dataObject.theme).orangeVarient.withOpacity(1)),
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    widget.dataObject.onPortfolio['name'],
                    style:
                        CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).appBarTitleStyle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0, right: 2),
                      child: Text(
                        '${widget.dataObject.userCurrencySymbol}',
                        style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                            .overallCurrencyStyle,
                      ),
                    ),
                    isPrivate
                        ? Text(
                            '...',
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .overallValueStyle,
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${widget.dataObject.onPortfolio['portfolioValue'].toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                    .overallValueStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1.0, left: 2),
                                child: Text(
                                    '${(widget.dataObject.onPortfolio['portfolioValue'] - widget.dataObject.onPortfolio['portfolioValue'].toInt()).toStringAsFixed(2).replaceRange(0, 1, '')}',
                                    style:
                                        CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                            .overallCurrencyStyle),
                              ),
                            ],
                          ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Invested',
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .tabBarSelectedTextStyle
                                .copyWith(color: UserThemes(widget.dataObject.theme).textColorVarient_2),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '${widget.dataObject.userCurrencySymbol}${widget.dataObject.onPortfolio['investedValue'].toStringAsFixed(2).toString().addCommas()}',
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .portfolioNameStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Units().mainSpacing * 2.5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Earnings',
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .tabBarSelectedTextStyle
                                .copyWith(color: UserThemes(widget.dataObject.theme).textColorVarient_2),
                          ),
                          SizedBox(height: 3),
                          InkWell(
                            onTap: () => showreturnOptions(),
                            borderRadius: BorderRadius.circular(Units().circularRadius),
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      isPrivate
                                          ? '${widget.dataObject.userCurrencySymbol}...'
                                          : returnOption == 'Max'
                                              ? (widget.dataObject.onPortfolio['change'] >= 1000000 ||
                                                      widget.dataObject.onPortfolio['change'] <= -1000000)
                                                  ? (widget.dataObject.onPortfolio['change'] >= 0)
                                                      ? '+${widget.dataObject.userCurrencySymbol}${NumberFormat.compact().format(widget.dataObject.onPortfolio['change'])} (${(widget.dataObject.onPortfolio['returnPercentage']).toStringAsFixed(2)}%)'
                                                      : '-${widget.dataObject.userCurrencySymbol}${(NumberFormat.compact().format((widget.dataObject.onPortfolio['change'] * -1)))} (-${(widget.dataObject.onPortfolio['returnPercentage'] * -1).toStringAsFixed(2)}%)'
                                                  : (widget.dataObject.onPortfolio['change'] >= 0)
                                                      ? '+${widget.dataObject.userCurrencySymbol}${double.parse(widget.dataObject.onPortfolio['change'].toString()).toStringAsFixed(2).addCommas()} (${(widget.dataObject.onPortfolio['returnPercentage']).toStringAsFixed(2)}%)'
                                                      : '-${widget.dataObject.userCurrencySymbol}${(double.parse(widget.dataObject.onPortfolio['change'].toString()) * -1).toStringAsFixed(2).addCommas()} (-${(widget.dataObject.onPortfolio['returnPercentage'] * -1).toStringAsFixed(2)}%)'
                                              : (widget.dataObject.onPortfolio['dailyChange'] >= 1000000 ||
                                                      widget.dataObject.onPortfolio['dailyChange'] <=
                                                          -1000000)
                                                  ? (widget.dataObject.onPortfolio['dailyChange'] >= 0)
                                                      ? '+${widget.dataObject.userCurrencySymbol}${NumberFormat.compact().format(widget.dataObject.onPortfolio['dailyChange'])} (+${(widget.dataObject.onPortfolio['dailyChangePercent']).toStringAsFixed(2)}%)'
                                                      : '-${widget.dataObject.userCurrencySymbol}${(NumberFormat.compact().format((widget.dataObject.onPortfolio['dailyChange'] * -1)))} (${(widget.dataObject.onPortfolio['dailyChangePercent']).toStringAsFixed(2)}%)'
                                                  : (widget.dataObject.onPortfolio['dailyChange'] >= 0)
                                                      ? '+${widget.dataObject.userCurrencySymbol}${double.parse(widget.dataObject.onPortfolio['dailyChange'].toString()).toStringAsFixed(2).addCommas()} (+${(widget.dataObject.onPortfolio['dailyChangePercent']).toStringAsFixed(2)}%)'
                                                      : '-${widget.dataObject.userCurrencySymbol}${(double.parse(widget.dataObject.onPortfolio['dailyChange'].toString()) * -1).toStringAsFixed(2).addCommas()} (${(widget.dataObject.onPortfolio['dailyChangePercent']).toStringAsFixed(2)}%)',
                                      style:
                                          CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                              .summarySubTextStyle
                                              .copyWith(
                                                  color: (returnOption == 'Max'
                                                          ? (widget.dataObject.onPortfolio['change'] > 0)
                                                          : widget.dataObject.onPortfolio['dailyChange'] >= 0)
                                                      ? UserThemes(widget.dataObject.theme).greenVarient
                                                      : UserThemes(widget.dataObject.theme).redVarient)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: ClipRRect(
                                        child: Image.asset(
                                      'assets/icons/down_arrow.png',
                                      width: 18,
                                      height: 18,
                                      color: UserThemes(widget.dataObject.theme).iconColour,
                                    )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Ink(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
            decoration: CustomDecoration(
              widget.dataObject.theme,
            ).baseContainerDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Customise',
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .sectionHeader),
                        ClipRRect(
                            child: Image.asset(
                          'assets/icons/edit.png',
                          width: 20,
                          height: 20,
                          color: UserThemes(widget.dataObject.theme).textColorVarient,
                        )),
                      ],
                    )),
                Row(
                  children: [
                    Text(
                      'NAME',
                      style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                          .holdingSubValueStyle,
                    ),
                    Flexible(
                      child: TextFormField(
                        expands: false,
                        validator: (txt) => txt.isEmpty ? 'Name field must not be empty' : null,
                        textAlign: TextAlign.end,
                        style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                            .appBarTitleStyle,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          isCollapsed: true,
                          hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .appBarTitleStyle,
                          hintText: widget.dataObject.onPortfolio['name'],
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorStyle: TextStyle(color: UserThemes(widget.dataObject.theme).redVarient),
                        ),
                        onChanged: (txt) {
                          setState(() => name = txt);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: Units().mainSpacing * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => showPortfolioDeleteFunction(),
                borderRadius: BorderRadius.circular(Units().circularRadius),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Delete',
                    style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                        .portfolioSubValuetyle
                        .copyWith(
                            color: UserThemes(widget.dataObject.theme).textColorVarient.withOpacity(.3),
                            decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Units().mainSpacing * 2),
        ],
      ),
    );
  
  }
}
