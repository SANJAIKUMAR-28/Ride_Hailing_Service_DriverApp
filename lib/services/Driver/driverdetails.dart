import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocitodriver/Home/homepage.dart';
import 'package:intl/intl.dart';

import '../../Utils/image_cropper_page.dart';
import '../../Utils/image_picker_class.dart';
import '../../Widgets/modal_dialog.dart';
import 'VechicleDetails.dart';


class DriverDetails extends StatefulWidget {
  const DriverDetails({super.key});

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  final userDateController = TextEditingController();
  final userExpDateController = TextEditingController();
  bool _isBusy = false;
  String name='';
  String license='';
  String expiry='';
  String dob = '';
  String lastname = '';
  String country='';
  TextEditingController controller = TextEditingController();
  String extractedText = '';
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final scanLicense = Material(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(151, 173, 182, 0.2)),
            borderRadius: BorderRadius.circular(5),
        ),
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(10,15,10,15),
          minWidth: MediaQuery.of(context).size.width,
          splashColor: Colors.black.withOpacity(0.2),
          onPressed:(){
            imagePickerModal(context, onCameraTap: () {
              log("Camera");
              pickImage(source: ImageSource.camera).then((value) {
                if (value != '') {
                  imageCropperView(value, context).then((value) {
                    if (value != '') {
                      final InputImage inputImage = InputImage.fromFilePath(value);
                      processImage(inputImage);
                    }
                  });
                }
              });
            }, onGalleryTap: () {
              log("Gallery");
              pickImage(source: ImageSource.gallery).then((value) {
                if (value != '') {
                  imageCropperView(value, context).then((value) {
                    if (value != '') {
                      imageCropperView(value, context).then((value) {
                        if (value != '') {
                          final InputImage inputImage = InputImage.fromFilePath(value);
                          processImage(inputImage);
                        }
                      });
                    }
                  });
                }
              });
            });

          } ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.document_scanner,color: Colors.redAccent[100],size: 40,),
              SizedBox(
                width: 10,
              ),
              Text("Scan license to autofill",textAlign: TextAlign.center,
            style:TextStyle(fontFamily:'Arimo',color: Colors. black,fontWeight: FontWeight.w500) ,
          ),]),
        ),
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
            Text('Enter your info exactly as it appears on your license so admin can verify your eligibility to route.',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.w400,color: Colors.black),textAlign: TextAlign.start,),
            SizedBox(
              height: 20,
            ),
            scanLicense,
            SizedBox(
              height: 20,
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
                              Text('${name}',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
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
                                Text('${lastname}',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
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
                                Text('${country}',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
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
                                Text('${license}',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
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
                                Text('${expiry}',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
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
                                Text('${dob}',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
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
  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });


    final RecognizedText recognizedText = await textRecognizer.processImage(
        image);

    extractedText = extractDetailsFromText(recognizedText);

    controller.text = recognizedText.text;

    setState(() {
      _isBusy = false;
    });
  }

  String extractDetailsFromText(RecognizedText recognizedText) {
    bool dobval=false;
    bool nameval= false;
    bool expiryval=false;
    bool lastnameval=false;

    // Iterate through text blocks and lines to extract DOB and account number
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        String lineText = line.text.trim();
        // Check for DOB with fixed length and certain pattern (e.g., "DOB: 01/01/1990")
        if(dobval){
          dob = lineText;
          setState(() {
            dobval=false;
            nameval=true;
          });
          continue;
        }
        if(nameval){
          name=lineText;
          setState(() {
            nameval=false;
          });
          continue;
        }
        if(expiryval){
          expiry=lineText;
          setState(() {
            expiryval=false;
          });
          continue;
        }
        if(lastnameval){
          lastname=lineText;
          setState(() {
            lastnameval=false;
          });
          continue;
        }
        if (lineText.contains('TN')) {
          int index = lineText.indexOf('T');
          license = lineText.substring(index,23);
        }

        // Check for account number with fixed length (e.g., 10 characters)
        if (lineText.contains('Date of Birth')) {
          setState(() {
            dobval=true;
          });
          continue;
        }
        if (lineText.contains('Valid Till')) {
          setState(() {
            expiryval=true;
          });
          continue;
        }
        if (lineText.contains('Son/Daughter/Wife of')) {
          setState(() {
            lastnameval=true;
          });
          continue;
        }
      }
    }
    country='India';
    // Return the extracted details formatted with headings
    return "License number: $license\nDate of birth: $dob\nFirst Name: $name\nLast Name: $lastname\nExpiry date: $expiry\nCountry: India";
  }
}
