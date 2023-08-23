import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocitodriver/Login/LogIn.dart';

import '../Model/user_model.dart';
class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late String name = '';
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        name = loggedInUser.name!;
      });
      //_location();
    });
  }
  bool _myBoolean = false;
  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      borderRadius: BorderRadius.circular(10),
      color: (_myBoolean)?Color.fromRGBO(255, 51, 51, 0.9):Colors.grey,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if(_myBoolean){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));}
        },
        child: Text(
          "close",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'Arimo',
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom:20,left: 15,right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Velo Drive',style: TextStyle(fontSize: 40,fontFamily: 'nova',fontWeight: FontWeight.w900,color: Colors.red),textAlign: TextAlign.center,),
            SizedBox(
              height: 15,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Hi ',
                  style: TextStyle(fontFamily: 'Arimo')),
              TextSpan(
                  text: name,
                  style: TextStyle(
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 51, 51, 1.0))),
            ])),
            Text('Thanks for submitting the documents',style: TextStyle(fontSize: 24,fontFamily: 'arimo',fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
                child: Image.asset("assets/successdoc.png",
                  height: 90,
                  width: 80,
                )),
            SizedBox(
              height: 22,
            ),
            SizedBox(
              height: 15,
            ),
            loginButton,

          ],
        ),

      ),
    );
  }
}

