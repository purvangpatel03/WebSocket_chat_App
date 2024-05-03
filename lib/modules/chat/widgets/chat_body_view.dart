import 'package:community_share/model/message.dart';
import 'package:community_share/provider/chat_provider.dart';
import 'package:community_share/widgets/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../widgets/textformfield_widget.dart';

class ChatBody extends StatefulWidget {
  final String userEmail;
  final int sessionId;

  const ChatBody({super.key, required this.userEmail, required this.sessionId});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final TextEditingController messageController = TextEditingController();
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );
  late Box<ChatMessage> box;

  @override
  void initState() {
    super.initState();
    getData();
    channel.stream.listen((event) async {
      Provider.of<ChatProvider>(context, listen: false)
          .addChat(box, event, widget.sessionId, widget.userEmail);
      messageController.clear();
    });
  }

  Future<void> getData() async{
    box = await Hive.openBox('chatdata');
    Provider.of<ChatProvider>(context, listen: false).getData(widget.sessionId, box);
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
    box.close();
    channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          reverse: true,
          child: Consumer<ChatProvider>(builder: (context, value, child) {
            if (value.chats.isEmpty) {
              return const Text('data');
            }
            return Column(
              children: [
                ...List.generate(
                  value.chats.length,
                  (index) {
                    return buildMessageList(
                      context,
                      value.chats[index],
                      width,
                    );
                  },
                ),
                const SizedBox(
                  height: 72,
                ),
              ],
            );
          }),
        ),
        Positioned(
          width: width,
          bottom: 0,
          child: PhysicalModel(
            color: Colors.white,
            elevation: 12,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      maxLine: null,
                      controller: messageController,
                      hintText: 'Start typing here...',
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (messageController.text.isNotEmpty) {
                        Provider.of<ChatProvider>(context, listen: false)
                            .sendMessage(
                          messageController.text,
                          channel,
                          box,
                          widget.sessionId,
                          widget.userEmail,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(MySnackBar()
                            .mySnackBar(
                                text:
                                    "WebSocket connection is closed. Unable to send message.",
                                context: context));
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMessageList(
      BuildContext context, ChatMessage messageData, double width) {
    if (messageData.isMe) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.fromLTRB(width / 3.6, 0, 16, 24),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(187, 159, 255, 1.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Text(
            messageData.message,
            maxLines: 50,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 0, width / 3.6, 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blueAccent.shade100,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Text(
          messageData.message,
          maxLines: 50,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
