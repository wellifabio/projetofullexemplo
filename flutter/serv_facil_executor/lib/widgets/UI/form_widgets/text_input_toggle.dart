import 'package:flutter/material.dart';

class TextInputToggle extends StatefulWidget {
  const TextInputToggle({
    super.key,
    required this.validator,
    required this.controller,
    required this.text,
    this.margin = EdgeInsets.zero,
    this.keyboardType = TextInputType.text,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String text;
  final EdgeInsets margin;
  final TextInputType keyboardType;

  @override
  State<TextInputToggle> createState() => _TextInputToggleState();
}

class _TextInputToggleState extends State<TextInputToggle> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: obscureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          hintText: widget.text,
          hintStyle: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          ),
          suffixIconColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
