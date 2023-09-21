import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:velocitodriver/Screens/OnTheWay.dart';
import 'package:velocitodriver/Screens/PickUp.dart';

import '../Model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String vehicletype='';
  String vehiclemake='';
  String vehiclenum='';
  bool transit=true;
  bool completed=false;
  String name = '';
  db.Query dbRef = db.FirebaseDatabase.instance.ref().child('Requests');
  db.DatabaseReference reference = db.FirebaseDatabase.instance.ref().child('Requests');
  bool _isEnabled=false;
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
        vehicletype=value['Vehicle-type'];
        vehiclemake=value['Vehicle-make'];
        vehiclenum=value['Vehicle-number'];
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
              requestList(request['PASSENGER-NAME'], request['PASSENGER-NUMBER'], request['FROM'], request['TO'], request['VEHICLE'], request['COST'],request['DISTANCE'], request['STATUS'],request['PASSENGER-STATUS'],request['key']),
            if(request['PASSENGER-STATUS']=="CONFIRMED")
              checksts(request['PASSENGER-ID']),

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
                    greetings(),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    color: Color.fromRGBO(220, 220, 220, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('   '),
                          (_isEnabled)?
                          Text(' ON DUTY',textAlign:TextAlign.center,style: TextStyle(fontFamily: 'PoppinsBold',fontSize: 24),):Text(' OFF DUTY',textAlign:TextAlign.center,style: TextStyle(fontFamily: 'PoppinsBold',fontSize: 24),),
                          SizedBox(
                            width: 50,
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  _isEnabled=!_isEnabled;
                                });
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(15),
                                color: (_isEnabled)?Color.fromRGBO(255, 51, 51, 1.0):Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Row(
                                    mainAxisAlignment: (_isEnabled)?MainAxisAlignment.end:MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.circle,color: Colors.white,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    color: Color.fromRGBO(255, 245, 245, 1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.transparent,
                          width: (MediaQuery.of(context).size.width)/2,
                          child: Material(
                            color: Color.fromRGBO(255, 245, 245, 1.0),
                            child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    transit=!transit;
                                    completed=!completed;
                                  });
                                },
                                child: Text('In-transit',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Arimo',color: (transit)?Colors.redAccent:Colors.black),)),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          width: (MediaQuery.of(context).size.width)/2,
                          child: Material(
                            color: Color.fromRGBO(255, 245, 245, 1.0),
                            child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    completed=!completed;
                                    transit=!transit;
                                  });
                                },
                                child: Text('Completed',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Arimo',color: (completed)?Colors.redAccent:Colors.black),)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 5,
                      child: Divider(
                        endIndent: (completed)?0:MediaQuery.of(context).size.width/2,
                        indent: (transit)?0:MediaQuery.of(context).size.width/2,
                        color: Colors.redAccent,
                      ),
                    ))
              ],
            ),
            (_isEnabled)?
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (BuildContext context, db.DataSnapshot snapshot, Animation<double> animation, int index) {
                  if(snapshot.value==null){
                    return Text("No rides");
                  }
                  Map request = snapshot.value as Map;
                  request['key'] = snapshot.key;

                  return listItem(request: request);
                },
              ),
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 200,),
                Stack(
                  children: [CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.04),
                  ),
                    Positioned.fill(
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.asset('assets/loc.png',height: 40,width: 40,)))
        ]
                ),
                SizedBox(height: 10,),
                Text('Inactive'.tr,style: TextStyle(fontSize: 18,fontFamily: 'Arimo',fontWeight: FontWeight.w600),),
                SizedBox(height: 8,),
                Text('\"Currently your account is off duty, and',style: TextStyle(fontSize: 14,fontFamily: 'Arimo',fontWeight: FontWeight.w300,color: Colors.grey),),
                Text('there no ongoing trips\"',style: TextStyle(fontSize: 14,fontFamily: 'Arimo',fontWeight: FontWeight.w300,color: Colors.grey),),
              ],
            ),

          ],
        ),
      ),
    );
  }
  Material requestList(String name,String num,String from,String to,String vehicle,String cost,String dist,String sts,String psgsts,String key){
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
                          reference.child(key).update({'DRIVER-ID':user?.uid});
                          reference.child(key).update({'VEHICLE-TYPE':vehicletype});
                          reference.child(key).update({'VEHICLE-MAKE':vehiclemake});
                          reference.child(key).update({'VEHICLE-NUMBER':vehiclenum});
                          showModalBottomSheet(context: context, builder: (context){

                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                color: Colors.white,
                              ),
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/waiting.json',
                                      height: 50,
                                      width: 50
                                  ),
                                  Text('Waiting for passenger confirmation',style: TextStyle(fontFamily: 'Arimo'),),
                                  Text('Please hold on for a moment',style: TextStyle(fontFamily: 'Arimo'),)
                                ],
                              ),
                            );
                          });
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
  checksts(String key){
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => OnTheWay(keyvalue: key,)));
  }
  String greetings(){
    String greeting ='';
    DateTime dateTime=DateTime.now();
    String hour= "${dateTime.hour}";
    if(int.parse(hour)>=0&&int.parse(hour)<=11){
      greeting="Good Morning";
    }else if(int.parse(hour)>=12&&int.parse(hour)<16){
      greeting="Good Afternoon";
    }
    else if(int.parse(hour)>=16&&int.parse(hour)<=19){
      greeting="Good Evening";
    }else if(int.parse(hour)>=19&&int.parse(hour)<=23){
      greeting="Good Night";
    }
    return greeting;
  }
}


