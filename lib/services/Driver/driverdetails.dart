import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocitodriver/Home/homepage.dart';

class DriverDetails extends StatefulWidget {
  const DriverDetails({super.key});

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  @override
  Widget build(BuildContext context) {

    final taskField = Material(
      elevation: 3,
      child: TextFormField(
        autofocus: false,
        style: TextStyle(fontFamily: 'Primo'),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return 'required';
          } else {
            return null;
          }
        },

        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.title,
            color: Colors.black,
          ),
          hintText: "Enter the Task Title",
          hintStyle: TextStyle(fontFamily: 'Primo'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(),
          ),
        ),
      ),
    );
    final scanLicense = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(5),
      color: Color.fromRGBO(255, 51, 51, 0.9),

      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        splashColor: Colors.black.withOpacity(0.2),
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
        } ,
        child: Row(
          children: <Widget>[
            Icon(Icons.document_scanner,color: Colors.blueAccent,size: 40,),
            Text("Scan license to autofill",textAlign: TextAlign.center,
          style:TextStyle(fontSize: 20,fontFamily:'Arimo',color: Colors.white,fontWeight: FontWeight.w700) ,
        ),]),
      ),

    );
    final loginButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(5),
      color: Color.fromRGBO(255, 51, 51, 0.9),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        splashColor: Colors.black.withOpacity(0.2),
        onPressed:(){


          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));

        } ,
        child: Text("Continue >>",textAlign: TextAlign.center,
          style:TextStyle(fontSize: 20,fontFamily:'Arimo',color: Colors.white,fontWeight: FontWeight.w700) ,
        ),
      ),

    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:const [
            SizedBox(height: 5,),
            Row(
              children: [
                Icon(Icons.arrow_back_sharp,color: Colors.red,size: 40,),
                SizedBox(
                  width: 75,
                ),
                Text('Driver Details',style: TextStyle(fontSize: 25,fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Colors.red),textAlign: TextAlign.start,),
              ],
            ),
            SizedBox(height: 2,),
          ]
      ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.white70,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        shadowColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            Text('Enter your info exactly as it appears on your license so Kanan can verify your eligibility to route.',style: TextStyle(fontSize: 18,fontFamily: 'Arimo',fontWeight: FontWeight.w400,color: Colors.black),textAlign: TextAlign.start,),
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
