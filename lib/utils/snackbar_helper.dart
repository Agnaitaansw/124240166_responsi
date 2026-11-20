import 'package:flutter/material.dart';

/// Key global supaya snackbar tetap bisa tampil setelah pindah halaman
/// (contoh: setelah logout kembali ke halaman login).
final GlobalKey<ScaffoldMessengerState> messengerKey =
    GlobalKey<ScaffoldMessengerState>();

/// Snackbar bergaya "toast" di bagian atas layar (hijau = sukses, merah = gagal).
void showTopSnackBar({
  required String title,
  required String message,
  required bool success,
}) {
  final view = WidgetsBinding.instance.platformDispatcher.views.first;
  final screenHeight = view.physicalSize.height / view.devicePixelRatio;

  final messenger = messengerKey.currentState;
  if (messenger == null) return;

  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: success ? Colors.green : Colors.red,
        margin: EdgeInsets.only(
          bottom: screenHeight - 170,
          left: 12,
          right: 12,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(message, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
}