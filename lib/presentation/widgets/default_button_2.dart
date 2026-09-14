import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class DefaultButton2 extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;
  final Color buttonColor;
  final Color labelColor;
  final bool outlineBorder;

  const DefaultButton2({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
    required this.buttonColor,
    required this.labelColor,
    this.outlineBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.dynamicScreenHeight(48),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: labelColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: outlineBorder
                ? const BorderSide(color: AppColors.primary, width: 2)
                : BorderSide.none,
          ),
          backgroundColor: buttonColor,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: labelColor,
                      strokeWidth: 2.5,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: labelColor,
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: labelColor,
                ),
              ),
      ),
    );
  }
}