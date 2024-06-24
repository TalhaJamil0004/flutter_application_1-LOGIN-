import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/mybutton.dart';
import 'package:flutter_application_1/components/mysquaretile.dart';
import 'package:flutter_application_1/components/mytextfield.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
      // print('FirebaseAuthException: ${e.code}');
      // if (e.code == 'user-not-found') {
      //   wrongUsername();
      // } else if (e.code == 'wrong-password') {
      //   wrongPassword();
      // } else {
      //   genericError(e.message ?? 'An unknown error occurred');
      // }
    } catch (e) {
      Navigator.pop(context);
      print('Exception: $e');
      genericError(e.toString());
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return  AlertDialog(title: Center(child: Text(message)));
        });
  }

  // void wrongPassword() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const AlertDialog(title: Text("Wrong password!"));
  //       });
  // }

  void genericError(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(message));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const SizedBox(
                  height: 50,
                ),
                const Icon(Icons.lock, size: 100),

                const SizedBox(
                  height: 50,
                ),
                // welcome back
                "Welcome to login page"
                    .text
                    .color(Colors.grey[700])
                    .size(16)
                    .bold
                    .make(),

                const SizedBox(
                  height: 25,
                ),
                // username
                MyTextField(
                  controller: emailController,
                  hintText: 'username',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                // password
                MyTextField(
                  controller: passwordController,
                  hintText: 'password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                // forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text("forgot password?",
                        style: TextStyle(color: Colors.grey[600])),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Sign in button
                MyButton(onTap: signUserIn, text: 'Sign in', ),
                const SizedBox(
                  height: 20,
                ),
                // or continue with
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.grey[400],
                        thickness: 0.5,
                      )),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "or continue with",
                            style: TextStyle(color: Colors.grey[700]),
                          )),
                      Expanded(
                          child: Divider(
                        color: Colors.grey[400],
                        thickness: 0.5,
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // login with google or apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MySquareTile(imagePath: "lib/images/google.png"),
                    const SizedBox(
                      width: 20,
                    ),
                    MySquareTile(imagePath: "lib/images/apple.png")
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // not a member register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14)),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector (
                      onTap: widget.onTap,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                            color: Colors.blue[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
