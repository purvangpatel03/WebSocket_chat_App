import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../model/message.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> chats = [];

  //error in box
  Future<void> getData(int sessionId, Box<ChatMessage> box) async {
    box = Hive.box<ChatMessage>('chatdata');
    final chatMessages = <ChatMessage>[];
    for (var i = 0; i < box.length; i++) {
      final chatMessage = box.getAt(i)!;
      if (chatMessage.sessionId == sessionId) {
        chatMessages.add(chatMessage);
      }
    }
    chats = chatMessages;
    notifyListeners();
  }

  Future<void> sendMessage(String text, WebSocketChannel channel,
      Box<ChatMessage> box, int sessionId, String userEmail) async {
    if (channel.closeCode == null) {
      await box.add(ChatMessage(
        message: text,
        time: DateTime.now().toString(),
        isMe: true,
        sessionId: sessionId,
        userEmail: userEmail,
      ));
      channel.sink.add(text);
    }
    getData(sessionId, box);
  }

  Future addChat(Box<ChatMessage> box, String text, int sessionId, String userEmail) async{
    await box.add(ChatMessage(
      message: text,
      time: DateTime.now().toString(),
      isMe: false,
      sessionId: sessionId,
      userEmail: userEmail,
    ));
    getData(sessionId, box);
  }

}
