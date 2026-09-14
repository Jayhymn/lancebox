import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class PasswordFormField extends StatefulWidget {
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final VoidCallback toggleVisibility;
  final String labelText;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const PasswordFormField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    required this.validator,
    required this.obscureText,
    required this.toggleVisibility,
    required this.labelText,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(PasswordFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _obscureText = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        TextFormField(
          textInputAction: widget.textInputAction,
          obscureText: _obscureText,
          focusNode: widget.focusNode,
          onSaved: widget.onSaved,
          autofillHints: const [AutofillHints.password],
          onChanged: widget.onChanged,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            hintText: "********",
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(_obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
