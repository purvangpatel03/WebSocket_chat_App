import 'package:hive/hive.dart';
part 'message.g.dart';

@HiveType(typeId: 1)
class ChatMessage {
  @HiveField(0)
  final String message;
  @HiveField(1)
  final String time;
  @HiveField(2)
  final bool isMe;
  @HiveField(3)
  final int sessionId;
  @HiveField(4)
  final String userEmail;

  ChatMessage({required this.message, required this.time, required this.isMe, required this.sessionId, required this.userEmail});
}