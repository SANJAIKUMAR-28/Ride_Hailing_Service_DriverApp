import 'package:flutter/material.dart';
import 'package:velocitodriver/Login/LogIn.dart';

import '../Home/homepage.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
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
          "Submit",
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            ClipRRect(
                child: Image.asset("assets/term.png",
                  height: 90,
                  width: 80,
                )),
            SizedBox(
              height: 15,
            ),
            Text('Accept Velocito’s Terms & Review Privacy Policy',style: TextStyle(fontSize: 24,fontFamily: 'Arimo',fontWeight: FontWeight.w900,color: Colors.black),textAlign: TextAlign.start,),
            SizedBox(height: 10),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'By selecting “I Agree” Below, I have reviewed and agree to the ',
                  style: TextStyle(fontFamily: 'Arimo', fontSize: 16,)),
              TextSpan(
                  text: 'Terms of Use',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.redAccent,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 51, 51, 1.0))),
              TextSpan(
                  text: ' and acknowledge the ',
                  style: TextStyle(fontFamily: 'Arimo')),
              TextSpan(
                  text: 'Privacy policy',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.redAccent,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 51, 51, 1.0))),
              TextSpan(
                  text: ' I am at least 18 years of age.',
                  style: TextStyle(fontFamily: 'Arimo')),
            ])),
            SizedBox(height: 200),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.red,
                  value: _myBoolean,
                  onChanged: (value) {
                    setState(() {
                      _myBoolean = value!; // rebuilds with new value
                    });
                  },
                ),
                Text('I Agree',style: TextStyle(fontFamily:'Arimo',fontSize: 16,fontWeight: FontWeight.w500,),)
              ],
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

class CheckboxProvider with ChangeNotifier {
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }
}
