import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  final DataObject dataObject;

  NotificationsPage({Key key, this.dataObject}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitleWidget: Row(
        children: [Text('Notifications', )],
      ),
    );
  }
}
