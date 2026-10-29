import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Step 3: shows the generated QR code inside a white card.
class QrPreview extends StatelessWidget {
  final String data;

  const QrPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: QrImageView(
          data: data,
          size: 220,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
