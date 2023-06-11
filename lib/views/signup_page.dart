import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sutt_task_aryan/router/route_utils.dart';

import 'package:sutt_task_aryan/reusable_widgets/reusable_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignUpPage extends StatelessWidget {
  static const snackBar = SnackBar(
    content: Text('New User Successfully Registered'),
  );
  final _myBox = Hive.box('mybox');
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
        Colors.grey.shade300,
        Colors.grey.shade100,
        Colors.blue
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter
    )
    ),
        child: SafeArea(
          child: Center(
              child: Column(children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.app_registration,
              size: 100,
            ),
            const SizedBox(height: 50),
            Text(
              'New User? Register Now',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: reusableTextField("Enter UserName", Icons.person_outline,
                  false, _userNameTextController),
            ),
            const SizedBox(height: 10),
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
              height: 50,
            ),
            firebaseUIButton(context, "Sign Up", () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                  .then((value) async {
                await _myBox.put(_emailTextController.text.toString(),
                    _userNameTextController.text.toString());
                await ScaffoldMessenger.of(context).showSnackBar(snackBar);

                GoRouter.of(context).push(APP_PAGE.home.toPath);
              }).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });
            }),
                const SizedBox(height:35),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or Go Back',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

            const SizedBox(height: 30),
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
                        color: Colors.lightBlueAccent.withOpacity(0.4),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
                ),
              ],
            ),
          ])),
        ))







        );
  }
}
