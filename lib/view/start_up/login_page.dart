import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 50,),
              const Text('ひとりごつ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'mail adress'
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passController,
                  decoration: const InputDecoration(
                    hintText: 'password'
                  ),
                ),
              ),
              SizedBox(height: 10,),
              RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(text: 'アカウントを作成していない方は'),
                      TextSpan(
                        text: 'こちら',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          print('アカウント作成');
                        }
                      )
                    ]
                  )
              ),
              const SizedBox(height: 70,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Screen()));
                  },
                  child: const Text('emailでログイン'))
            ],
          ),
        ),
      ),
    );
  }
}
