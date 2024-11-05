import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDataFromShared with ChangeNotifier {
    List<Map<String, double>> locations = []; 
  Timer? _timer;
    GetDataFromShared() {
  
    _startPeriodicUpdate();
  }
    void _startPeriodicUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      print('updated updated');
      getData();
    });
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('locations');
    
    if (jsonString != null) {
      List<dynamic> jsonList = json.decode(jsonString);
      locations = jsonList.map((json) => Map<String, double>.from(json)).toList();
    }
    notifyListeners();
  }
}
