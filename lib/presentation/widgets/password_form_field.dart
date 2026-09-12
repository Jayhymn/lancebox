import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class PasswordFormField extends StatelessWidget {
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final VoidCallback toggleVisibility;
  final String labelText; // Add labelText to pass custom text

  const PasswordFormField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    required this.validator,
    required this.obscureText,
    required this.toggleVisibility,
    required this.labelText, // Initialize labelText
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text widget to display the label above the TextFormField
        Text(
          labelText, // The custom label text
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(
            height: 8), // Adds some space between the label and input field
        TextFormField(
          // style: context.textTheme.labelMedium,
          textInputAction: TextInputAction.send,
          obscureText: obscureText,
          onSaved: onSaved,
          autofillHints: const [AutofillHints.password],
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                )),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            hintText: "********",
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: GestureDetector(
              onTap: toggleVisibility,
              child: Icon(obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
            ),
            hintStyle: const TextStyle(
              color: AppColors.disabled,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
