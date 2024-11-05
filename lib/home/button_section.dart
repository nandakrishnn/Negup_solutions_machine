// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:negup_solutions_flutter/constants/colors.dart';
import 'package:negup_solutions_flutter/home/state/get_data.dart';
import 'package:negup_solutions_flutter/home/state/notification_permission_handler.dart';
import 'package:negup_solutions_flutter/home/state/permission_provider.dart';
import 'package:negup_solutions_flutter/home/state/start_location_update.dart';
import 'package:negup_solutions_flutter/widgets/home_button.dart';
import 'package:provider/provider.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTabView = screenWidth >= 600;

    return isTabView
        ? GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 4,
            children: buildButtonList(context),
          )
        : ListView(
            children: buildButtonList(context)
                .map((button) => Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: button,
                    ))
                .toList(),
          );
  }

  List<Widget> buildButtonList(BuildContext context) {
    final permissionProvider =
        Provider.of<PermissionProvider>(context, listen: false);
    final notificationProvider =
        Provider.of<NotificationPermissionProvider>(context, listen: false);

    return [
      HomeButtons(
        buttonColor: AppColors.blueColor,
        buttontext: 'Request Location Permission',
        onTap: () => permissionProvider.requestLocationPermission(),
        textColor: AppColors.whiteColor,
      ),
      HomeButtons(
        buttonColor: AppColors.yellowColor,
        buttontext: 'Request Notification Permission',
        onTap: () async {
          debugPrint('requesting notification permission');
          await notificationProvider.requestNotificationPermission();
          if (notificationProvider.isGranted) {
            debugPrint('notification permission granted');
          } else {
            debugPrint('notification permission not allowed');
          }
        },
        textColor: AppColors.blackColor,
      ),
      HomeButtons(
        buttonColor: AppColors.greenColor,
        buttontext: 'Start Location Update',
        onTap: () async {
          final isStarted = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm Location update'),
                  content: const Text('Do you want to start location updates?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Yes'))
                  ],
                );
                
              });
                if (isStarted == true) {
      await context.read<LocationProvider>().startLocationUpdates();
        await context.read<GetDataFromShared>().getData();

    }
        },
        textColor: AppColors.whiteColor,
      ),
      HomeButtons(
        buttonColor: AppColors.redColor,
        buttontext: 'Stop Location Update',
        onTap: () {},
        textColor: AppColors.whiteColor,
      ),
    ];
  }
}
