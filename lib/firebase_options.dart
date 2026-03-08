import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyABCDEFGHIJKLMNOPQRSTUVWXYZabcdefg',
    appId: '1:962325951618:android:abcdef1234567890',
    messagingSenderId: '962325951618',
    projectId: 'lutusvestbackend',
    storageBucket: 'lutusvestbackend.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABCDEFGHIJKLMNOPQRSTUVWXYZabcdefg',
    appId: '1:962325951618:ios:abcdef1234567890',
    messagingSenderId: '962325951618',
    projectId: 'lutusvestbackend',
    storageBucket: 'lutusvestbackend.firebasestorage.app',
    iosBundleId: 'com.example.app',
  );
}
