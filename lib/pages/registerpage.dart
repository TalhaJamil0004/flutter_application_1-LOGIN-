import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/mybutton.dart';
import 'package:flutter_application_1/components/mysquaretile.dart';
import 'package:flutter_application_1/components/mytextfield.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if (passwordController.text == confirmPasswordController.text){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
           password: passwordController.text);
           }else {
            showErrorMessage("password doesn't match!");
           }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
      
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
          return AlertDialog(title: Center(child: Text(message)));
        });
  }

 

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
                const Icon(Icons.person_add_rounded, size: 80),

                const SizedBox(
                  height: 30,
                ),
                // welcome back
                "Creating a new account"
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
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'confirm password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),

            
                const SizedBox(
                  height: 20,
                ),
                // Sign up button
                MyButton(
                  onTap: signUserUp,
                  text: "Sign up",
                ),
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
                    Text("Already have an account?",
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14)),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now",
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
