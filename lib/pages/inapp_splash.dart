import 'package:flutter/material.dart';

class AppSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text('Loading...',
              style: TextStyle(
                color: Colors.white10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
