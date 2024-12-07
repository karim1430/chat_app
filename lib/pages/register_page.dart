import 'package:eleven_project/helpers/show_Snack_bar.dart';
import 'package:eleven_project/pages/chat_page.dart';
import 'package:eleven_project/widgets/constants.dart';
import 'package:eleven_project/widgets/custom_button.dart';
import 'package:eleven_project/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                      'Register',
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
                        await userRegister();
                        Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'invalid-email') {
                          showSnackBar(
                              context, 'The email address is badly formatted');
                        } else if (ex.code == 'weak-password') {
                          showSnackBar(context, 'The password is too weak');
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackBar(
                              context, 'The email address is already in use');
                        } else {
                          showSnackBar(
                              context, 'Please enter both email and password.');
                        }
                      }
                      isloading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'REGISTER',
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'aready have an account ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
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

  Future<void> userRegister() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
