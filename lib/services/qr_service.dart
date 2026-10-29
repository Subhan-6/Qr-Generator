import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

/// Handles everything about the QR image: create, save, share.
class QrService {
  /// Step 3: turn text into PNG image bytes.
  static Future<Uint8List> toPng(String data) async {
    final painter = QrPainter(data: data, version: QrVersions.auto);
    final byteData = await painter.toImageData(1024, format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  /// Step 4: save the image to the phone gallery.
  static Future<void> saveToGallery(String data) async {
    if (!await Gal.hasAccess()) await Gal.requestAccess();
    await Gal.putImageBytes(await toPng(data));
  }

  /// Share the image with other apps (WhatsApp, email, etc).
  static Future<void> share(String data) async {
    final bytes = await toPng(data);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/qr_code.png');
    await file.writeAsBytes(bytes);
    await Share.shareXFiles([XFile(file.path)], text: 'My QR code');
  }
}
