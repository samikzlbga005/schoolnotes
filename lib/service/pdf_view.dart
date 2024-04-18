import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PdfApi {
  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$filename");
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<File?> loadFirebase(String url) async {
    try {
      final refPdf = FirebaseStorage.instance.ref().child("$url");
      final bytes = await refPdf.getData();
      return await _storeFile(url, bytes!);
    } catch (e) {
      return null;
    }
  }
}
