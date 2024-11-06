// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
   List<Map<String, double>> locations = [];
  bool _isUpdating = false;
  FlutterLocalNotificationsPlugin? localNotificationsPlugin;
    late Future<void> locationFetchingFuture;

  LocationProvider() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    startNotification();
  }

  bool get isUpdating => _isUpdating;

  Future<void> startNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ng_notifications');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await localNotificationsPlugin!.initialize(initializationSettings);
  }

  Future<void> startLocationUpdates() async {
    _isUpdating = true;
    notifyListeners();
    await showNotification("Location fetching started");
    locationFetchingFuture = fetchLocationtimly();
  }

  Future<void> fetchLocationtimly() async {
    while (_isUpdating) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double speed = position.speed;
      await addLocation(position.latitude, position.longitude,speed);

     
      await Future.delayed(const Duration(seconds: 10));
    }
    
  }

  //this function is used to save the data comming into the shared preferences as a list so that we could get all the data 
   Future<void> addLocation(double latitude, double longitude,double speed) async {
    locations.add({'latitude': latitude, 'longitude': longitude,'speed':speed});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(locations);
    await prefs.setString('locations', jsonString);
    notifyListeners();
  }

  Future<void> showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('Negup', 'Location Updates',
            channelDescription: 'Location tracing is enabled',
            importance: Importance.high,
            icon: 'ng_notifications',
            priority: Priority.high);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    
    await localNotificationsPlugin!.show(0, 'Notification', message, platformChannelSpecifics);
  }

 Future<void> stopLocationUpdates() async {
    _isUpdating = false;
    await locationFetchingFuture; 
    notifyListeners();
    await showNotification("Location fetching stopped");
  }
}
