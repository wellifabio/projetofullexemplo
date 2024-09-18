import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.margin = const EdgeInsets.symmetric(vertical: 5),
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType keyboardType;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 18),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }
}
