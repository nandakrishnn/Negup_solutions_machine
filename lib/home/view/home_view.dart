import 'package:flutter/material.dart';
import 'package:negup_solutions_flutter/constants/colors.dart';
import 'package:negup_solutions_flutter/constants/height_width_constants.dart';
import 'package:negup_solutions_flutter/home/view/button_section.dart';
import 'package:negup_solutions_flutter/home/view/home_footer.dart';
import 'package:negup_solutions_flutter/home/services/get_data.dart';
import 'package:provider/provider.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<GetDataFromShared>(context, listen: false).getData();
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
            const HomeFooterWidget()
          ],
        ),
      ),
    );
  }
}
