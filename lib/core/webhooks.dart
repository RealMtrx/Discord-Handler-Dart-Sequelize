import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class Webhooks {
  static Future<void> sendError(String message) async {
    final config = Config();
    final url = config.webhookUrl;
    if (url == null || url.isEmpty) return;

    try {
      await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'content': message.substring(0, message.length.clamp(0, 2000)),
        }),
      );
    } catch (_) {}
  }

  static Future<void> send({
    required String content,
    String? username,
    String? avatarUrl,
  }) async {
    final config = Config();
    final url = config.webhookUrl;
    if (url == null || url.isEmpty) return;

    try {
      await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'content': content.substring(0, content.length.clamp(0, 2000)),
          if (username != null) 'username': username,
          if (avatarUrl != null) 'avatar_url': avatarUrl,
        }),
      );
    } catch (_) {}
  }
}
