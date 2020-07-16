import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble(this._message, this._isCurrentUser, this._username, this._avatar,
      {this.key});

  final String _message;
  final bool _isCurrentUser;
  final String _username;
  final String _avatar;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment:
              _isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: _isCurrentUser
                    ? Colors.grey[300]
                    : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft:
                      _isCurrentUser ? Radius.circular(12) : Radius.circular(0),
                  bottomRight:
                      _isCurrentUser ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 150,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _username,
                    style: TextStyle(
                      color: _isCurrentUser ? Colors.grey : Colors.white54,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    _message,
                    style: TextStyle(
                      color: _isCurrentUser
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            )
          ],
        ),
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(_avatar),
          ),
          top: -15,
          left: _isCurrentUser ? null : 125,
          right: _isCurrentUser ? 0 : null,
        )
      ],
      overflow: Overflow.visible,
    );
  }
}
