import 'package:firebase_auth/firebase_auth.dart';
import 'package:sutt_task_aryan/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sutt_task_aryan/router/route_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignInPage extends StatelessWidget {
  static String? sendusername='Google User';
  bool email(email) {
    sendusername = Hive.box('mybox').get(email.toString());
    print(sendusername);
    return true;
  }

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
              child: Column(children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.supervised_user_circle,
              size: 100,
            ),
            const SizedBox(height: 50),
            Text(
              'Hey there! Please enter your valid credentials',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: reusableTextField("Enter Email", Icons.person_outline,
                  false, _emailTextController),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: reusableTextField("Enter Password", Icons.lock_outline,
                  true, _passwordTextController),
            ),
            const SizedBox(
              height: 15,
            ),
            firebaseUIButton(context, "Log In", () {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                  .then((value) async {
                await email(_emailTextController.text.toString());
                GoRouter.of(context).push(APP_PAGE.login.toPath);
              }).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });
            }),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(APP_PAGE.signup.toPath);
                  },
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // google button

                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(APP_PAGE.home.toPath);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    )
                  ),
                ),
              ],
            ),
          ])),
        )


        );
  }
}
