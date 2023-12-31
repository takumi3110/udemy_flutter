import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udemy/model/account.dart';
import 'package:udemy/utils/authentication.dart';

class UserFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users =
      _firestoreInstance.collection('users');

  static Future<dynamic> setUser(Account newAccount) async {
    try {
      await users.doc(newAccount.id).set({
        'name': newAccount.name,
        'user_id': newAccount.userId,
        'self_introduction': newAccount.selfIntroduction,
        'image_path': newAccount.imagePath,
        'created_time': Timestamp.now(),
        'updated_time': Timestamp.now(),
      });
      print('user create complete');
      return true;
    } on FirebaseException catch (e) {
      print('user create error $e');
      return false;
    }
  }

  static Future<dynamic> getUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
          id: uid,
          name: data['name'],
          userId: data['user_id'],
          selfIntroduction: data['self_introduction'],
          imagePath: data['image_path'],
          createdTime: data['created_time'],
          updatedTime: data['updated_time']);
      Authentication.myAccount = myAccount;
      print('user get complete');
      return true;
    } on FirebaseException catch (e) {
      print('get user error $e');
      return false;
    }
  }

  static Future<dynamic> updateUser(Account updateAccount) async {
    try {
      users.doc(updateAccount.id).update({
        'name': updateAccount.name,
        'image_path': updateAccount.imagePath,
        'user_id': updateAccount.userId,
        'self_introduction': updateAccount.selfIntroduction,
        'updated_time': Timestamp.now(),
      });
      print('update complete');
      return true;
    } on FirebaseException catch (e) {
      print('update error $e');
      return false;
    }
  }
}
