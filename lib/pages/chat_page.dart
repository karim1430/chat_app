import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleven_project/models/message.dart';
import 'package:eleven_project/widgets/chat_buble.dart';
import 'package:eleven_project/widgets/constants.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static String id = 'ChatPage';

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference message =
      FirebaseFirestore.instance.collection(kColectionMessage);
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapchot) {
        if (snapchot.hasData) {
          List<Message> messagesList = [];

          for (var i = 0; i < snapchot.data!.docs.length; i++) {
            messagesList.add(
              Message.formJson(snapchot.data!.docs[i]),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logo,
                    height: 50,
                  ),
                  const Text(
                    'chat',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBuble(
                              message: messagesList[index],
                            )
                          : ChatBubleForFriend(
                              message: messagesList[index],
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      message.add({
                        'message': data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();

                      _controller.animateTo(0,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                    },
                    decoration: InputDecoration(
                      hintText: 'Inter Message',
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.send)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('loading...')),
          );
        }
      },
    );
  }
}
