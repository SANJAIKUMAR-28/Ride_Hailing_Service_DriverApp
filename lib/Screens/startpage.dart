import 'package:flutter/material.dart';
import 'package:velocitodriver/Screens/splash.dart';

import '../services/Driver/driverdetails.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginButton =  Material(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(255, 51, 51, 0.9),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> DriverDetails()));
        },
        child: Text(
          "Continue",
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
      body: Padding(
        padding: const EdgeInsets.only(bottom:20,left: 13,right: 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 60,),
            Text('For Getting Approval',style: TextStyle(fontSize: 21,fontFamily: 'Arimo',fontWeight: FontWeight.w400,color: Colors.black),textAlign: TextAlign.start,),
            SizedBox(height: 10),
            Text('We kindly request you to provide us with some essential information to proceed with your admin approval.',style: TextStyle(fontSize: 15,fontFamily: 'Arimo',fontWeight: FontWeight.w300,color: Colors.black),textAlign: TextAlign.start,),
            SizedBox(
              height: 18,
            ),
            Material(
              borderRadius: BorderRadius.circular(13),
              color: Color.fromRGBO(245, 245, 245, 1),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: Colors.redAccent,
                          child: Text('1',style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                        ),
                        Container(
                          height: 55,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 3.0,
                            width: 20.0,
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: Colors.redAccent,
                          child: Text('2',style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                        ),
                        Container(
                          height: 55,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 3.0,
                            width: 20.0,
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: Colors.redAccent,
                          child: Text('3',style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                        ),
                        Container(
                          height: 55,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 3.0,
                            width: 20.0,
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverDetails()));
                          },
                          elevation: 2.0,
                          fillColor: Colors.redAccent,
                          child: Text('4',style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                    Flexible(child:
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Adjust padding as needed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Verified Phone Number',
                            style: TextStyle(fontSize: 18, fontFamily: 'Arimo', fontWeight: FontWeight.w600, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'To proceed, please provide a valid & verified phone number for communication purposes.',
                            style: TextStyle(fontSize: 13, fontFamily: 'Arimo', fontWeight: FontWeight.w100, color: Colors.black),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(fontSize: 18, fontFamily: 'Arimo', fontWeight: FontWeight.w600, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'We require a valid email address to keep you updated on important notifications.',
                            style: TextStyle(fontSize: 13, fontFamily: 'Arimo', fontWeight: FontWeight.w100, color: Colors.black),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            'Driver License',
                            style: TextStyle(fontSize: 18, fontFamily: 'Arimo', fontWeight: FontWeight.w600, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Kindly enter your license number, ensuring its accuracy for verification purpose.',
                            style: TextStyle(fontSize: 13, fontFamily: 'Arimo', fontWeight: FontWeight.w100, color: Colors.black),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            'Vehicle',
                            style: TextStyle(fontSize: 20, fontFamily: 'Arimo', fontWeight: FontWeight.w600, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Please provide details about your vehicle. kindly upload the necessary documentation.',
                            style: TextStyle(fontSize: 13, fontFamily: 'Arimo', fontWeight: FontWeight.w100, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            loginButton,

          ],
        ),

      ),
    );
  }
}
