import 'package:flutter_riverpod/flutter_riverpod.dart';



import '../Service/firestorage_service.dart';

final firestorageProvider =
    StateNotifierProvider<FireStorageNotifier, String?>((ref) {
  return FireStorageNotifier();
});

class FireStorageNotifier extends StateNotifier<String?> {
  FireStorageNotifier() : super(null);

  final firestorage = FireStorageService();
  // Future<void> storeImageFirebaseStorage(File? file) async {
  //   // if (file == null) {
  //   //   return; // Return early if file is null
  //   // }

  //   final imageUrl = await firestorage.uploadFile(file);
  //   state = imageUrl; // Set the state to the download URL
  // }
}
