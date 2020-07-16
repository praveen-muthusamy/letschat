import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letschat/widgets/login_form.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _authenticateUser(
    String email,
    String username,
    String password,
    bool isLogin,
    File image,
    BuildContext context,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final imageRef = FirebaseStorage.instance
            .ref()
            .child('userimages')
            .child(authResult.user.uid + '.jpg');

        await imageRef.putFile(image).onComplete;
        final _imageUrl = await imageRef.getDownloadURL();
        Firestore.instance
            .collection('user')
            .document(authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
          'image': _imageUrl,
        });
      }
    } on PlatformException catch (error) {
      var _message = "Please try again later.";
      if (error.message != null) {
        _message = error.message;
      }
      Scaffold(
        body: SnackBar(
          content: Text(_message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: LoginForm(_authenticateUser, _isLoading));
  }
}
