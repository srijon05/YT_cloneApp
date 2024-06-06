import 'package:flutter/material.dart';

class UserChannelPage extends StatelessWidget {
  const UserChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Image.asset("assets/images/flutter background.png"),
            ],
          ),
        ),
      ),
    );
  }
}
