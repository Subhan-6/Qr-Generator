import 'package:flutter/material.dart';

import '../services/qr_service.dart';
import '../widgets/action_buttons.dart';
import '../widgets/qr_input_field.dart';
import '../widgets/qr_preview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  String? _qrData; // null = nothing generated yet

  void _generate() {
    final text = _controller.text.trim();
    if (text.isEmpty) return _message('Please enter some text or a URL');
    FocusScope.of(context).unfocus();
    setState(() => _qrData = text);
  }

  Future<void> _save() async {
    try {
      await QrService.saveToGallery(_qrData!);
      _message('Saved to gallery');
    } catch (e) {
      _message('Could not save: $e');
    }
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Generator')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          QrInputField(controller: _controller, onSubmit: _generate),
          const SizedBox(height: 16),
          FilledButton(onPressed: _generate, child: const Text('Generate QR')),
          const SizedBox(height: 32),
          if (_qrData != null) ...[
            Center(child: QrPreview(data: _qrData!)),
            const SizedBox(height: 24),
            ActionButtons(
              onSave: _save,
              onShare: () => QrService.share(_qrData!),
            ),
          ],
        ],
      ),
    );
  }
}
