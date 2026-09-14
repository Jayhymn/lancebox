import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class EmailFormField extends StatelessWidget {
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final String labelText;

  const EmailFormField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    required this.validator,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onSaved: onSaved,
          autofillHints: const [AutofillHints.email],
          onChanged: onChanged,
          validator: validator,
          decoration: const InputDecoration(
            hintText: "lancebox@example.com",
          ),
        ),
      ],
    );
  }
}
