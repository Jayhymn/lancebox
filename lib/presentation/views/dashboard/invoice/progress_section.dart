import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/progress_item.dart'; // Assuming you're using this for SVG images

class ProgressRow extends StatelessWidget {
  final List<Map<String, dynamic>> progressItems;
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
              (item) {
            return ProgressItem(
              progressLabel: item['label'],
              isGreyed: item['isGreyed'] ?? true,
              flex: item['flex'] ?? 1,
            );
          },
        ),

        if (isFinalStep)
          SvgPicture.asset(ImagesPaths.success),
      ],
    );
  }
}
