import 'dart:io';

import 'package:flutter/material.dart';
import 'package:udemy/model/account.dart';
import 'package:udemy/utils/authentication.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udemy/utils/firestore/users.dart';
import 'package:udemy/utils/functionUtils.dart';
import 'package:udemy/utils/widget_utils.dart';
import '';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('新規登録'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () async {
                  var result = await FunctionUtils.getImageFromGallery();
                  if(result != null) {
                    setState(() {
                      image = File(result.path);
                    });
                  }
                },
                child: CircleAvatar(
                  foregroundImage: image == null ? null : FileImage(image!),
                  radius: 40,
                  child: const Icon(Icons.add),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'name'
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: userIdController,
                    decoration: const InputDecoration(
                        hintText: 'user ID'
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: selfIntroductionController,
                  decoration: const InputDecoration(
                      hintText: 'Introduction'
                  ),
                ),
              ),
              Container(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: 'email'
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
              const SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: () async {
                if (nameController.text.isNotEmpty
                    && userIdController.text.isNotEmpty
                && selfIntroductionController.text.isNotEmpty
                && emailController.text.isNotEmpty
                && passController.text.isNotEmpty
                && image != null
                ) {
                  var result = await Authentication.signUp(email: emailController.text, pass: passController.text);
                  print(result);
                  if (result is UserCredential) {
                    String imagePath = await FunctionUtils.uploadImage(result.user!.uid, image!);
                    Account newAccount  = Account(
                      id: result.user!.uid,
                      name: nameController.text,
                      userId: userIdController.text,
                      selfIntroduction: selfIntroductionController.text,
                      imagePath: imagePath,
                    );
                    var _result = await UserFirestore.setUser(newAccount);
                    if (_result == true) {
                      Navigator.pop(context);
                    }
                  }
                }
              },
                  child: Text('アカウント作成')
              )
            ],
          ),
        ),
      )
    );
  }
}
