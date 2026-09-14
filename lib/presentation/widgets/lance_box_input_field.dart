import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class LanceIBoxInputField extends StatelessWidget {
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final String labelText;
  final TextInputType inputType;
  final String hintText;
  final List<String> autoFills;
  final bool textCaps;
  final double percentScreenWidth;

  const LanceIBoxInputField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    required this.validator,
    required this.labelText,
    required this.inputType,
    required this.hintText,
    required this.autoFills,
    this.percentScreenWidth = 1.0,
    this.textCaps = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: context.percentScreenWidth(percentScreenWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: inputType,
              onSaved: onSaved,
              autofillHints: autoFills,
              onChanged: onChanged,
              validator: validator,
              textCapitalization:
                  textCaps ? TextCapitalization.words : TextCapitalization.none,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: AppColors.borderColor, width: 2),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                hintText: hintText,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                hintStyle: const TextStyle(
                  color: AppColors.disabled,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}