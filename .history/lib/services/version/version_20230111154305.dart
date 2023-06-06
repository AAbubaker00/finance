import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
// import 'package:package_info/package_info.dart';

class Version {
  // PackageInfo packageInfo;
  Future getPackageInfor() async {
    try {
      packageInfo = await PackageInfo.fromPlatform();

      return packageInfo.version;
    } catch (e) {
      PrintFunctions().printError(e);

      return null;     }
  }
}
