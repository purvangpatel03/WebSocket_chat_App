import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/message.dart';

class HomeProvider extends ChangeNotifier {

  List<int> sessionId = [];

  Future<void> getUniqueSessionIds(String userId) async {
    final box = await Hive.openBox<ChatMessage>('chatdata');
    var allSessionIds = <int>[];
    for (var i = 0; i < box.length; i++) {
      final chatMessage = box.getAt(i)!;
      if(chatMessage.userEmail == userId){
        if(!allSessionIds.contains(chatMessage.sessionId)){
          allSessionIds.add(chatMessage.sessionId);
        }
      }
    }
    await box.close();
    sessionId = allSessionIds;
    notifyListeners();
  }

}