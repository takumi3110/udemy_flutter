import 'package:flutter/material.dart';
import 'package:udemy/model/post.dart';
import 'package:udemy/utils/authentication.dart';
import 'package:udemy/utils/firestore/posts.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: contentController,
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async{
                  if (contentController.text.isNotEmpty) {
                    Post newPost = Post(
                      content: contentController.text,
                      postAccountId: Authentication.myAccount!.id,
                    );
                    var result = await PostFirestore.addPost(newPost);
                    if (result == true) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('POST')
            ),
          ],
        ),
      ),
    );
  }
}
