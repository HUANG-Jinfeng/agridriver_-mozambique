import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/Screens/Chat/components/chat_page_appbar.dart';
import 'package:testing_app/constants.dart';

class ChatMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kPrimaryNoteColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            // ignore: deprecated_member_use
            title: Text("Chats"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            // ignore: deprecated_member_use
            title: Text("Groups"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            // ignore: deprecated_member_use
            title: Text("Profile"),
          ),
        ],
      ),
      body: ChatPage(),
    );
  }
}
