import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthManager {
  static FirebaseAuthManager? _instance;
  static FirebaseAuthManager get instance {
    _instance ??= FirebaseAuthManager._init();
    return _instance!;
  }

  late final FirebaseAuth auth;

  FirebaseAuthManager._init() {
    auth = FirebaseAuth.instance;
  }
}
