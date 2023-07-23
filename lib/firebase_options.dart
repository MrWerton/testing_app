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
    apiKey: 'AIzaSyCPbwlicwqaXJVXpYxCYaLFYbdlOs3S96U',
    appId: '1:378090759929:web:ec0d773fb92a91d91ce428',
    messagingSenderId: '378090759929',
    projectId: 'appppp-f36df',
    authDomain: 'appppp-f36df.firebaseapp.com',
    storageBucket: 'appppp-f36df.appspot.com',
    measurementId: 'G-7MEKRVHHWL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5Vs9tV82lSU6AvNrV2wWpBezZy9zmI_U',
    appId: '1:378090759929:android:24ebef777cf022cb1ce428',
    messagingSenderId: '378090759929',
    projectId: 'appppp-f36df',
    storageBucket: 'appppp-f36df.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVvvO4Ul3FFy1r3UcO41RKvPtgKh8MJC0',
    appId: '1:378090759929:ios:f8aff07d251b28d31ce428',
    messagingSenderId: '378090759929',
    projectId: 'appppp-f36df',
    storageBucket: 'appppp-f36df.appspot.com',
    iosClientId: '378090759929-9vhj9gumu2fcrto96rqnaculh2c7fq9n.apps.googleusercontent.com',
    iosBundleId: 'com.notrew.testingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCVvvO4Ul3FFy1r3UcO41RKvPtgKh8MJC0',
    appId: '1:378090759929:ios:3ef67fce535fdc3b1ce428',
    messagingSenderId: '378090759929',
    projectId: 'appppp-f36df',
    storageBucket: 'appppp-f36df.appspot.com',
    iosClientId: '378090759929-sgtbievlbblflhmhfrk3g5ji3faivkj9.apps.googleusercontent.com',
    iosBundleId: 'com.notrew.testingApp.RunnerTests',
  );
}