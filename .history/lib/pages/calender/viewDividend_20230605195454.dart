import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dateFormat/customeDateFormatter.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/dividends/dividends.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:valuid/extensions/stringExt.dart';

class ViewDividend extends StatefulWidget {
  final Dividends? dividends;

  ViewDividend({ this.dividends});

  @override
  State<ViewDividend> createState() => _ViewDividendState();
}

class _ViewDividendState extends State<ViewDividend> {
  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appbarColourOption: 2,
      appBarTitle: '${widget.dividends!.symbol.removeStr()} dividend',
      body: CWListView(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: CustomDecoration().topWidgetDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.done,
                        color: backgroundColour,
                      ),
                      backgroundColor: greenVarient.withOpacity(.9),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Decleration',
                                  style: CustomTextStyles(context)
                                      .portfolioNameStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${CustomDateFormatter().formatDateStyle(DateTime.parse(widget.dividends.announced).toString())}',
                                  style: CustomTextStyles(context).portfolioNameStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${widget.dividends!.name.removeStr()} announces dividends of ${widget.dividends!.amount} per share at ${widget.dividends!.yield} yield.',
                              style: CustomTextStyles(context)
                                  .feedDateStyle
                                  .copyWith(color: textColor.withOpacity(.5)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomDivider(),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        DateTime.now().isAfter(DateTime.parse(widget.dividends.exDate))
                            ? Icons.done
                            : Icons.more_horiz,
                        color: backgroundColour,
                      ),
                      backgroundColor: greenVarient.withOpacity(
                          DateTime.now().isAfter(DateTime.parse(widget.dividends.exDate)) ? .9 : .5),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ex-Date',
                                  style: CustomTextStyles(context)
                                      .portfolioNameStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                    '${CustomDateFormatter().formatDateStyle(DateTime.parse(widget.dividends.exDate).toString())}',
                                    style: CustomTextStyles(context).portfolioNameStyle),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                                'The date before which you must own ${widget.dividends.name.removeStr()} shares to be owed dividends.',
                                style: CustomTextStyles(context)
                                    .feedDateStyle
                                    .copyWith(color: textColor.withOpacity(.5))),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomDivider(),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        DateTime.now().isAfter(DateTime.parse(widget.dividends.exDate))
                            ? Icons.done
                            : Icons.more_horiz,
                        color: backgroundColour,
                      ),
                      backgroundColor: greenVarient.withOpacity(
                          DateTime.now().isAfter(DateTime.parse(widget.dividends.exDate)) ? .9 : .5),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Record Date',
                                  style: CustomTextStyles(context)
                                      .portfolioNameStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${CustomDateFormatter().formatDateStyle(DateTime.parse(widget.dividends.record).toString())}',
                                  style: CustomTextStyles(context).portfolioNameStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${widget.dividends.name.removeStr()} documents which investors will receive dividends.',
                              style: CustomTextStyles(context)
                                  .feedDateStyle
                                  .copyWith(color: textColor.withOpacity(.5)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomDivider(),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        DateTime.now().isAfter(DateTime.parse(widget.dividends.exDate))
                            ? Icons.done
                            : Icons.more_horiz,
                        color: backgroundColour,
                      ),
                      backgroundColor: greenVarient.withOpacity(
                          DateTime.now().isAfter(DateTime.parse(widget.dividends.date)) ? .9 : .2),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment',
                                  style: CustomTextStyles(context)
                                      .portfolioNameStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${CustomDateFormatter().formatDateStyle(DateTime.parse(widget.dividends.date).toString())}',
                                  style: CustomTextStyles(context).portfolioNameStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${widget.dividends.name.removeStr()} pays dividends.',
                              style: CustomTextStyles(context)
                                  .feedDateStyle
                                  .copyWith(color: textColor.withOpacity(.5)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: CustomDecoration().baseContainerDecoration,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dividends Per Share',
                        style: CustomTextStyles(context).portfolioNameStyle,
                      ),
                      Text(
                        '${widget.dividends.amount}',
                        style: CustomTextStyles(context).holdingValueStyle,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: CustomDivider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dividend Yield',
                        style: CustomTextStyles(context).portfolioNameStyle,
                      ),
                      Text(
                        widget.dividends.yield,
                        style: CustomTextStyles(context).holdingValueStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
