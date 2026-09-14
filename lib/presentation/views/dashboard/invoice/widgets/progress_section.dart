import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/widgets/progress_item.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/widgets/step_progress.dart';

class ProgressRow extends StatelessWidget {
  final List<StepProgress> progressItems;
  final bool isFinalStep;

  const ProgressRow({
    super.key,
    required this.progressItems,
    required this.isFinalStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...progressItems.map(
          (item) => ProgressItem(
            progressLabel: item.label,
            isGreyed: item.isGreyed,
            flex: item.flex,
          ),
        ),
        if (isFinalStep) SvgPicture.asset(ImagesPaths.success),
      ],
    );
  }
}