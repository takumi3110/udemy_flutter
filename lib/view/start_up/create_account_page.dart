import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('新規登録', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 30,),
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.add),
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
                  onPressed: () {
                if (nameController.text.isNotEmpty
                    && userIdController.text.isNotEmpty
                && selfIntroductionController.text.isNotEmpty
                && emailController.text.isNotEmpty
                && passController.text.isNotEmpty
                ) {
                  Navigator.pop(context);
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
