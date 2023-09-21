import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/user_model.dart';

class RouteLink extends StatefulWidget {
  const RouteLink({super.key});

  @override
  State<RouteLink> createState() => _RouteLinkState();
}

class _RouteLinkState extends State<RouteLink> {
  bool intercity=true;
  bool dailies=false;
  User? user = FirebaseAuth.instance.currentUser;
  String name = '';
  UserModel loggedInUser = UserModel();
  final db.Query dbRef = db.FirebaseDatabase.instance.ref().child('IntercityRequests');
  db.DatabaseReference reference =
  db.FirebaseDatabase.instance.ref().child('IntercityRequests');
  final db.Query DailiesRef = db.FirebaseDatabase.instance.ref().child('DailiesRequests');
  db.DatabaseReference reference1 =
  db.FirebaseDatabase.instance.ref().child('DailiesRequests');
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
    });
  }

  Widget listItem({required Map request}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 6, right: 20, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              historyBox(
                request['FROM'],
                request['TO'],
                request['DEPARTURE-TIME'],
                request['DEPARTURE-TIME'],
                request['DEPARTURE-DATE'],
                request['RETURN-TIME'],
                request['RETURN-DATE'],
                request['TRIP-TYPE'],
                request['STATUS'],
                request['key'],
              )
          ],
        ),
      ),
    );
  }
  Widget listItem2({required Map request1}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 6, right: 20, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              historyBoxDailies(
                request1['FROM'],
                request1['TO'],
                request1['PICKUP-TIME'],
                request1['REPICKUP-TIME'],
                request1['FROM-DATE'],
                request1['TO-DATE'],
                request1['STATUS'],
                request1['key'],
              )
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
                                onPressed: () {
                                  setState(() {
                                    intercity=!intercity;
                                    dailies=!dailies;
                                  });
                                },
                                child: Text('InterCity',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Arimo',color: (intercity)?Colors.redAccent:Colors.black),)),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          width: (MediaQuery.of(context).size.width)/2,
                          child: Material(
                            color: Color.fromRGBO(255, 245, 245, 1.0),
                            child: MaterialButton(
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    dailies=!dailies;
                                    intercity=!intercity;
                                  });
                                },
                                child: Text('Dailies',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Arimo',color: (dailies)?Colors.redAccent:Colors.black),)),
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
                        endIndent: (dailies)?0:MediaQuery.of(context).size.width/2,
                        indent: (intercity)?0:MediaQuery.of(context).size.width/2,
                        color: Colors.redAccent,
                      ),
                    ))
              ],
            ),
            (intercity)?
            Container(
              height: MediaQuery.of(context).size.height,
              child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (BuildContext context, db.DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map request = snapshot.value as Map;
                  request['key'] = snapshot.key;
                  return listItem(request: request);
                },
              ),
            ):
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child:  FirebaseAnimatedList(
                query: DailiesRef,
                itemBuilder: (BuildContext context, db.DataSnapshot snapshot1,
                    Animation<double> animation, int index1) {
                  Map request1 = snapshot1.value as Map;
                  request1['key'] = snapshot1.key;
                  return listItem2(request1: request1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding historyBox(String from, String to, String fromtime, String totime,
      String date,String returntime,String returndate,String type, String sts,String key) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 2.0,
        child: Stack(
          children: [
            SizedBox(
              height: (type=='One-way')?(sts!='COMPLETED')?240:200:(sts!='COMPLETED')?280:240,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type,
                            style: TextStyle(
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(62, 73, 88, 1.0)),
                          ),
                          ('${sts}' == 'REQUESTED')
                              ? Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.w700))
                              : ('${sts}' == 'CANCELLED')
                              ? Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w700))
                              : ('${sts}' == 'CONFIRMED')?Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700)):Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700)),
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.black12,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Departure Date & Time',
                                style: TextStyle(
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                              Text(
                                ': ',
                                style: TextStyle(
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '$date - $fromtime',
                          style: TextStyle(
                              fontFamily: 'Arimo',
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    if(type!='One-way')
                      Column(
                        children: [
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: 160,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Return Date & Time',
                                      style: TextStyle(
                                          fontFamily: 'Arimo',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      ': ',
                                      style: TextStyle(
                                          fontFamily: 'Arimo',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '$returndate - $returntime',
                                style: TextStyle(
                                    fontFamily: 'Arimo',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),

                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                    fontFamily: 'Arimo',
                                  ),
                                ),
                                Text('To',
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color.fromRGBO(255, 51, 51, 0.8),
                                  size: 10,
                                ),
                                Container(
                                  height: 60,
                                  child: VerticalDivider(
                                    color: Colors.black54,
                                    thickness: 2,
                                    indent: 2,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: Container(
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      from,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontFamily: 'Arimo', color: Colors.grey),
                                    ),
                                    Text(
                                      to,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontFamily: 'Arimo', color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(sts!="COMPLETED")
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child:
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 245, 245, 1),
                      borderRadius:BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:  Radius.circular(10)) ,
                      // border: Border(
                      //   bottom: BorderSide(
                      //     color: Colors.redAccent
                      //   )
                      // ),
                    ),

                    child: MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                surfaceTintColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                title: Text("Cancel trip",
                                    style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Color.fromRGBO(
                                            255, 51, 51, 0.8),
                                        fontWeight: FontWeight.bold,fontSize: 18)),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text(
                                          "Are you sure want to cancel trip?",
                                          style: TextStyle(
                                              fontFamily: 'Arimo')),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No',
                                          style: TextStyle(
                                              fontFamily: 'Arimo',
                                              color: Color.fromRGBO(
                                                  255, 51, 51, 0.8),
                                              fontWeight:
                                              FontWeight.bold))),
                                  TextButton(
                                      onPressed: () async {
                                        reference.child(key).remove();
                                        Navigator.of(context).pop();
                                        Fluttertoast.showToast(
                                            msg: "Trip Cancelled");
                                      },
                                      child: const Text('Yes',
                                          style: TextStyle(
                                              fontFamily: 'Arimo',
                                              color: Color.fromRGBO(
                                                  255, 51, 51, 0.8),
                                              fontWeight:
                                              FontWeight.bold)))
                                ],
                              );
                            });

                      },
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('CANCEL TRIP',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Colors.redAccent),),
                          ],
                        ),
                      ),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
  Padding historyBoxDailies(String from, String to, String pickuptime, String repickuptime,
      String fromdate,String todate, String sts,String key) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 2.0,
        child: Stack(
          children: [
            SizedBox(
              height: (sts!='COMPLETED')?280:200,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ('${sts}' == 'REQUESTED')
                              ? Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.w700))
                              : ('${sts}' == 'CANCELLED')
                              ? Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w700))
                              : ('${sts}' == 'CONFIRMED')?Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700)):Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700)),
                          Row(
                            children: [
                              InkWell(
                                splashColor:Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap:(){

                                },
                                child: Text(
                                  "ACKNOWLEDGE",
                                  style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.redAccent),
                                ),
                              ),
                              SizedBox(width: 5,),
                              InkWell(
                                  onTap: (){

                                  },
                                  child: Icon(Icons.info_outline,color: Colors.grey,size: 18,))
                            ],
                          ),
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.black12,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'From & To date',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '$fromdate - $todate',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'Arimo',
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Container(
                              width: 165,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pickup & Re-pickup Time',
                                    style: TextStyle(
                                        fontFamily: 'Arimo',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    ': ',
                                    style: TextStyle(
                                        fontFamily: 'Arimo',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '$pickuptime - $repickuptime',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                    fontFamily: 'Arimo',
                                  ),
                                ),
                                Text('To',
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color.fromRGBO(255, 51, 51, 0.8),
                                  size: 10,
                                ),
                                Container(
                                  height: 60,
                                  child: VerticalDivider(
                                    color: Colors.black54,
                                    thickness: 2,
                                    indent: 2,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: Container(
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      from,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontFamily: 'Arimo', color: Colors.grey),
                                    ),
                                    Text(
                                      to,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontFamily: 'Arimo', color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(sts!="COMPLETED")
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child:
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 245, 245, 1),
                      borderRadius:BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:  Radius.circular(10)) ,
                      // border: Border(
                      //   bottom: BorderSide(
                      //     color: Colors.redAccent
                      //   )
                      // ),
                    ),

                    child: MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                surfaceTintColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                title: Text("Cancel service",
                                    style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Color.fromRGBO(
                                            255, 51, 51, 0.8),
                                        fontWeight: FontWeight.bold,fontSize: 18)),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text(
                                          "Are you sure want to cancel service?",
                                          style: TextStyle(
                                              fontFamily: 'Arimo')),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No',
                                          style: TextStyle(
                                              fontFamily: 'Arimo',
                                              color: Color.fromRGBO(
                                                  255, 51, 51, 0.8),
                                              fontWeight:
                                              FontWeight.bold))),
                                  TextButton(
                                      onPressed: () async {
                                        reference1.child(key).remove();
                                        Navigator.of(context).pop();
                                        Fluttertoast.showToast(
                                            msg: "Trip Cancelled");
                                      },
                                      child: const Text('Yes',
                                          style: TextStyle(
                                              fontFamily: 'Arimo',
                                              color: Color.fromRGBO(
                                                  255, 51, 51, 0.8),
                                              fontWeight:
                                              FontWeight.bold)))
                                ],
                              );
                            });

                      },
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('CANCEL SERVICE',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Colors.redAccent),),
                          ],
                        ),
                      ),
                    ),
                  ))
          ],
        ),
      ),
    );
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
