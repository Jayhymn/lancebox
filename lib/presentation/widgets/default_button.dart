import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class DefaultButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;

  const DefaultButton({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultButton2(
      isLoading: isLoading,
      onPressed: onPressed,
      text: text,
      buttonColor: AppColors.primary,
      labelColor: AppColors.white,
    );
  }
}