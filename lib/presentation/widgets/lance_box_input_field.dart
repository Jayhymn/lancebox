import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class LanceIBoxInputField extends StatelessWidget {
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final String labelText; // Add labelText to pass custom text
  final TextInputType inputType;
  final String hintText;
  final List<String> autoFills;
  final bool textCaps;

  const LanceIBoxInputField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    required this.validator,
    required this.labelText, // Initialize labelText
    required this.inputType,
    required this.hintText,
    required this.autoFills,
    this.textCaps = false
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
          keyboardType: inputType,
          onSaved: onSaved,
          autofillHints: autoFills,
          onChanged: onChanged,
          validator: validator,
          textCapitalization: textCaps ? TextCapitalization.words : TextCapitalization.none,
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
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
