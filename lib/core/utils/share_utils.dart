import 'dart:html' as html;
import 'package:flutter/services.dart';

/// Utility class for sharing functionality
/// 
/// This class provides methods to share content using the Web Share API
/// or fallback methods for browsers that don't support it.
class ShareUtils {
  /// Share the business card URL
  /// 
  /// Uses the Web Share API if available, otherwise falls back to
  /// copying the URL to clipboard.
  static Future<void> shareBusinessCard({
    required String url,
    required String title,
    required String text,
  }) async {
    // Check if Web Share API is available
    final navigator = html.window.navigator;
    final shareFunction = navigator.share;
    if (shareFunction != null) {
      try {
        // Use Web Share API
        await shareFunction({
          'title': title,
          'text': text,
          'url': url,
        });
        return;
      } catch (e) {
        // Fallback if Web Share API fails
      }
    }

    // Fallback: Copy URL to clipboard
    await copyToClipboard(url);
  }

  /// Copy text to clipboard
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}

