import 'package:community_share/modules/home/widgets/home_appbar.dart';
import 'package:community_share/widgets/responsive_widget.dart';
import 'package:community_share/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';
import '../chat/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen({super.key, required this.userEmail});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int id = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false)
        .getUniqueSessionIds(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) {
          if (value.sessionId.isEmpty) {
            return const Center(
              child: Text('No chats available'),
            );
          }
          return ResponsiveWidget(builder: (type) {
            if (type == DeviceType.WEB || type == DeviceType.TABLET) {
              id = value.sessionId.length;
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 12,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: List.generate(value.sessionId.length, (index) {
                  final sessionId = value.sessionId[index];
                  return InkWell(
                    onTap: ()async{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              sessionId: sessionId,
                              userEmail: widget.userEmail,
                            ),
                          ),
                        );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                      ),
                      child: Center(
                        child: TextWidget(
                          text: 'Session $sessionId',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: type == DeviceType.WEB ? 16 : 12,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }
            return ListView.builder(
              itemCount: value.sessionId.length,
              itemBuilder: (context, index) {
                final sessionId = value.sessionId[index];
                id = value.sessionId.length;
                return InkWell(
                  onTap: ()async{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          sessionId: sessionId,
                          userEmail: widget.userEmail,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                    ),
                    child: Center(
                      child: TextWidget(
                        text: 'Session $sessionId',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          id++;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(sessionId: id, userEmail: widget.userEmail),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
