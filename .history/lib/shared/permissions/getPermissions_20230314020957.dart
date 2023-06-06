import 'package:permission_handler/permission_handler.dart';

class GetPermissions {
  getAllPermissions() async {
    await getStoragePermission();
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
