import 'package:firebase_auth/firebase_auth.dart';
import 'package:udemy/model/account.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

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
      final UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      currentFirebaseUser = result.user;
      print('login \n $result');
      return result;
    } on FirebaseAuthException catch (e) {
      print('sign in error \n $e');
      return false;
    }
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
