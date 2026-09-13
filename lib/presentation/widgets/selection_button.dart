import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class SelectionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const SelectionButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.dynamicScreenHeight(80),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor:
          isSelected ? AppColors.secondary : AppColors.white,
          side: isSelected
              ? null
              : const BorderSide(width: 2, color: AppColors.borderColor),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
