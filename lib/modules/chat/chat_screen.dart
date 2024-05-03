import 'package:community_share/modules/chat/widgets/chat_body_view.dart';
import 'package:community_share/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final String userEmail;
  final int sessionId;

  const ChatScreen(
      {super.key, required this.userEmail, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false).getUniqueSessionIds(userEmail);
            Navigator.pop(
              context,
            );
          },
        ),
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Chat Screen',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: ChatBody(
        sessionId: sessionId,
        userEmail: userEmail,
      ),
    );
  }
}
