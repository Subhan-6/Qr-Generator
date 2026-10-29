import 'package:flutter/material.dart';

/// Save and Share buttons shown under the QR code.
class ActionButtons extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onShare;

  const ActionButtons({super.key, required this.onSave, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: onSave,
          icon: const Icon(Icons.download),
          label: const Text('Save'),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: onShare,
          icon: const Icon(Icons.share),
          label: const Text('Share'),
        ),
      ],
    );
  }
}
