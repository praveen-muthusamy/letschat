import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letschat/widgets/send_msg.dart';
import 'package:letschat/widgets/chats.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {

  @override
  void initState() {
    final _fbm = FirebaseMessaging();
    _fbm.requestNotificationPermissions();
    _fbm.configure(
      onMessage: (msg){
        return;
      }, onResume: (msg) {
        return;
      }, onLaunch: (msg) {
        return;
      }
    );
    _fbm.subscribeToTopic('chats');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LetsChat'),
        actions: <Widget>[
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              onChanged: (itemValue) {
                if (itemValue == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ])
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Chats(),
            ),
            SendMessage(),
          ],
        ),
      ),
    );
  }
}
