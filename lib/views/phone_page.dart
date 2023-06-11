import 'package:firebase_auth/firebase_auth.dart';
import 'package:sutt_task_aryan/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sutt_task_aryan/router/route_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  State<PhonePage> createState() => _PhonePage();
}




class _PhonePage extends State<PhonePage> {
  static const snackBar = SnackBar(
    content: Text('User Signed In Successfully'),
  );

  bool otpVisibility = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String verificationID = "";



  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
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
                      Icons.phone_android,
                      size: 100,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Hey there! Enter your phone number to recieve OTP',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: reusableTextField("Enter Phone Number with +91", Icons.person_outline,
                          false, phoneController),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(child:
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                            controller: otpController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue.shade400),
                              ),
                              fillColor: Colors.white54,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.text_snippet,
                                color: Colors.blue,
                              ),
                              labelText: "Enter OTP",
                              labelStyle: TextStyle(color: Colors.black),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                            ),
                          )),
                    ),
                      visible: otpVisibility,
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(otpVisibility){
                          verifyOTP();
                        }else {
                          loginWithPhone();
                        }
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
                            "Send/Verify OTP",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

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

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
          (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
          () {
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          GoRouter.of(context).push(APP_PAGE.login.toPath);
        } else {
          print("Login Failed");
        }
      },
    );
  }

}
