import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/account.dart';
import '../../model/post.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
    id: '1',
    name: 'ちいかわ',
    selfIntroduction: 'ヤーッ！！',
    userId: 'chiikawa',
    imagePath: 'https://www.lettuceclub.net/i/N1/1105949/11163558.jpg',
    createdTime: Timestamp.now(),
    updatedTime: Timestamp.now(),
  );

  List<Post> postList = [
    Post(
        id: '1',
        content: 'わ…',
        postAccountId: '1',
        createdTime: DateTime.now()),
    Post(
        id: '2',
        content: 'わ…わ…',
        postAccountId: '1',
        createdTime: DateTime.now()),
  ];

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
        body: ListView.builder(
          itemCount: postList.length,
          itemBuilder: (context, index) {
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
                    foregroundImage: NetworkImage(myAccount.imagePath),
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
                                  Text(myAccount.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                                  Text('@${myAccount.userId}', style: const TextStyle(color: Colors.grey), ),
                                ],
                              ),
                              Text(DateFormat('M/d/yy').format(postList[index].createdTime!))
                            ],
                          ),
                          Text(postList[index].content)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),

    );
  }
}
