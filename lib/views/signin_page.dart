import 'package:firebase_auth/firebase_auth.dart';
import 'package:sutt_task_aryan/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sutt_task_aryan/router/route_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignInPage extends StatelessWidget {
  static const snackBar = SnackBar(
    content: Text('User Signed In Successfully'),
  );
  static String? sendusername='User';
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

        body:Container(
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
            const SizedBox(height: 30),
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
            firebaseUIButton(context, "Log In", () {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                  .then((value) async {
                await email(_emailTextController.text.toString());
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                GoRouter.of(context).push(APP_PAGE.login.toPath);
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
                    )
                  ),
                ),
              ],
            ),
          ])),
        ))


        );
  }
}
