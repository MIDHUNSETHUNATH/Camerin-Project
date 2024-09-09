import 'package:camerin/firebase_auth.dart';
import 'package:camerin/home.dart';
import 'package:camerin/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FireBaseAuthService auth = FireBaseAuthService();
  final TextEditingController FirstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController EmailController =TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
final TextEditingController ConfirmpasswordController = TextEditingController();
  @override
  void dispose() {
   FirstnameController .dispose();
    lastnameController.dispose();
    ageController.dispose();
    EmailController.dispose();
    PasswordController.dispose();
    ConfirmpasswordController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "LOGIN ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black),
                ),
                
                   TextFormField(
                      controller: FirstnameController,
                      decoration: InputDecoration(labelText: "Firstname",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                
                const SizedBox(height: 20),
                
                TextFormField(
                  controller: lastnameController,
                  decoration: InputDecoration(labelText: "last name",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller:ageController,
                  decoration: InputDecoration(labelText: "Age",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: EmailController,
                  decoration: InputDecoration(labelText: "Email",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: PasswordController,
                  decoration: InputDecoration(labelText: "password",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(height: 20),
                TextFormField(
                  controller: ConfirmpasswordController,
                  decoration: InputDecoration(labelText: "Confirm Password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                
                const SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      shadowColor: Colors.black,
                      elevation: 6),
                  onPressed: () {
                    singup();
                  },
                  child: Text(
                    "sing up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                        text: "Already User?  ",
                        style: TextStyle(color: Colors.white),
                        children: <TextSpan>[
                      TextSpan(
                          text: "SignIn",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ));
                              
                            }
                            ),
                    ]
                    )
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // user class create.
  // Future<void> Userlogin() async {
  //   String username = usernameController.text;
  //   String email = emailController.text;
  //   String password = PasswordController.text;

  //   User? user = await auth.signupwithEmailandPassword(email, password);
  //   if (user != null) {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (context) => const HomePage(),
  //     ));
  //   } else {
  //     const LoginPage();
  //   }
  // }


  Future singup()async{
    if(passwordConfirmed()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailController.text.trim(), 
        password: PasswordController.text.trim(),
      );
      addUserDetails(
        FirstnameController.text.trim(),
        lastnameController.text.trim(),
        EmailController.text.trim(),
        int.parse(ageController.text.trim()));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage(),
        ));
      

    }
  }
  Future addUserDetails(
    String Firstname,String lastName,String email,int age
  )async{
    await FirebaseFirestore.instance.collection("demouser").add({
      'First name':Firstname,
      'last name':lastName,
      'email':email,
      'age':age,
    });
  }
  bool passwordConfirmed(){
    if (PasswordController.text.trim() ==
    ConfirmpasswordController.text.trim()){
      return true;
    
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("password not match"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black,
      ));
      return false;
    }
  }
}
