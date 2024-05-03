import 'package:community_share/modules/home/home.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final String userEmail;
  const MainScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      userEmail: userEmail,
    );
  }
}
