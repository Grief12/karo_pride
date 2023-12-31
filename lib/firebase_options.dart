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
    apiKey: 'AIzaSyCjBIxXJhDfY8HBcpnc7FFs4mj-fGSqQlw',
    appId: '1:360804505864:web:5bc1bc4a1bbde95c7374bd',
    messagingSenderId: '360804505864',
    projectId: 'bs02-78f1d',
    authDomain: 'bs02-78f1d.firebaseapp.com',
    storageBucket: 'bs02-78f1d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoVFs6wsEmln2DFisfEsV05-iA-RNbzig',
    appId: '1:360804505864:android:9de397e8619fe5587374bd',
    messagingSenderId: '360804505864',
    projectId: 'bs02-78f1d',
    storageBucket: 'bs02-78f1d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDm_n3QFVfx-3RKvy1e6xws9oqIVcPqtYY',
    appId: '1:360804505864:ios:12f959f053ed834b7374bd',
    messagingSenderId: '360804505864',
    projectId: 'bs02-78f1d',
    storageBucket: 'bs02-78f1d.appspot.com',
    iosClientId: '360804505864-6o8gba6u5mhi7eobp3mhhhk7k1rkf1cf.apps.googleusercontent.com',
    iosBundleId: 'com.example.bSocial02',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDm_n3QFVfx-3RKvy1e6xws9oqIVcPqtYY',
    appId: '1:360804505864:ios:66678399e469c3b97374bd',
    messagingSenderId: '360804505864',
    projectId: 'bs02-78f1d',
    storageBucket: 'bs02-78f1d.appspot.com',
    iosClientId: '360804505864-627jbhdlobnjf8h97et43l78aigjbre0.apps.googleusercontent.com',
    iosBundleId: 'com.example.bSocial02.RunnerTests',
  );
}
