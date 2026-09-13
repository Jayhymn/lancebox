import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/presentation/widgets/step_indicator.dart';

class ProgressItem extends StatelessWidget {
  final String progressLabel;
  final bool isGreyed;
  final int flex;

  const ProgressItem({
    super.key,
    required this.progressLabel,
    this.isGreyed = false,
    required this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Row(
        children: [
          Expanded(
            child: StepIndicator(
              text: progressLabel,
              isGreyed: isGreyed,
            ),
          ),
          Opacity(
            opacity: isGreyed ? 0.3 : 1,
            child: SvgPicture.asset(
              ImagesPaths.forwardArrow,
            ),
          ),
        ],
      ),
    );
  }
}
