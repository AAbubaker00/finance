// import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    var initalizationSettingsAndroid = AndroidInitializationSettings('app_logo');
    // var initalizationSettingsIOS = IOSInitializationSettings(
    //     requestAlertPermission: true,
    //     requestBadgePermission: true,
    //     requestSoundPermission: true,
    //     onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {});

    var initializationSettings = new InitializationSettings(android: initalizationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  }

  Future notificationSelected(String payload) async {}

  Future setNotification({List notificationsEvents}) async {
    tz.initializeTimeZones();

    var androidDetails = new AndroidNotificationDetails(
      'Channel ID',
      'Valuid',
      'This is my notif',
      importance: Importance.max,
      ongoing: true,
      color: Colors.white,
    );

    var iosDetails = new IOSNotificationDetails();

    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    for (var event in notificationsEvents) {
      // await NotificationService()
      //     .flutterLocalNotificationsPlugin
      //     .show(0, 'Dividends', 'You dividends', generalNotificationDetails);

      DateTime scheduleTimeBeforeEvent = DateTime.parse(event['date']).subtract(Duration(days: 1));

      DateTime scheduleTimeAtEvent = DateTime.parse(event['date']);

      // print(scheduleTimeBeforeEvent);
      // print(scheduleTimeAtEvent);

      await flutterLocalNotificationsPlugin.cancelAll();

      if (event['isOn']) {
        // ignore: deprecated_member_use
        await flutterLocalNotificationsPlugin.schedule(
            notificationsEvents.indexOf(event),
            event['eventType'],
            event['holding'] +
                '' +
                (event['eventType'] == 'Holiday'
                    ? ' ${event['metric']}'
                    : ' ${event['eventType'].toString().toLowerCase()} ') +
                ' is tommorrow',
            scheduleTimeBeforeEvent,
            generalNotificationDetails);

        // ignore: deprecated_member_use
        await flutterLocalNotificationsPlugin.schedule(
            notificationsEvents.indexOf(event),
            event['eventType'],
            event['holding'] +
                '' +
                (event['eventType'] == 'Holiday'
                    ? ' ${event['metric']}'
                    : ' ${event['eventType'].toString().toLowerCase()} ') +
                ' is today',
            scheduleTimeAtEvent,
            generalNotificationDetails);
      }
    }
  }
}
