import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/account.dart';
import '../../model/post.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  Account myAccount = Account(
    id: '1',
    name: 'ちいかわ',
    selfIntroduction: 'ヤーッ！！',
    userId: 'chiikawa',
    imagePath: 'https://www.lettuceclub.net/i/N1/1105949/11163558.jpg',
    createdTime: DateTime.now(),
    updatedTime: DateTime.now(),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
             children: [
               Container(
                 padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
                 // color: Colors.red.withOpacity(0.3),
                 height: 200,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [Row(
                         children: [
                           CircleAvatar(
                             radius: 32,
                             foregroundImage: NetworkImage(myAccount.imagePath),
                           ),
                           const SizedBox(width: 10,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(myAccount.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                               Text('@${myAccount.userId}', style: const TextStyle(color: Colors.grey))
                             ],
                           )
                         ],
                       ),
                         OutlinedButton(onPressed: () {}, child: const Text('change'))
                     ]),
                     const SizedBox(height: 15,),
                     Text(myAccount.selfIntroduction)
                   ],
                 ),
               ),
               Container(
                 alignment: Alignment.center,
                 width: double.infinity,
                 decoration: const BoxDecoration(
                   border: Border(bottom: BorderSide(
                     color: Colors.blue, width: 3
                   ))
                 ),
                 child: const Text('POST', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
               ),
               Expanded(child: ListView.builder(
                 physics: NeverScrollableScrollPhysics(),
                 itemCount: postList.length,
                   itemBuilder: (context, index){
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
                   }
               ))
             ],
            ),
          ),
        ),
      ),
    );
  }
}
