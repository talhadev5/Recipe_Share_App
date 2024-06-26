// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCb-gqefDsHO4lsBlPAwfkc3KiZdPm4UPo',
    appId: '1:431877273827:web:8dea9d85ba34c1d9e56dd6',
    messagingSenderId: '431877273827',
    projectId: 'recipeapp-e65d7',
    authDomain: 'recipeapp-e65d7.firebaseapp.com',
    storageBucket: 'recipeapp-e65d7.appspot.com',
    measurementId: 'G-CC4VJTKDQ1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIHMBNGQGBPBcnGFiXtyp6RVuTzP_SupI',
    appId: '1:431877273827:android:09d5685eee08a04ee56dd6',
    messagingSenderId: '431877273827',
    projectId: 'recipeapp-e65d7',
    storageBucket: 'recipeapp-e65d7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcFnaZnAhIwU0u2iU4iX5g3YSVGkO4U_U',
    appId: '1:431877273827:ios:92fb2d51e033f18de56dd6',
    messagingSenderId: '431877273827',
    projectId: 'recipeapp-e65d7',
    storageBucket: 'recipeapp-e65d7.appspot.com',
    iosBundleId: 'com.example.recipeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcFnaZnAhIwU0u2iU4iX5g3YSVGkO4U_U',
    appId: '1:431877273827:ios:92fb2d51e033f18de56dd6',
    messagingSenderId: '431877273827',
    projectId: 'recipeapp-e65d7',
    storageBucket: 'recipeapp-e65d7.appspot.com',
    iosBundleId: 'com.example.recipeApp',
  );
}
