import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:line_icons/line_icons.dart';

class OnTheWay extends StatefulWidget {
  final String keyvalue;
  const OnTheWay({super.key, required this.keyvalue,});

  @override
  State<OnTheWay> createState() => _OnTheWayState();
}

class _OnTheWayState extends State<OnTheWay> {
  late DatabaseReference _userRef;
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Requests');
  String name='';
  String phn='';
  void initstate(){
    super.initState();
    _userRef = FirebaseDatabase.instance.ref().child('Requests');
    _userRef.child(widget.keyvalue).onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as dynamic);
        setState(() {
          name=data['PASSENGER-NAME'];
          phn=data['PASSENGER-NUMBER'];
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'On the way',
          style: TextStyle(
              fontFamily: 'Arimo',
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(62, 73, 88, 1.0)),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [Image.asset('assets/map1.png')],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 320,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PhysicalModel(
                              elevation:2,
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              child:
                              CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                Colors.white,
                                child: InkWell(
                                  onTap: () async {
                                    await FlutterPhoneDirectCaller.callNumber(phn);
                                  },
                                  child:Icon(
                                    LineIcons.phoneVolume,
                                    color:
                                    Color.fromRGBO(255, 51, 51, 0.8),
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            Text('3 min 0.5 km',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo'),),
                            PhysicalModel(
                              elevation:2,
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              child:
                              CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                Colors.white,
                                child: InkWell(
                                  onTap: (){

                                   
                                  },
                                  child:Icon(
                                    LineIcons.times,
                                    color:
                                    Color.fromRGBO(255, 51, 51, 0.8),
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                         ],
                        ),
                        Text('Picking up $name',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey))
                      ],
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 2,
                      color: Color.fromRGBO(255, 51, 51, 0.9),
                      child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          reference.child(widget.keyvalue).update({'TRIP-STATUS':'ARRIVED'});
                        },
                        child:  Text(
                          "Arrived",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Arimo',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
