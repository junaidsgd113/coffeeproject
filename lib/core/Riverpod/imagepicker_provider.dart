import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import '../Service/firestorage_service.dart';

final imageProvider =
    StateNotifierProvider<ImagepickerNotifier, Uint8List?>((ref) {
  return ImagepickerNotifier();
});

class ImagepickerNotifier extends StateNotifier<Uint8List?> {
  ImagepickerNotifier() : super(null);
  final firebasestorage = FireStorageService();
  void updateSelectedImage(Uint8List file) {
    state = file;
  }

  Future<void> imagePicker() async {
    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: [
          'png',
          'jpg',
          'jpeg',
        ],
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (result != null) {
      if (!kIsWeb) {
        final studentProfilePic = result.files.first;
        // Read the contents of the selected File and convert to Uint8List
        Uint8List imageData = await File(studentProfilePic.path!).readAsBytes();
        updateSelectedImage(imageData);
      } else {
        final studentProfilePic = result.files.first.bytes;

        updateSelectedImage(studentProfilePic!);
      }
    }
  }
}
