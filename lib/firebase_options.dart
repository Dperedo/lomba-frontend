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
    apiKey: 'AIzaSyBo04vjnwIMshIMpQBHPq97sJtmobaFCT4',
    appId: '1:697984302717:web:ae2cb8e8baf17b44327b14',
    messagingSenderId: '697984302717',
    projectId: 'lomba-94302',
    authDomain: 'lomba-94302.firebaseapp.com',
    storageBucket: 'lomba-94302.appspot.com',
    measurementId: 'G-V8LHBP5JL8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoRSyoxNQW7smoQHMKZSSVstVDzfjGDbQ',
    appId: '1:697984302717:android:7a25ab9711f45594327b14',
    messagingSenderId: '697984302717',
    projectId: 'lomba-94302',
    storageBucket: 'lomba-94302.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCfK5iIcTbqKK9GQGxcw7-QJMOxvOYDlKM',
    appId: '1:697984302717:ios:8aeeb190ecddb0a1327b14',
    messagingSenderId: '697984302717',
    projectId: 'lomba-94302',
    storageBucket: 'lomba-94302.appspot.com',
    iosClientId: '697984302717-qq0u5gmp0ogl4e537en7pghflam21j7b.apps.googleusercontent.com',
    iosBundleId: 'com.example.lombaFrontend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCfK5iIcTbqKK9GQGxcw7-QJMOxvOYDlKM',
    appId: '1:697984302717:ios:8aeeb190ecddb0a1327b14',
    messagingSenderId: '697984302717',
    projectId: 'lomba-94302',
    storageBucket: 'lomba-94302.appspot.com',
    iosClientId: '697984302717-qq0u5gmp0ogl4e537en7pghflam21j7b.apps.googleusercontent.com',
    iosBundleId: 'com.example.lombaFrontend',
  );
}
