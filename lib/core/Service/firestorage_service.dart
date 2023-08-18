

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';


class FireStorageService {
  // Future<String> uploadFile(File  file)async{
  //   final filename=basename(file.path);
  //   FirebaseStorage storage=FirebaseStorage.instance;
  //   Reference reference=storage.ref().child('images/$filename');
  //   UploadTask uploadTask=reference.putFile(file);
  //   uploadTask.snapshotEvents.listen((event) {

  //   });
  //   TaskSnapshot ? takeSnapshot=await uploadTask;
  //   final downloadURl= await takeSnapshot.ref.getDownloadURL();
  //   return downloadURl;
  // }
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(Uint8List imageBytes, String imageName) async {
    try {
      final Reference storageRef = _storage.ref().child('images/$imageName');
      final UploadTask uploadTask = storageRef.putData(imageBytes);

      final TaskSnapshot storageSnapshot = await uploadTask;
      final String downloadUrl = await storageSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }
}