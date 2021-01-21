import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/Screens/Chat/models/chat_message.dart';
import 'package:testing_app/Screens/Chat/components/chat_detail_page.dart';
import 'package:testing_app/constants.dart';

class ChatDetailPageBubble extends StatefulWidget {
  ChatMessage chatMessage;
  ChatDetailPageBubble({@required this.chatMessage});
  @override
  _ChatDetailPageBubbleState createState() => _ChatDetailPageBubbleState();
}

class _ChatDetailPageBubbleState extends State<ChatDetailPageBubble> {
  @override
  Widget build(BuildContext context) {
    if (widget.chatMessage.type == MessageType.Sender) {
      return Padding(
        padding: getChaterType(widget.chatMessage.massageType),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: getMessageType(widget.chatMessage.massageType),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    widget.chatMessage.message,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: getChaterType(widget.chatMessage.massageType),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: getMessageType(widget.chatMessage.massageType),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    widget.chatMessage.message,
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  getMessageType(messageType) {
    if (widget.chatMessage.type == MessageType.Sender) {
      // start message
      if (messageType == 1) {
        return BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(5),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        );
      }
      // middle message
      else if (messageType == 2) {
        return BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        );
      }
      // end message
      else if (messageType == 3) {
        return BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        );
      }
      // standalone message
      else {
        return BorderRadius.all(
          Radius.circular(30),
        );
      }
    }
    // for sender bubble
    else {
      // start message
      if (messageType == 1) {
        return BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(5),
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        );
      }
      // middle message
      else if (messageType == 2) {
        return BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        );
      }
      // end message
      else if (messageType == 3) {
        return BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30));
      }
      // standalone message
      else {
        return BorderRadius.all(
          Radius.circular(30),
        );
      }
    }
  }

  getChaterType(messageType) {
    if (widget.chatMessage.type == MessageType.Sender) {
      // start message
      if (messageType == 1) {
        return EdgeInsets.only(right: 1, left: 1, top: 10, bottom: 1);
      } else if (messageType == 2) {
        return EdgeInsets.only(right: 1, left: 1, top: 1, bottom: 1);
      } else if (messageType == 3) {
        return EdgeInsets.only(right: 1, left: 1, top: 1, bottom: 10);
      }
    }
    // for sender bubble
    else {
      if (messageType == 1) {
        return EdgeInsets.only(right: 1, left: 1, top: 10, bottom: 1);
      } else if (messageType == 2) {
        return EdgeInsets.only(right: 1, left: 1, top: 1, bottom: 1);
      } else if (messageType == 3) {
        return EdgeInsets.only(right: 1, left: 1, top: 1, bottom: 10);
      }
    }
  }
}
