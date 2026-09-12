import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final VoidCallback toggleVisibility;

  const PasswordFormField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    required this.validator,
    required this.obscureText,
    required this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.send,
      obscureText: obscureText,
      onSaved: onSaved,
      autofillHints: const [AutofillHints.password],
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: GestureDetector(
          onTap: toggleVisibility,
          child: Icon(obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined),
        ),
      ),
    );
  }
}
