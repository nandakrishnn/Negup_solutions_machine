import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
  bool _isUpdating = false;
  FlutterLocalNotificationsPlugin? _localNotificationsPlugin;

  LocationProvider() {
    _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
  }

  bool get isUpdating => _isUpdating;

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _localNotificationsPlugin!.initialize(initializationSettings);
  }

  Future<void> startLocationUpdates() async {
    _isUpdating = true;
    notifyListeners();
    await showNotification("Location update started");
    _fetchLocationPeriodically();
  }

  Future<void> _fetchLocationPeriodically() async {
    while (_isUpdating) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      
      // Save to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('latitude', position.latitude);
      await prefs.setDouble('longitude', position.longitude);

      // Here, you can display the location data as needed
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

      // Wait for 30 seconds before fetching the next location
      await Future.delayed(Duration(seconds: 30));
    }
  }

  Future<void> showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('Negup', 'Location Updates',
            channelDescription: 'Location tracing is enabled',
            importance: Importance.high,
            priority: Priority.high);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    
    await _localNotificationsPlugin!.show(0, 'Notification', message, platformChannelSpecifics);
  }

  void stopLocationUpdates() {
    _isUpdating = false;
    notifyListeners();
  }
}
