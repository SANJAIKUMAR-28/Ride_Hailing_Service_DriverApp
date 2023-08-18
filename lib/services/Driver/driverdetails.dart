import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocitodriver/Home/homepage.dart';
import 'package:intl/intl.dart';

import 'VechicleDetails.dart';


class DriverDetails extends StatefulWidget {
  const DriverDetails({super.key});

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  final userDateController = TextEditingController();
  final userExpDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final scanLicense = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,

      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        splashColor: Colors.black.withOpacity(0.2),
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> VehicleDetails()));
        } ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.document_scanner,color: Colors.redAccent[100],size: 40,),
            SizedBox(
              width: 10,
            ),
            Text("Scan license to autofill",textAlign: TextAlign.center,
          style:TextStyle(fontFamily:'Arimo',color: Colors. black,fontWeight: FontWeight.w700) ,
        ),]),
      ),

    );
    final loginButton = Material(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(255, 51, 51, 0.9),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> VehicleDetails()));
        },
        child: Text(
          "Next",
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Driver details',
          style: TextStyle(fontFamily: 'Arimo', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom:20,left: 15,right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            Text('Enter your info exactly as it appears on your license so Kanan can verify your eligibility to route.',style: TextStyle(fontSize: 18,fontFamily: 'Arimo',fontWeight: FontWeight.w400,color: Colors.black),textAlign: TextAlign.start,),
            SizedBox(
              height: 25,
            ),
            scanLicense,
            SizedBox(
              height: 30,
            ),
            Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Column(
                    children: [
                      Material(
                        color: Colors.white,
                        child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'First Name',
                                style: TextStyle(fontFamily: 'Arimo'),
                              ),
                              Container(
                                width: 150,
                                child: TextFormField(
                                  autofocus: false,
                                  style: TextStyle(fontFamily: 'Arimo'),
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.right,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    // You can save the entered value here
                                  },
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter], // Limit to a single line
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(fontFamily: 'Arimo'),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  ),
                                ),
                              ),
                            ],
                          )

                        ),
                      ), // Full Name
                      Divider(),
                      Material(
                        color: Colors.white,
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Last Name',
                                  style: TextStyle(fontFamily: 'Arimo'),
                                ),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    autofocus: false,
                                    style: TextStyle(fontFamily: 'Arimo'),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.right,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      // You can save the entered value here
                                    },
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [FilteringTextInputFormatter.singleLineFormatter], // Limit to a single line
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontFamily: 'Arimo'),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ),
                                ),
                              ],
                            )

                        ),
                      ), // Last Name
                      Divider(),
                      Material(
                        color: Colors.white,
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Country',
                                  style: TextStyle(fontFamily: 'Arimo'),
                                ),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    autofocus: false,
                                    style: TextStyle(fontFamily: 'Arimo'),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.right,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      // You can save the entered value here
                                    },
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [FilteringTextInputFormatter.singleLineFormatter], // Limit to a single line
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontFamily: 'Arimo'),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ),
                                ),
                              ],
                            )

                        ),
                      ), //country
                      Divider(),
                      Material(
                        color: Colors.white,
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'License Number',
                                  style: TextStyle(fontFamily: 'Arimo'),
                                ),
                                Container(
                                  width:150,
                                  child: TextFormField(
                                    autofocus: false,
                                    style: TextStyle(fontFamily: 'Arimo'),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.right,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      // You can save the entered value here
                                    },
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [FilteringTextInputFormatter.singleLineFormatter], // Limit to a single line
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontFamily: 'Arimo'),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ),
                                ),
                              ],
                            )

                        ),
                      ),  //License Number
                      Divider(),
                      Material(
                        color: Colors.white,
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Expiration Date',
                                  style: TextStyle(fontFamily: 'Arimo'),
                                ),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    autofocus: false,
                                    style: TextStyle(fontFamily: 'Arimo'),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.right,
                                    onTap: () async {
                                      DateTime? pickDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now().subtract(Duration(days: 0)),
                                        lastDate: DateTime(2050),
                                      );
                                      if (pickDate != null) {
                                        setState(() {
                                          userExpDateController.text =
                                              DateFormat('dd-MM-yyyy').format(pickDate);
                                        });
                                      }
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      // You can save the entered value here
                                    },
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [FilteringTextInputFormatter.singleLineFormatter], // Limit to a single line
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontFamily: 'Arimo'),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ),
                                ),
                              ],
                            )

                        ),
                      ),  // Expiration Date
                      Divider(),
                      Material(
                        color: Colors.white,
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Date Of Birth',
                                  style: TextStyle(fontFamily: 'Arimo'),
                                ),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    autofocus: false,
                                    style: TextStyle(fontFamily: 'Arimo'),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.right,
                                    onTap: () async {
                                      DateTime? pickDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now().subtract(Duration(days: 0)),
                                        lastDate: DateTime(2050),
                                      );
                                      if (pickDate != null) {
                                        setState(() {
                                          userDateController.text =
                                              DateFormat('dd-MM-yyyy').format(pickDate);
                                        });
                                      }
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                    },
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [FilteringTextInputFormatter.singleLineFormatter], // Limit to a single line
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontFamily: 'Arimo'),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ),
                                ),
                              ],
                            )

                        ),
                      ),  // Date Of Birth
                      Divider(),
                    ],
                  ),
                )),
            SizedBox(
              height: 25,
            ),
            loginButton,

          ],
        ),

      ),

    );
  }
}
