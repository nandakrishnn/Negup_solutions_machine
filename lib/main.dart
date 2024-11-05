import 'package:flutter/material.dart';
import 'package:negup_solutions_flutter/home/home_view.dart';
import 'package:negup_solutions_flutter/home/state/get_data.dart';
import 'package:negup_solutions_flutter/home/state/notification_permission_handler.dart';
import 'package:negup_solutions_flutter/home/state/permission_provider.dart';
import 'package:negup_solutions_flutter/home/state/start_location_update.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PermissionProvider()),
      ChangeNotifierProvider(create: (_)=>NotificationPermissionProvider()),
      ChangeNotifierProvider(create: (_)=>LocationProvider()),
      ChangeNotifierProvider(create: (_)=>GetDataFromShared())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeViewPage(),
    );
  }
}
