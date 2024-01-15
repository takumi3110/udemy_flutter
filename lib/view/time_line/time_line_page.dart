import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udemy/utils/firestore/posts.dart';
import 'package:udemy/utils/firestore/users.dart';

import '../../model/account.dart';
import '../../model/post.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  // Account myAccount = Account(
  //   id: '1',
  //   name: 'ちいかわ',
  //   selfIntroduction: 'ヤーッ！！',
  //   userId: 'chiikawa',
  //   imagePath: 'https://www.lettuceclub.net/i/N1/1105949/11163558.jpg',
  //   createdTime: Timestamp.now(),
  //   updatedTime: Timestamp.now(),
  // );
  //
  // List<Post> postList = [
  //   Post(
  //       id: '1',
  //       content: 'わ…',
  //       postAccountId: '1',
  //       createdTime: Timestamp.now()),
  //   Post(
  //       id: '2',
  //       content: 'わ…わ…',
  //       postAccountId: '1',
  //       createdTime: Timestamp.now()),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'TimeLine',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 1,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: PostFirestore.posts.orderBy('created_time', descending: true).snapshots(),
          builder: (context, postSnapshot) {
            if (postSnapshot.hasData) {
              // どのユーザーが投稿してる内容かチェック
              List<String> postAccountIds = [];
              postSnapshot.data!.docs.forEach((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                // postAccountIdsに同じデータがない場合のみ登録
                if (!postAccountIds.contains(data['post_account_id'])) {
                  postAccountIds.add(data['post_account_id']);
                }
              });
              return FutureBuilder<Map<String, Account>?>(
                future: UserFirestore.getPostUserMap(postAccountIds),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData && userSnapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: postSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = postSnapshot.data!.docs[index].data() as Map<String, dynamic>;
                        Post post = Post(
                          id: postSnapshot.data!.docs[index].id,
                          content: data['content'],
                          postAccountId: data['post_account_id'],
                          createdTime: data['created_time']
                        );
                        Account postAccount = userSnapshot.data![post.postAccountId]!;
                        return Container(
                          decoration: BoxDecoration(
                              border:  index == 0 ? const Border(
                                  top: BorderSide(color: Colors.grey, width: 0),
                                  bottom: BorderSide(color: Colors.grey, width: 0)
                              ): const Border(
                                  bottom: BorderSide(color: Colors.grey, width: 0)
                              )
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                foregroundImage: NetworkImage(postAccount.imagePath),
                              ),
                              Expanded(
                                child: Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(postAccount.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                                              Text('@${postAccount.userId}', style: const TextStyle(color: Colors.grey), ),
                                            ],
                                          ),
                                          Text(DateFormat('M/d/yy').format(post.createdTime!.toDate()))
                                        ],
                                      ),
                                      Text(post.content)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }
              );
            } else {
              return Container();
            }
          }
        ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => const PostPage()));
      //   },
      //   child: const Icon(Icons.chat_bubble_outline),
      // ),
    );
  }
}
