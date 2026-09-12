import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';

class FormError extends StatelessWidget {
  const FormError({
    super.key,
    required this.errors,
  });

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index]!)),
    );
  }

  Row formErrorText(BuildContext context, {required String error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: context.dynamicScreenHeight(14),
          width: context.dynamicScreenHeight(14),
        ),
        SizedBox(
          width: context.dynamicScreenHeight(10),
        ),
        SizedBox(
          width: context.dynamicScreenWidth(300),
          child: Text(error,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}