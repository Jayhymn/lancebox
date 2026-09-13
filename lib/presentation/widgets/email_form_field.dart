import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class EmailFormField extends StatelessWidget {
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final String labelText; // Add labelText to pass custom text

  const EmailFormField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    required this.validator,
    required this.labelText, // Initialize labelText
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText, // The custom label text
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            hintText: "lancebox@example.com",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding:
            EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            hintStyle: TextStyle(
              color: AppColors.disabled,
              fontSize: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
