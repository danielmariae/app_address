import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashUtil {
  static String generate(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}