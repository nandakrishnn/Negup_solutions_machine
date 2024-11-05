import 'package:flutter/material.dart';
import 'package:negup_solutions_flutter/constants/colors.dart';
import 'package:negup_solutions_flutter/constants/height_width_constants.dart';
import 'package:negup_solutions_flutter/home/button_section.dart';
import 'package:negup_solutions_flutter/widgets/lat_lang_text.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .44,
              color: AppColors.darkGrey,
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test App',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    AppConstants.kheight15,
                    Expanded(child: ButtonSection()),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                padding: EdgeInsets.all(9),
                         height: MediaQuery.of(context).size.height * .088,
                decoration: BoxDecoration(
                  color: AppColors.bottomContainerColor,
                    borderRadius: BorderRadius.circular(6),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Request1',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppConstants.kheight10,
                    Row(
                    
                      children: [
                        LatLangText(
                          headText: 'Lat:',
                          subtext: ' 4.321',
                        ),
                        AppConstants.kwidth20,
                           LatLangText(
                          headText: 'Lng:',
                          subtext: ' 4.321',
                        ), AppConstants.kwidth20,
                           LatLangText(
                          headText: 'Speed',
                          subtext: ' 4.321',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
