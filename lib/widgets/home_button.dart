import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget {
  final String buttontext;
  final void Function()? onTap;
  final Color textColor;
  final Color buttonColor;

  const HomeButtons({
    super.key,
    required this.buttonColor,
    required this.buttontext,
    required this.onTap,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * .063,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: buttonColor),
        child: Center(
          child: Text(
            buttontext,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: textColor, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
