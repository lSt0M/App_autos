import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class ValetStorage {
  static final ValetStorage _ins = ValetStorage._();
  factory ValetStorage() => _ins;
  ValetStorage._();

  Box? encryptedBox;

  initStorage() async {
    if (!kIsWeb) {
      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
    }
    final Box keyBox = await Hive.openBox('encryptionKeyBox');
    if (!keyBox.containsKey('key')) {
      final List<int> key = Hive.generateSecureKey();
      keyBox.put('key', key);
    }
    Uint8List key = keyBox.get('key');
    encryptedBox = await Hive.openBox('vaultBox', encryptionCipher: HiveAesCipher(key));
  }

  Future setItem(String key, value) async {
    await encryptedBox?.put(key, value);
    return await encryptedBox?.get(key);
  }

  Future getItem(String key) async {
    return await encryptedBox?.get(key);
  }

  Future removeItem(String key) async {
    await encryptedBox?.delete(key);
  }

  Future<void> clear() async {
    await encryptedBox?.clear();
  }
}
