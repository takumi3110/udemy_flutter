import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  static Future<dynamic> signUp({required String email, required String pass}) async {
    try {
      UserCredential newAccount = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass
      );
      print('auth complete');
      return newAccount;
    } on FirebaseAuthException catch (e) {
      print('auth error \n $e');
      return false;
    }
  }

  static Future<dynamic> emailSignIn({required String email, required String pass}) async {
    try {
      final UserCredential _result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      currentFirebaseUser = _result.user;
      print('login');
      return true;
    } on FirebaseAuthException catch (e) {
      print('sign in error \n $e');
      return false;
    }
  }
}
