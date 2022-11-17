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
    apiKey: 'AIzaSyCKoHJBHx1-9mQm4Ntgm5sKze472bU6lHU',
    appId: '1:534462304534:web:69bf8debf24b9010f50037',
    messagingSenderId: '534462304534',
    projectId: 'mynewapp-2f48a',
    authDomain: 'mynewapp-2f48a.firebaseapp.com',
    storageBucket: 'mynewapp-2f48a.appspot.com',
    measurementId: 'G-GWVE2Z94F0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARXuCt-zHo9WLUxf1adMGJl3TywoyhygY',
    appId: '1:534462304534:android:90632b78e5becb83f50037',
    messagingSenderId: '534462304534',
    projectId: 'mynewapp-2f48a',
    storageBucket: 'mynewapp-2f48a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOVQGDMXlvR8-vcAqKIErKked4r5EAAAM',
    appId: '1:534462304534:ios:eb1641b3cfe0dfeaf50037',
    messagingSenderId: '534462304534',
    projectId: 'mynewapp-2f48a',
    storageBucket: 'mynewapp-2f48a.appspot.com',
    iosClientId: '534462304534-a3fboiscu840dqpmgkk1bq6v3qcj8jmv.apps.googleusercontent.com',
    iosBundleId: 'com.example.myNewApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOVQGDMXlvR8-vcAqKIErKked4r5EAAAM',
    appId: '1:534462304534:ios:eb1641b3cfe0dfeaf50037',
    messagingSenderId: '534462304534',
    projectId: 'mynewapp-2f48a',
    storageBucket: 'mynewapp-2f48a.appspot.com',
    iosClientId: '534462304534-a3fboiscu840dqpmgkk1bq6v3qcj8jmv.apps.googleusercontent.com',
    iosBundleId: 'com.example.myNewApp',
  );
}
