import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';

class StepIndicator extends StatelessWidget {
  final String text;
  final bool isGreyed;

  const StepIndicator(
      {super.key,
      required this.text,
      required this.isGreyed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Text(
          text,
          style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: isGreyed ? FontWeight.w300 : FontWeight.w600,
              color: isGreyed ? AppColors.disabled : AppColors.black, fontSize: 12),
        ));
  }
}
