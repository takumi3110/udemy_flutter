import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udemy/model/post.dart';

class PostFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference posts = _firestoreInstance.collection('posts');

  static Future<dynamic> addPost(Post newPost) async {
    try {
      final CollectionReference _userPosts = _firestoreInstance.collection('users')
          .doc(newPost.postAccountId).collection('my_posts');
      var result = await posts.add({
        'content': newPost.content,
        'post_account_id': newPost.postAccountId,
        'created_time': Timestamp.now()
      });
      _userPosts.doc(result.id).set({
        'post_id': result.id,
        'created_time': Timestamp.now()
      });
      print('投稿完了');
      return true;
    } on FirebaseException catch (e) {
      print('投稿エラー: $e');
      return false;
    }
  }

  static Future<List<Post>?> getPostFromIds(List<String> ids) async {
    List<Post> postList = [];
    try{
      await Future.forEach(ids, (String id) async{
        var doc = await posts.doc(id).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Post post = Post(
          id: doc.id,
          content: data['content'],
          postAccountId: data['post_account_id'],
          createdTime: data['created_time']
        );
        postList.add(post);
      });
      print('my投稿取得完了');
      return postList;
    } on FirebaseException catch(e) {
      print('my投稿取得エラー$e');
      return null;
    }
  }

  static Future<dynamic> deletePosts(String accountId) async {
    final CollectionReference _userPosts  = _firestoreInstance.collection('users').doc(accountId).collection('my_posts');
    var snapshot = await _userPosts.get();
    snapshot.docs.forEach((doc) async {
      await posts.doc(doc.id).delete();
      _userPosts.doc(doc.id).delete();
    });
  }
}
