import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../Model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late String name = '';
  db.Query dbRef = db.FirebaseDatabase.instance.ref().child('Requests');
  db.DatabaseReference reference = db.FirebaseDatabase.instance.ref().child('Requests');
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("drivers")
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
  Widget listItem({required Map request}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left:20,top:6,right: 20,bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if(request['STATUS']=="REQUESTED")
              requestList(request['PASSENGER-NAME'], request['PASSENGER-NUMBER'], request['FROM'], request['TO'], request['VEHICLE'], request['COST'],request['DISTANCE'], request['STATUS'],request['key']),
          ],
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Color.fromRGBO(255, 245, 245, 1),
                child: Icon(
                  Icons.person,
                  color: Color.fromRGBO(242, 96, 96, 1),
                  size: 35,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Arimo',
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(78, 16, 16, 1)),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ]),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: FirebaseAnimatedList(
        query: dbRef,
        itemBuilder: (BuildContext context, db.DataSnapshot snapshot, Animation<double> animation, int index) {

          Map request = snapshot.value as Map;
          request['key'] = snapshot.key;

          return listItem(request: request);
        },
      ),
    );
  }
  Material requestList(String name,String num,String from,String to,String vehicle,String cost,String dist,String sts,String key){
    return Material(
        color: Color.fromRGBO(255, 245, 245, 1.0),
        borderRadius: BorderRadius.circular(15),
        elevation: 2,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset("assets/userimg.png",
                          height: 55,
                            width: 55,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(name.toUpperCase(),style: TextStyle(fontFamily: 'Arimo',fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromRGBO(62, 73,88, 1.0)),)
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              Icon(LineIcons.indianRupeeSign,size: 13,color: Colors.black,),
                              SizedBox(width: 2,),
                              Text(cost,style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Arimo',
                                  color:
                                  Colors.black,
                                  fontWeight: FontWeight.bold),),
                            ]
                        ),
                        Text(dist,style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Arimo',
                          color:
                          Color.fromRGBO(0, 0, 0, 0.60),
                        ),),
                      ],
                    )
                  ],
                ),
              ),
              Divider(color: Colors.grey,),
              Padding(
                padding:const EdgeInsets.only(left: 15,top: 8,right: 15,bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PICK-UP',style: TextStyle(fontFamily: 'Arimo',fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromRGBO(62, 73,88, 1.0)),),
                    Text(from,style: TextStyle(fontFamily: 'Arimo',fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),)
                  ],
                ),
              ),
              Divider(color: Colors.grey,),
              Padding(
                padding:const EdgeInsets.only(left: 15,top: 8,right: 15,bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DROP-OFF',style: TextStyle(fontFamily: 'Arimo',fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromRGBO(62, 73,88, 1.0)),),
                    Text(to,style: TextStyle(fontFamily: 'Arimo',fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),)
                  ],
                ),
              ),
              Divider(color: Colors.grey,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                  child:Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 51, 51, 1.0),
                      child: MaterialButton(
                        onPressed: (){
                          reference.child(key).update({'STATUS':'ACCEPTED'});
                          reference.child(key).update({'DRIVER-NAME':'${loggedInUser.name}'});
                          reference.child(key).update({'DRIVER-NUMBER':'${loggedInUser.phoneno}'});
                          reference.child(key).update({'PASSENGER-STATUS':'WAITING'});
                        },
                        child: Text('ACCEPT',style: TextStyle(fontFamily: 'Arimo',fontSize: 16,color: Colors.white),),
                      ),
                    ),
                  ),
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
}


