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
        return ios;
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
    apiKey: 'AIzaSyBt71H5d40oHVCQDTCU_UfftdpPowCR0e4',
    appId: '1:213198839789:web:9ae35a0ff2b2287b7251e4',
    messagingSenderId: '213198839789',
    projectId: 'job-search-app-84ada',
    authDomain: 'job-search-app-84ada.firebaseapp.com',
    storageBucket: 'job-search-app-84ada.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3RlmLForjxzbMqF_XbZrAAekmOAQkIh0',
    appId: '1:213198839789:android:e8b2c079d20d5ec27251e4',
    messagingSenderId: '213198839789',
    projectId: 'job-search-app-84ada',
    storageBucket: 'job-search-app-84ada.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRQaLRGrO4vSupGdo7C-tbdvOnqFwLZR0',
    appId: '1:213198839789:ios:37e5ba42934db8767251e4',
    messagingSenderId: '213198839789',
    projectId: 'job-search-app-84ada',
    storageBucket: 'job-search-app-84ada.appspot.com',
    iosBundleId: 'ptit.trungng.jobSearchAppFrontend',
  );
}