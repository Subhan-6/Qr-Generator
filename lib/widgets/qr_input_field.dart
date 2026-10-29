import 'package:flutter/material.dart';

/// Step 1: text box where the user types a text or URL.
class QrInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const QrInputField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => onSubmit(),
      decoration: InputDecoration(
        labelText: 'Enter text or URL',
        prefixIcon: const Icon(Icons.link),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: controller.clear,
        ),
      ),
    );
  }
}
