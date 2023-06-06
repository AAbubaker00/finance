import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/services/version/version.dart';
import 'package:Valuid/shared/Custome_Widgets/dialogs/custome_Dialogs.dart';
import 'package:flutter/cupertino.dart';

class UpdateCheck {
  checkUpdate(BuildContext context, var isDark) async {
    try {
      var updateData = //await DatabaseService().checkUpdateStatus();

      var latestVersion = updateData['version'];
      var releaseNotes = updateData['releaseNotes'].toString().replaceAll('\\n', '\n');

      // print(releaseNotes);

      var version = await Version().getPackageInfor();

      double versionDoub = double.parse(version.toString().replaceRange(0, 2, ''));

      double latestVersionDoub = double.parse(latestVersion);

      if (latestVersionDoub > versionDoub) {
        CustomeDialogs(isDark).updateAlertDialoge(context, latestVersion, releaseNotes, version);
      }
    } catch (e) {
      print('////////////////////////////');
      print(e.toString());
      print('////////////////////////////');
    }
  }
}
