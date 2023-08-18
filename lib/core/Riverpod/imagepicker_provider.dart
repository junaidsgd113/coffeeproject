
import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


import '../Service/firestorage_service.dart';
final imageProvider = StateNotifierProvider<ImagepickerNotifier, Uint8List?>((ref) {
  
  return ImagepickerNotifier();
});


class ImagepickerNotifier extends StateNotifier<Uint8List?> {
  ImagepickerNotifier() : super(null);
final firebasestorage=FireStorageService();
  void updateSelectedImage(Uint8List file) {
    state = file;
  }
// void imagePicker( ) async {
//   FilePickerResult? image =
//       await FilePicker.platform.pickFiles(type: FileType.any);
//   if (image != null) {
//     final selectedImageFile = File(image.files.single.path!);
//     updateSelectedImage(selectedImageFile);
//   }
// }
// void imagePicker() async{
//   FilePickerResult? result;
//     try {
//       result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowMultiple: false,
//         allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
//       );
//     } on PlatformException catch (e) {
//       print(e);
//     }
//     if (result != null) {
//     final  studentProfilePic = result.files.first.bytes;
//        updateSelectedImage(studentProfilePic! );
// }
// }
Future<String?> imagePicker() async {
  FilePickerResult? result;
  try {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['png', 'jpg', 'jpeg', ],
    );
  } on PlatformException catch (e) {
    print(e);
  }
 
  if (result != null ) {
    if(!kIsWeb){

    final studentProfilePic = result.files.first;
       // Read the contents of the selected File and convert to Uint8List
    Uint8List imageData = await File(studentProfilePic.path!).readAsBytes();
    var randomid=const Uuid().v1();
    // Upload the image to Firebase Storage and get the download URL
    final imageUrl = await firebasestorage.uploadImage(imageData, randomid);
    
    // Update the selected image and print the URL
    updateSelectedImage(imageData);
   return imageUrl;
   
  }else{
     final studentProfilePic = result.files.first.bytes;
       // Read the contents of the selected File and convert to Uint8List
   
    var randomid=const Uuid().v1();
    // Upload the image to Firebase Storage and get the download URL
    final imageUrl = await firebasestorage.uploadImage(studentProfilePic!, randomid);
    
    // Update the selected image and print the URL
    updateSelectedImage(studentProfilePic);
   return imageUrl;

  }
 
}
 return null;

}}