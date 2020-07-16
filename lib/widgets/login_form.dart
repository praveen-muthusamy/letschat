import 'dart:io';

import 'package:flutter/material.dart';
import 'package:letschat/widgets/image_picker.dart';
import 'package:validators/validators.dart';

class LoginForm extends StatefulWidget {
  LoginForm(this._submitAuthForm, this._isLoading);

  final bool _isLoading;

  final void Function(
    String email,
    String username,
    String password,
    bool isLogin,
    File image,
    BuildContext context,
  ) _submitAuthForm;
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _username = '';
  var _password = '';
  var _isLogin = true;
  File _userImage;

  void _imagePicker(File image) {
    _userImage = image;
  }

  void _submitForm() {
    var isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImage == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image.'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget._submitAuthForm(
        _email,
        _username,
        _password,
        _isLogin,
        _userImage,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(_imagePicker),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (!isEmail(value)) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      _email = value.trim();
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (isNull(value) || value.length < 5) {
                          return 'Enter a valid username.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (value) {
                        _username = value.trim();
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (isNull(value) || value.length < 7) {
                        return 'Password must be atleast 7 characters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _password = value.trim();
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                        onPressed: _submitForm),
                  if (!widget._isLoading)
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'Already have an account'),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        }),
                ],
              ),
            ),
            padding: EdgeInsets.all(15),
          ),
        ),
      ),
    );
  }
}
