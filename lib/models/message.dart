import 'package:eleven_project/widgets/constants.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.formJson(jsonData) {
    return Message(jsonData[kMessage], jsonData['id']);
  }
}
