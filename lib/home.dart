

import 'package:camerin/SignIn.dart';
import 'package:camerin/getusers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user =FirebaseAuth.instance.currentUser!;
  List<String> docids =[];

  Future getDocids()async{
    await FirebaseFirestore.instance.collection("demouser").orderBy("age",descending: false).get().then((snapshot) => snapshot.docs.forEach((document) {
      docids.add(document.reference.id);
     }));
  }
  @override
  void inistate(){
    getDocids();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(
            child: Text("signed is: "+ user.email!,style:GoogleFonts.aBeeZee(),
            ),
          ),ElevatedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn(),));},
           child: Text("SingOut")
           ),
        
           Expanded(child: FutureBuilder(future: getDocids(), builder: (context,snapshot){
            return ListView.builder(shrinkWrap: true,itemCount:docids.length,itemBuilder: (context,Index){
              return Padding(padding: const EdgeInsets.all(8.0),
              child: ListTile(title: GetUserDetails(documentid:docids[Index]),
              tileColor: Colors.deepPurple[200],
              ),
              );
            },
            );
           }))
        
        
        
          ],
        
        
        ),
      ),
      
     
    );
  }
}
