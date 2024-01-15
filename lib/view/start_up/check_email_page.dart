import 'package:flutter/material.dart';
import 'package:udemy/utils/authentication.dart';
import 'package:udemy/utils/firestore/users.dart';
import 'package:udemy/utils/widget_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udemy/view/screen.dart';

class CheckEmailPage extends StatefulWidget {
  final String email;
  final String pass;
  const CheckEmailPage({super.key, required this.email, required this.pass});
  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('メールアドレスを確認'),
      body: Column(
        children: [
          const Text(
              '登録いただいたメールアドレス当てに確認メールを送信しております。そちらに記載されているURLをクリックし認証をお願いします。'
          ),
          ElevatedButton(onPressed: () async{
            var result = await Authentication.emailSignIn(email: widget.email, pass: widget.pass);
            if (result is UserCredential) {
              if (result.user!.emailVerified == true) {
                while(Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                await UserFirestore.getUser(result.user!.uid);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Screen()));
              } else {
                print ('メール認証が終わってません。');
              }
            }
          },
              child: const Text('認証完了'))
        ],
      ),
    );
  }
}
