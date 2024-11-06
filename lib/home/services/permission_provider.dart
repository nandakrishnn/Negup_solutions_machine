import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider with ChangeNotifier {
  bool _locationPermissionGranted = false;

  bool get locationPermissionGranted => _locationPermissionGranted;

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    _locationPermissionGranted = status.isGranted;
    notifyListeners();
  }
}