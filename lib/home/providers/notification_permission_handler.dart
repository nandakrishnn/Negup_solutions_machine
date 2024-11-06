import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class NotificationPermissionProvider with ChangeNotifier {
  bool _isGranted = false;

  bool get isGranted => _isGranted;

  Future<void> requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      var result = await Permission.notification.request();
      _isGranted = result.isGranted;
      notifyListeners();
    } else {
      _isGranted = true;
      notifyListeners();
    }
  }
}