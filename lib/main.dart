import 'package:eleven_project/firebase_options.dart';
import 'package:eleven_project/pages/chat_page.dart';
import 'package:eleven_project/pages/login_page.dart';
import 'package:eleven_project/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegisterPage.id: (context) => RegisterPage(),
        'LoginPage': (context) => LoginPage(),
        ChatPage.id: (context) => ChatPage(),
      },
      initialRoute: 'LoginPage',
    );
  }
}
