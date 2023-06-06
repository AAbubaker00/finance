import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/dateFormat/customeDateFormatter.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/files/fileHandler.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Valuid/extensions/stringExt.dart';

class NotificationsPage extends StatefulWidget {
  final DataObject dataObject;

  NotificationsPage({Key key, this.dataObject}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void dispose() {
    super.dispose();

    for (var notification in widget.dataObject.notificationsEvents) {
      notification['isSeen'] = now.isAfter(DateTime.parse(notification['date'])) ||
              now.isAtSameMomentAs(DateTime.parse(notification['date']))
          ? true
          : false;
    }

    widget.dataObject.isNotificationOn = false;
  }

  DateTime now = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    void viewFilterPanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: widget.dataObject.context,
          // backgroundColor: Colors.transparent,
          builder: (ctxt) => StatefulBuilder(builder: (contextState, bottomSheetSetState) {
                return MainCustomBottomSheet(
                    showCreateBtn: false,
                    customHeight: true,
                    widget: getFilterPanel(bottomSheetSetState),
                    dataObject: widget.dataObject);
              }));
    }

    return CWScaffold(
      dataObject: widget.dataObject,
      scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
      appBarTitleWidget: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notifications',
              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                  .appBarTitleStyle,
            ),
            InkWell(
              customBorder:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularRadius)),
              onTap: () => viewFilterPanel(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    child: Image.asset(
                  'assets/icons/notifSet.png',
                  width: 20,
                  height: 20,
                  color: UserThemes(widget.dataObject.theme).iconColour,
                )),
              ),
            ),
          ],
        ),
      ),
      body: CWListView(
        centerWidget: widget.dataObject.notificationsEvents
                .where((notification) =>
                    now.isAfter(DateTime.parse(notification['date'])) ||
                    now.isAtSameMomentAs(DateTime.parse(notification['date'])))
                .toList()
                .isEmpty
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/notif.png',
                    color: UserThemes(widget.dataObject.theme).chartTextColour,
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No notifications yet.',
                    style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                        .holdingValueStyle
                        .copyWith(
                          color: UserThemes(widget.dataObject.theme).chartTextColour,
                        ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'When you get notifications they will show up here.',
                      style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                          .portfolioNameStyle
                          .copyWith(
                            color: UserThemes(widget.dataObject.theme).chartTextColour,
                          ),
                    ),
                  ),
                ],
              ))
            : null,
        padding: EdgeInsets.all(10),
        children: widget.dataObject.notificationsEvents
            .where((notification) =>
                now.isAfter(DateTime.parse(notification['date'])) ||
                now.isAtSameMomentAs(DateTime.parse(notification['date'])))
            .toList()
            .map<Widget>((notification) =>
                Padding(padding: EdgeInsets.only(bottom: 10), child: getNotificationType(notification)))
            .toList(),
      ),
    );
  }

  getNotificationType(Map notification) {
    switch (notification['eventType']) {
      case 'Dividends':
        return Container(
          decoration: CustomDecoration(widget.dataObject.theme).curvedBaseContainerDecoration.copyWith(
              color: notification['isSeen']
                  ? UserThemes(widget.dataObject.theme).summaryColour
                  : UserThemes(widget.dataObject.theme).blueVarient.withOpacity(.05)),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(notification['holding'] + ' ' + notification['eventType'],
                  style:
                      CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).holdingValueStyle),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                    'On ${CustomDateFormatter().calenderHeaderStyle(DateTime.parse(notification['date']).toString())}, ${notification['holding']} distributed dividends of ${notification['metric']} per share. You have received ${notification['metric'][0]}${(double.parse((notification['metric'].replaceAll(RegExp("[^\\d.]"), ""))) * notification['shares']).toStringAsFixed(2)} on your ${notification['portfolio']} portfolio.',
                    style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                        .portfolioNameStyle),
              ),
              Text(
                getTimeDifferenceToString(notification),
                style:
                    CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).holdingSubValueStyle,
              ),
            ],
          ),
        );
        break;
      case 'Ex-Date':
        return Container(
          decoration: CustomDecoration(widget.dataObject.theme).curvedBaseContainerDecoration.copyWith(
              color: notification['isSeen']
                  ? UserThemes(widget.dataObject.theme).summaryColour
                  : UserThemes(widget.dataObject.theme).blueVarient.withOpacity(.05)),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(notification['holding'] + ' ' + notification['eventType'],
                  style:
                      CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).holdingValueStyle),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                    'Tommorow is ${notification['holding']} ex-date, last chance to purchase more shares!',
                    style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                        .portfolioNameStyle),
              ),
              Text(
                getTimeDifferenceToString(notification),
                style:
                    CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).holdingSubValueStyle,
              ),
            ],
          ),
        );
        break;
      case 'Earnings':
        return Container(
          decoration: CustomDecoration(widget.dataObject.theme).curvedBaseContainerDecoration.copyWith(
              color: notification['isSeen']
                  ? UserThemes(widget.dataObject.theme).summaryColour
                  : UserThemes(widget.dataObject.theme).blueVarient.withOpacity(.05)),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(notification['holding'] + ' ' + notification['eventType'],
                  style:
                      CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).holdingValueStyle),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text('${notification['holding']} announces earnings today.',
                    style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                        .portfolioNameStyle),
              ),
              Text(
                getTimeDifferenceToString(notification),
                style:
                    CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).holdingSubValueStyle,
              ),
            ],
          ),
        );
        break;
      case 'Holiday':
        return Text('s');

        break;
    }
  }

  getTimeDifferenceToString(notification) {
    Duration difference = DateTime.now().difference(DateTime.parse(notification['date']));

    if (difference.inDays >= 1) {
      return difference.inDays.toInt().toString() + ' days ago';
    } else if (difference.inHours <= 24 && difference.inHours >= 1) {
      return difference.inHours.toInt().toString() + ' hours ago';
    } else if (difference.inMinutes <= 60 && difference.inMinutes >= 1) {
      return difference.inMinutes.toInt().toString() + ' minutes ago';
    } else {
      return difference.inSeconds.toString() + ' seconds';
    }
  }

  getFilterPanel(Function _setState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text('Filter',
        //     style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).portfolioNameStyle),
        Padding(
          padding: const EdgeInsets.symmetric( vertical: 15),
          child: Text('Push notifications',
              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).holdingValueStyle),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0),
          child: CustomDivider(dataObject: widget.dataObject),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Column(
            children: widget.dataObject.notificationSettings
                .map<Widget>((event) => Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15.0, ),
                          decoration: CustomDecoration(widget.dataObject.theme).curvedBaseContainerDecoration,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(event['id'].toString().capitalizeFirst(),
                                  style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                      .sectionHeader),
                              InkWell(
                                customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(circularRadius)),
                                onTap: () => _setState(() {
                                  event['view'] = !event['view'];

                                  for (var notification in widget.dataObject.notificationsEvents) {
                                    if (notification['eventType'] == event['id']) {
                                      notification['isOn'] = event['view'];
                                    }
                                  }

                                  setState(() {});
                                }),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: UserThemes(widget.dataObject.theme).summaryColour,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: VarientColours().eventColours[
                                              widget.dataObject.notificationSettings.indexOf(event)]),
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Icon(Icons.done,
                                        color: event['view']
                                            ? VarientColours().eventColours[
                                                widget.dataObject.notificationSettings.indexOf(event)]
                                            : Colors.transparent)),
                              )
                            ],
                          ),
                        ),
                        widget.dataObject.notificationSettings.last == event
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.symmetric(vertical: 1.0),
                                child: CustomDivider(
                                  dataObject: widget.dataObject,
                                ),
                              ),
                      ],
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
