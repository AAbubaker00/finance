import 'package:Strice/services/database/database.dart';
import 'package:Strice/services/version/version.dart';
import 'package:Strice/shared/Custome_Widgets/dialogs/custome_Dialogs.dart';
import 'package:flutter/cupertino.dart';

class Calls {
  checkUpdate(BuildContext context, String) async {
    try {
      var updateData = await DatabaseService().checkUpdateStatus();

      var latestVersion = updateData['version'];
      var releaseNotes = updateData['releaseNotes'].toString().replaceAll('\\n', '\n');

      // print(releaseNotes);

      var version = await Version().getPackageInfor();

      double versionDoub = double.parse(version.toString().replaceRange(0, 2, ''));

      double latestVersionDoub = double.parse(latestVersion);

      if (latestVersionDoub > versionDoub) {
        CustomeDialogs().updateAlertDialoge(context, latestVersion, releaseNotes, version);
      }
    } catch (e) {
      print('////////////////////////////');
      print(e.toString());
      print('////////////////////////////');
    }
  }
}
