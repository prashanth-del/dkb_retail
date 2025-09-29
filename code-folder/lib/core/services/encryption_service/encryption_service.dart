import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart' hide Hmac;
import 'package:cryptography/cryptography.dart';
import '../../utils/method_channel/custom_method_channel.dart';
import 'package:db_uicomponents/db_uicomponents.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  factory EncryptionService() => _instance;
  EncryptionService._internal();

  String md5Base64(String input) {
    final digest = md5.convert(utf8.encode(input));
    return base64Encode(digest.bytes);
  }

  Future<String> pbkdf2Base64(
      String password,
      List<int> salt, {
        int iterations = 6000,
        int bits = 256,
      }) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterations,
      bits: bits,
    );

    final key = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );

    final keyBytes = await key.extractBytes();
    return base64Encode(keyBytes);
  }

  Future<String> rsaEncrypt(String data, String publicKey) async {
    Map<String, String> toEncrypt = {'val': data, 'pk': publicKey};
    if (Platform.isIOS) {
      return await CustomMethodChannel().encryptCode(toEncrypt: toEncrypt) ?? '';
    } else {
      return await DbChannel().encrypt(toEncrypt: toEncrypt) ?? '';
    }
  }

  Future<String> prepareEncryptedPayload({
    required String username,
    required String password,
    required List<int> clientSalt,
    required String publicKey,
  }) async {
    final md5Pwd = md5Base64(password);
    final pbkdf2Pwd = await pbkdf2Base64(md5Pwd, clientSalt);
    final payload = jsonEncode({'username': username, 'password': pbkdf2Pwd});
    return rsaEncrypt(payload, publicKey);
  }
}
