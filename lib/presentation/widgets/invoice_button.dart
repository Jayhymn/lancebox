import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/states/invoice_state.dart';

class InvoiceButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const InvoiceButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: context.dynamicScreenHeight(100),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: isSelected
                ? AppColors.secondary
                : AppColors.white,
            side: isSelected
                ? null
                : const BorderSide(width: 2, color: AppColors.borderColor),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: isSelected ? AppColors.white : AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}