import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/states/invoice_state.dart';

class InvoiceButton extends StatelessWidget {
  final String titleLabel;
  final String bodyLabel;
  final bool isSelected;
  final bool useInkwell;
  final VoidCallback onPressed;

  const InvoiceButton({
    super.key,
    required this.titleLabel,
    required this.bodyLabel,
    required this.isSelected,
    required this.onPressed,
    required this.useInkwell,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: context.dynamicScreenHeight(140),
        child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor:
                  isSelected ? AppColors.secondary : AppColors.primaryLight,
              side: isSelected
                  ? null
                  : const BorderSide(width: 2, color: AppColors.borderColor),
            ),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!useInkwell)
                    SvgPicture.asset(
                      ImagesPaths.plus,
                      color: isSelected ? AppColors.white : AppColors.secondary,
                    ),
                  Text(
                    titleLabel,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.white : AppColors.secondary,
                    ),
                  ),
                  if (useInkwell)
                    Text(
                      "0",
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? AppColors.white : AppColors.secondary,
                      ),
                    ),
                  Text(
                    bodyLabel,
                    style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color:
                            isSelected ? AppColors.white : AppColors.secondary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.secondary,
                        decorationThickness: 1.5),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
