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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDx6clqZiYkiDaEEHVP2YjSWPTwikg-i8E',
    appId: '1:587596448244:web:a593ab5c56f5b9263e79a1',
    messagingSenderId: '587596448244',
    projectId: 'coffee-eaf96',
    authDomain: 'coffee-eaf96.firebaseapp.com',
    storageBucket: 'coffee-eaf96.appspot.com',
    measurementId: 'G-T7DSK54EV8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEvty5sG9uarfASbJNWiLTYkM-dTUDD00',
    appId: '1:587596448244:android:3bb4d262c42926943e79a1',
    messagingSenderId: '587596448244',
    projectId: 'coffee-eaf96',
    storageBucket: 'coffee-eaf96.appspot.com',
  );
}
