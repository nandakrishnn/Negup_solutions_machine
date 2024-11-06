// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
   List<Map<String, double>> locations = [];
  bool _isUpdating = false;
  FlutterLocalNotificationsPlugin? notificationsPlugin;
  Completer<void>? _stopFetch;

  LocationProvider() {
    notificationsPlugin = FlutterLocalNotificationsPlugin();
    startNotification();
  }

  bool get isUpdating => _isUpdating;
//function used to trigger the notificcations
  Future<void> startNotification() async {
    const AndroidInitializationSettings initializeSettings =
        AndroidInitializationSettings('ng_notifications');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializeSettings);

    await notificationsPlugin!.initialize(initializationSettings);
  }

  Future<void> startLocationUpdates() async {
    _isUpdating = true;
    notifyListeners();
    await showNotification("Location fetching started");
    _stopFetch = Completer<void>();
    fetchLocationtimly();
  }

  //function for feticng location automatically on every 30 seconds

  Future<void> fetchLocationtimly() async {
    while (_isUpdating&&!_stopFetch!.isCompleted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double speed = position.speed;
      await addLocation(position.latitude, position.longitude,speed);

     
       await Future.any([
        Future.delayed(const Duration(seconds: 30)),
        _stopFetch!.future,
      ]);
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

  //function responsible for showing the notifications 

  Future<void> showNotification(String message) async {
    const AndroidNotificationDetails androidChannel =
        AndroidNotificationDetails('Negup', 'Location Updates',
            channelDescription: 'Location tracing is enabled',
            importance: Importance.high,
            icon: 'ng_notifications',
            priority: Priority.high);

    const NotificationDetails platformChanel =
        NotificationDetails(android: androidChannel);
    
    await notificationsPlugin!.show(0, 'Notification', message, platformChanel);
  }
//function used to stop the location updates
 Future<void> stopLocationUpdates() async {
    _isUpdating = false;
    _stopFetch?.complete(); 
    _stopFetch = null;

    notifyListeners();
    await showNotification("Location Update stopped");
  }
}
