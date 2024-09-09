import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetUserDetails extends StatelessWidget {
  final String documentid;
  const GetUserDetails({super.key,required this.documentid});

  @override
  Widget build(BuildContext context) {
    CollectionReference users =FirebaseFirestore.instance.collection("demouser");
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentid).get(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          Map<String,dynamic> data = snapshot.data!.data()as Map<String,dynamic>;
          return Text("${data['First name']}" ' ' +
          "${data['last name']}" + ' ' +
          "${data['age']}"+
          "years old");
        }
        return Text("loading");
      }
    );

    
  }
}