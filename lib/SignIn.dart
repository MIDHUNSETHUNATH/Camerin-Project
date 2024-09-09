import 'package:camerin/firebase_auth.dart';
import 'package:camerin/forgot_password.dart';
import 'package:camerin/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FireBaseAuthService auth = FireBaseAuthService();
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();
  Future SignIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: PasswordController.text.trim());
// pop the loading circle
        Navigator.of(context).pop();
  }
  


  @override
  void dispose() {
    emailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.blue,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Text(
                      "Sign In Your Acoount",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                    child: TextFormField(
                      controller: PasswordController,
                      decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        shadowColor: Colors.black,
                        elevation: 6),
                    onPressed: () {
                      userSignin();
                    },
                    child: Text(
                      "SINGIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Gap(25),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Forgot_Password(),
                        ),
                      );
                    },
                    child: Text(
                      "forgot password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  )
                ])));
  }

  Future<void> userSignin() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child:CircularProgressIndicator(backgroundColor: Colors.greenAccent,));
        });
    String email = emailController.text.trim();
    String password = PasswordController.text.trim();

    User? user = await auth.signInwithEmailAndPassword(email, password);
    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    } else {
      const snackBar = SnackBar(
        content: Text("incorrect password"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
