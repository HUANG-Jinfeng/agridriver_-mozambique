import 'package:flutter/cupertino.dart';
import 'package:testing_app/Screens/Chat/components/chat_detail_page.dart';

class ChatMessage {
  int massageType;
  String message;
  MessageType type;
  ChatMessage({@required this.massageType, this.message, @required this.type});
}
