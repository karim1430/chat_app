import 'package:eleven_project/helpers/show_Snack_bar.dart';
import 'package:eleven_project/pages/chat_page.dart';
import 'package:eleven_project/pages/register_page.dart';
import 'package:eleven_project/widgets/constants.dart';
import 'package:eleven_project/widgets/custom_button.dart';
import 'package:eleven_project/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> fromKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: fromKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  logo,
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 65,
                ),
                const Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  onChange: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  onChange: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(
                  onTap: () async {
                    if (fromKey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        await loginRegister();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'invalid-email') {
                          showSnackBar(
                              context, 'The email address is badly formatted');
                        } else if (ex.code == 'user-not-found') {
                          showSnackBar(context, 'email is ont found');
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(
                              context, 'pleas , inter password correctly');
                        } else {
                          showSnackBar(
                              context, 'Please enter both email and password.');
                        }
                      }
                      isloading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an account ? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Color(0xffC2E8E5)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginRegister() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
