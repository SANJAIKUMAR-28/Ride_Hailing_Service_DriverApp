import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocitodriver/Home/HomeScreen.dart';
import 'package:velocitodriver/services/Driver/VechicleDetails.dart';
import 'package:velocitodriver/services/Driver/driverdetails.dart';

import '../Home/homepage.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  bool loading = false;
  String lancode='en';
  String countrycode='US';
  bool val=false;
  bool val2=false;
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final emailField = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: emailEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Enter your email");
            }
            // if(!RegExp("^[a-zA-Z0-9+_.-]+@[bitsathy]+.[a-z]").hasMatch(value)){
            //   return("Please enter a valid email!");
            // }
            return null;
          },
          onSaved: (value) {
            emailEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.mail_outline,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Enter your email",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: InputBorder.none),
        ));
    final passwordField = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: passwordEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          validator: (value) {
            RegExp regex = new RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please enter valid password(Min. 6 character");
            }
          },
          onSaved: (value) {
            passwordEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Password",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              // suffixIcon: InkWell(
              //   onTap: _toggleview,
              //   child: Icon(
              //     _isHidden
              //         ?Icons.visibility_off_outlined
              //         :Icons.visibility_outlined,
              //     color: Color.fromRGBO(0, 0, 0, 1.0),
              //   ),
              // ),
              border: InputBorder.none),
        ));
    final loginButton = Material(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(255, 51, 51, 0.9),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          signIn(emailEditingController.text, passwordEditingController.text);
        },
        child:  loading? SizedBox( height:22,width: 22,child:CircularProgressIndicator(color: Colors.white,)):Text(
          "Login >",
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/loginimg.png',
                    fit: BoxFit.fill,
                    height: 200,
                    width: 250,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  emailField,
                  SizedBox(
                    height: 15,
                  ),
                  passwordField,
                  SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 195,
                    ),
                    InkWell(
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Arimo',
                            color: Color.fromRGBO(255, 51, 51, 1.0),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {},
                    ),
                  ]),
                  SizedBox(height: 100),
                  loginButton,
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("New Member?",
                          style: TextStyle(
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w900)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        child: Text(" Register now",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 51, 51, 1.0),
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Choose language',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Color.fromRGBO(62, 73,88, 1.0) ),),
                            SizedBox(height: 20,),
                            Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color.fromRGBO(151, 173, 182, 0.2)),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: MaterialButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () async {
                                    setState(()  {
                                      lancode='en';
                                      countrycode='US';
                                      val=!val;
                                    });

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        (val)?
                                        Icon(Icons.circle,color: Color.fromRGBO(255, 51, 51, 1.0),size: 10,):Icon(Icons.circle,color: Colors.grey,size: 10,),
                                        SizedBox(width: 10,),
                                        const Text("English",textAlign: TextAlign.left,
                                            style: TextStyle(fontWeight: FontWeight.w500,
                                                fontSize: 18,fontFamily: 'Arimo',color: Color.fromRGBO(255, 51, 51, 1.0))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color.fromRGBO(151, 173, 182, 0.2)),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: MaterialButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () async {
                                    setState(() {
                                      lancode='ta';
                                      countrycode='IN';
                                      val2=!val2;
                                    });

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        (val2)?
                                        Icon(Icons.circle,color: Color.fromRGBO(255, 51, 51, 1.0),size: 10,):Icon(Icons.circle,color: Colors.grey,size: 10,),
                                        SizedBox(width: 10,),
                                        const Text("தமிழ்",textAlign: TextAlign.left,
                                            style: TextStyle(fontWeight: FontWeight.w500,
                                                fontSize: 18,fontFamily: 'Arimo',color: Color.fromRGBO(255, 51, 51, 1.0))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            SizedBox(
                              width:200,
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(255, 51, 51, 0.9),
                                child: MaterialButton(
                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () async {
                                    var locale = Locale(lancode,countrycode);
                                    Get.updateLocale(locale);
                                    Navigator.of(context).pop();
                                  },
                                  child:  Text(
                                    "Change",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Arimo',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              });

        },
        child: Icon(LineIcons.language,color: Colors.white,),
      ),
    );
  }
  void signIn(String email,String password) async
  {
    setState(() {
      loading = true;
    });
    if (_formkey.currentState!.validate()) {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password)
          .then((uid) =>
      {
        Fluttertoast.showToast(msg: "Login successful"),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())),

      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
        setState(() {
          loading = false;
        });
      });
    }
  }
}
