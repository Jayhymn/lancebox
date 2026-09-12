import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const EmailFormField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      onSaved: onSaved,
      autofillHints: const [AutofillHints.email],
      onChanged: onChanged,
      validator: validator,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        labelText: "Email",
        hintText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
