import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
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
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          hintText: text,
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
        ),
      ),
    );
  }
}
