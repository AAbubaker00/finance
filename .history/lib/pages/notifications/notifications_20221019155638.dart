import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
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
      dataObject: widget.dataObject,
      appBarTitleWidget: Padding(
        padding: const EdgeInsets.only(left: 15.0)RIGHT:,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notifications',
              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                  .holdingValueStyle
                  .copyWith(color: UserThemes(widget.dataObject.theme).blueVarient),
            ), Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                                    child: Image.asset(
                                  'assets/icons/edit.png',
                                  width: 22,
                                  height: 22,
                                  color: UserThemes(widget.dataObject.theme).blueVarient,
                                )),
            ),
          ],
        ),
      ),
    );
  }
}
