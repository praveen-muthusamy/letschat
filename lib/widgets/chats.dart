import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letschat/widgets/chat_bubble.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('created', descending: true)
                  .snapshots(),
              builder: (ctx, messageStream) {
                if (messageStream.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var _messages = messageStream.data.documents;
                return ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (ctx, index) => Container(
                          padding: EdgeInsets.all(8),
                          child: ChatBubble(
                            _messages[index]['message'],
                            _messages[index]['user'] == futureSnapshot.data.uid,
                            _messages[index]['username'],
                            _messages[index]['avatar'],
                            key: ValueKey(_messages[index].documentID),
                          ),
                        ));
              });
        });
  }
}
