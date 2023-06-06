import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dateFormat/customeDateFormatter.dart';
import 'package:valuid/shared/dividends/dividends.dart';
import 'package:valuid/shared/earnings/earnings.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';

class EventList extends StatelessWidget {
  final Map selectedMonth;
  const EventList(this.selectedMonth);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
            child: CustomScrollView(
                shrinkWrap: true,
                slivers: selectedMonth['groupedEvents'].map<Widget>((groupedEvent) {
                  return SliverStickyHeader(
                      header: Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: summaryColour,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(circularRadius),
                                      bottomRight: Radius.circular(circularRadius))
                                      ),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: backgroundColourVarient.withOpacity(.4),
                                      border: Border.only(
                                          color: seperator.withOpacity(.5), width: .4),
                                      borderRadius: BorderRadius.circular(circularRadius)),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                      '${CustomDateFormatter().calenderHeaderStyle(DateTime.parse(groupedEvent['date']).toString())}',
                                      style: CustomTextStyles(context).portfolioNameStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                          color:
                                              DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))
                                                      .isAfter(DateTime.parse(groupedEvent['date']))
                                                  ? textColor.withOpacity(.6)
                                                  : textColor))))),
                      sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => Padding(padding: EdgeInsets.only(bottom: selectedMonth['groupedEvents'].last == groupedEvent && index == groupedEvent['events'].length - 1 ? 90 : 8.0), child: getEventType(groupedEvent['events'][index])),
                              childCount: groupedEvent['events'].length)));
                }).toList())));
  }

  Widget getEventType(dynamic event) {
    if (event.runtimeType == Earnings) {
      return EarningsWidget(
        earnigns: event,
      );
    } else if (event.runtimeType == Dividends) {
      return DividendsWidget(
        dividend: event,
      );
    } else {
      return Text('0');
    }
  }
}
