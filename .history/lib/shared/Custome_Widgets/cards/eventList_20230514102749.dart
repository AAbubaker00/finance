import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
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
                      header: Container(
                          color: summaryColour,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Flexible(child: CustomDivider()),
                              
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                    '${CustomDateFormatter().formatDateWeekdays(DateTime.parse(groupedEvent['date']).toString())}',
                                    style: CustomTextStyles(context).portfolioNameStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))
                                                .isAfter(DateTime.parse(groupedEvent['date']))
                                            ? textColor.withOpacity(.5)
                                            : textColor)),
                              ),
                              Flexible(child: CustomDivider())
                            ],
                          )),
                      sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              bottom: selectedMonth['groupedEvents'].last == groupedEvent &&
                                                      index == groupedEvent['events'].length - 1
                                                  ? 90
                                                  : 5.0),
                                          child: getEventType(groupedEvent['events'][index])),
                                      index == groupedEvent['events'].length - 1
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                              child: CustomDivider(),
                                            ),
                                    ],
                                  ),
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
