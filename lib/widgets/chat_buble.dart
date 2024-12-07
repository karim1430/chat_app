import 'package:eleven_project/models/message.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: Colors.lightGreen,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, right: 10),
              child: Text(
                message.message,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            color: Colors.blueAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, right: 10),
              child: Text(
                message.message,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
