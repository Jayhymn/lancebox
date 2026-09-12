import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class DefaultButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;

  const DefaultButton({
    super.key,
    required this.text,
    this.press,
    required this.isLoading,
    required this.onPressed,
  });

  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.dynamicScreenHeight(48),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: AppColors.primary,
        ),
        onPressed: isLoading ? null : onPressed, // Disable button if loading
        child: Text(
          text,
          style: context.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
