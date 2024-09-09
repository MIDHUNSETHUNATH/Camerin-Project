import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
 final emailController=TextEditingController();


  @override
  void dispose(){
      emailController.dispose();
      super.dispose();
  }
  Future _Forgot_Password()async{
    try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
    }catch (e){
      print(e);
      showDialog(context: context, 
      builder:(context) {
        return AlertDialog(
          content: Text(e.toString()),
        );
      },
      );
    }
  }
  

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.only(top: 50,left: 15,right: 15,),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("please ente your email to reset password",style: TextStyle(),),
              Gap(50),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "email",
          
                ),
              ),
              Gap(20),
              ElevatedButton(onPressed: (){
                _Forgot_Password();
              }, child: Text("submit"),)
              ,
            ],
          ),
        ),
      ),
    );
  }
}