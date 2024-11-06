import 'package:flutter/material.dart';
import 'package:negup_solutions_flutter/constants/colors.dart';
import 'package:negup_solutions_flutter/constants/height_width_constants.dart';
import 'package:negup_solutions_flutter/widgets/lat_lang_text.dart';

class BodyContainerFooter extends StatelessWidget {
  final String request;
  final String lat;
  final String long;
  final double speed;
  const BodyContainerFooter(
      {super.key,
      required this.request,
      required this.lat,
      required this.long,
      required this.speed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        padding: const EdgeInsets.all(9),
        height: MediaQuery.of(context).size.height * .088,
        decoration: BoxDecoration(
          color: AppColors.bottomContainerColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request,
              style: const TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppConstants.kheight10,
            Row(
              children: [
                LatLangText(
                  headText: 'Lat: ',
                  subtext: '' + '${lat.length > 5 ? lat.substring(0, 5) : lat}',
                ),
                AppConstants.kwidth20,
                LatLangText(
                  headText: 'Lng: ',
                  subtext:
                      '' + '${long.length > 5 ? long.substring(0, 5) : long}',
                ),
                AppConstants.kwidth20,
                LatLangText(
                  headText: 'Speed: ',
                  subtext: speed == 0
                      ? '00m'
                      : (speed < 1
                                  ? '${(speed * 100000).round()}m'
                                  : '${speed.toStringAsFixed(0)}m')
                              .substring(0, 2) +
                          'm',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
