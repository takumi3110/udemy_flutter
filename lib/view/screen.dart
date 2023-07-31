import 'package:flutter/material.dart';
import 'package:udemy/view/account_page/account_page.dart';
import 'package:udemy/view/time_line/time_line_page.dart';

import 'time_line/post_page.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;
  List<Widget> pageList = [TimeLinePage(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity_outlined),
              label: ''
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
        },
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}
