
import 'package:flutter/material.dart';
import 'package:negup_solutions_flutter/constants/colors.dart';

class LatLangText extends StatelessWidget {
 final String headText;
 final String subtext;
  const LatLangText({
    
    super.key,
    required this.headText,
    required this.subtext
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: headText,
            style:const TextStyle(
              color: AppColors.blackColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          TextSpan(
            text: subtext,
            style:const TextStyle(
              color: AppColors.blackColor, 
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
