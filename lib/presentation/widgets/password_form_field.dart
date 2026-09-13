import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class PasswordFormField extends StatefulWidget {
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
  State<StatefulWidget> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text widget to display the label above the TextFormField
        Text(
          widget.labelText, // The custom label text
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(
            height: 8), // Adds some space between the label and input field
        TextFormField(
          // style: context.textTheme.labelMedium,
          textInputAction: TextInputAction.send,
          obscureText: _obscureText,
          onSaved: widget.onSaved,
          autofillHints: const [AutofillHints.password],
          onChanged: widget.onChanged,
          validator: widget.validator,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
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
              onTap: (){
                setState(() {
                  _obscureText = !_obscureText; // Toggle local state
                });
              },
              child: Icon(_obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
            ),
            hintStyle: const TextStyle(
              color: AppColors.disabled,
              fontSize: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
