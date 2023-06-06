import 'package:permission_handler/permission_handler.dart';

class GetPermissions {

  private void requestPermission() {
    if (SDK_INT >= Build.VERSION_CODES.R) {
        try {
            Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
            intent.addCategory("android.intent.category.DEFAULT");
            intent.setData(Uri.parse(String.format("package:%s",getApplicationContext().getPackageName())));
            startActivityForResult(intent, 2296);
        } catch (Exception e) {
            Intent intent = new Intent();
            intent.setAction(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION);
            startActivityForResult(intent, 2296);
        }
    } else {
        //below android 11
        ActivityCompat.requestPermissions(PermissionActivity.this, new String[]{WRITE_EXTERNAL_STORAGE}, PERMISSION_REQUEST_CODE);
    }
}

  getAllPermissions() async {
    var statusTransperency = await Permission.appTrackingTransparency.status;
    if (!statusTransperency.isGranted) {
      await Permission.appTrackingTransparency.request();
    }
  }


  getStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  getLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
  }

  getBluetoothPermission() async {
    var status = await Permission.bluetooth.status;
    if (!status.isGranted) {
      await Permission.bluetooth.request();
    }
  }

  getNotificationPermission() async {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }

  getRemindersPermission() async {
    var status = await Permission.reminders.status;
    if (!status.isGranted) {
      await Permission.reminders.request();
    }
  }

  getAppTrackingTransparencyPermission() async {
    var status = await Permission.appTrackingTransparency.status;
    if (!status.isGranted) {
      await Permission.appTrackingTransparency.request();
    }
  }
}
