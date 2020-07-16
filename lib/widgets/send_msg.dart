import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final _textController = new TextEditingController();
  var _message = '';
  void _sendMessage() async {
    // FocusScope.of(context).unfocus();
    final _currentUser = await FirebaseAuth.instance.currentUser();
    final _userData = await Firestore.instance.collection('user').document(_currentUser.uid).get();
    Firestore.instance.collection('chat').add({
      'message': _message,
      'created': Timestamp.now(),
      'user': _currentUser.uid,
      'username': _userData['username'],
      'avatar': _userData['image'],
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextFormField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Type a message'),
            onChanged: (value) {
              setState(() {
                _message = value;
              });
            },
          )),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _message.trim().isEmpty
                ? null
                : () {
                    _sendMessage();
                  },
          )
        ],
      ),
    );
  }
}
