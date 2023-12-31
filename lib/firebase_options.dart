// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAwGRtoz_3Kgury9CTp4sETZZ4jtsV0XT8',
    appId: '1:1000630616489:web:2fb0022aac0c81533b44b8',
    messagingSenderId: '1000630616489',
    projectId: 'product-292cd',
    authDomain: 'product-292cd.firebaseapp.com',
    storageBucket: 'product-292cd.appspot.com',
    measurementId: 'G-RY5V0BC7QH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvMj0q5rpcM7ioEL0tKrIqYS009mpW1FY',
    appId: '1:1000630616489:android:a70e8ebbc2acfc7c3b44b8',
    messagingSenderId: '1000630616489',
    projectId: 'product-292cd',
    storageBucket: 'product-292cd.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgQIuxi2mQftNvCKDGIkps792I_EvHmA8',
    appId: '1:1000630616489:ios:a2ee7621c79f5f3c3b44b8',
    messagingSenderId: '1000630616489',
    projectId: 'product-292cd',
    storageBucket: 'product-292cd.appspot.com',
    iosClientId: '1000630616489-3fmj99juiun05il5j59v83t37o7bmrtq.apps.googleusercontent.com',
    iosBundleId: 'com.example.coffeeproject.RunnerTests',
  );
}
