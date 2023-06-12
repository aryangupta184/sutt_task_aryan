import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sutt_task_aryan/router/route_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInPage extends StatelessWidget {
  static const snackBar = SnackBar(
    content: Text('User Signed In with Google Successfully'),
  );

  Future<int> GoogleLogin(BuildContext context, [bool mounted = true]) async {
    showDialog(

        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });



    await FirebaseServices().signInWithGoogle();
    Navigator.of(context).pop();

    if (!mounted) return 1;

    else return 2;

  }

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

                child: Column(
                    children: [

                      //logo

                      const SizedBox(height:50),

                      const Icon(
                        Icons.lock,
                        size: 100,
                      ),

                      //welcome back

                      const SizedBox(height:50),

                      Text(
                        'Welcome back, you\'ve been missed!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),

                      //sign in

                      const SizedBox(height:25),


                      GestureDetector(
                        onTap: (){
                          GoRouter.of(context).push(APP_PAGE.signin.toPath);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "Sign In with Email",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height:25),


                      GestureDetector(
                        onTap: (){
                          GoRouter.of(context).push(APP_PAGE.phone.toPath);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "Sign In with PhoneNumber/OTP",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //or continue with

                      const SizedBox(height:50),

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
                                'Or continue with',
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

                      //google

                      const SizedBox(height: 50),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // google button

                          GestureDetector(
                            onTap: () async {
                              await GoogleLogin(context);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              GoRouter.of(context).push(APP_PAGE.login.toPath);
                            },

                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.lightBlueAccent.withOpacity(0.4),
                              ),
                              child: Image.asset(
                                'lib/assets/google.png',
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //new here register

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
                            onTap: (){
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
                      )
                    ]
                )
            ),
          ),
        )

    );
  }
}

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
