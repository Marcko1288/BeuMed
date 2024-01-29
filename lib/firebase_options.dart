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
    apiKey: 'AIzaSyAFmR6ROp2Dj7xA8fKSdKIi5Xg-fxnnAu4',
    appId: '1:581527734374:web:87f688e9423ea7efa1c5a7',
    messagingSenderId: '581527734374',
    projectId: 'beumed-97c9e',
    authDomain: 'beumed-97c9e.firebaseapp.com',
    storageBucket: 'beumed-97c9e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsgqE0IUmN-0-ppg2SvVhZe9haoS8Uq1g',
    appId: '1:581527734374:android:38ef5d6bb8461b02a1c5a7',
    messagingSenderId: '581527734374',
    projectId: 'beumed-97c9e',
    storageBucket: 'beumed-97c9e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNgC9L9HcsVuEYLZm_qCUzunf9TucvB_0',
    appId: '1:581527734374:ios:f34a6a7dc87fe8d4a1c5a7',
    messagingSenderId: '581527734374',
    projectId: 'beumed-97c9e',
    storageBucket: 'beumed-97c9e.appspot.com',
    iosBundleId: 'com.example.beumed',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNgC9L9HcsVuEYLZm_qCUzunf9TucvB_0',
    appId: '1:581527734374:ios:e136dfbecb160868a1c5a7',
    messagingSenderId: '581527734374',
    projectId: 'beumed-97c9e',
    storageBucket: 'beumed-97c9e.appspot.com',
    iosBundleId: 'com.example.beumed.RunnerTests',
  );
}
