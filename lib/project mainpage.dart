import 'package:camerin/home.dart';
import 'package:camerin/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<User?>(stream:FirebaseAuth.instance.authStateChanges(),
       builder:(context, snapshot){
        if(snapshot.hasData){
          return HomePage();
        }else{
          return LoginPage();
        }
      },
      )
    );
  }
}