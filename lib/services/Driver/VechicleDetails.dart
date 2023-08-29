import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:velocitodriver/Screens/terms.dart';
import 'dart:io';
import 'dart:math';

import '../../Home/homepage.dart';
class VehicleDetails extends StatefulWidget {
  final String uid;
  final String name;
  const VehicleDetails({super.key, required this.uid, required this.name});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  String IC ='0';
  String RC='0';
  String MC='0';
  List<Map<String, dynamic>> dropdownItems = [];
  final CollectionReference ref = FirebaseFirestore.instance.collection("drivers");
  List<String> dropdownMakes = [];
  List<String> dropdownModels = [];
  String selectedMake = 'Make';
  String selectedModel = 'Model';
  String vehicleNumber="Vehicle Number";
  final vehicleController=new TextEditingController();
  @override
  void initState() {
    super.initState();
    loadCSVData();
  }

  Future<void> loadCSVData() async {
    String csvData = await rootBundle.loadString('assets/data.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);

    for (var row in csvTable) {
      if (row.length >= 2) {
        dropdownItems.add({
          'make': row[0].toString(),
          'model': row[1].toString(),
        });
      }
    }

    Set<String> uniqueMakes = Set<String>();
    for (var item in dropdownItems) {
      uniqueMakes.add(item['make']);
    }

    setState(() {
      dropdownMakes = List<String>.from(uniqueMakes)..sort();
    });

    loadModelsForMake(selectedMake);
  }

  void loadModelsForMake(String make) {
    List<String> models = [];
    for (var item in dropdownItems) {
      if (item['make'] == make) {
        models.add(item['model']);
      }
    }
    setState(() {
      dropdownModels = models..sort();
      if (dropdownModels.isNotEmpty) {
        selectedModel = dropdownModels[0];
      } else {
        selectedModel = 'Model';
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Vehicle details',
          style: TextStyle(fontFamily: 'Arimo',),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add your vehicle info',style: TextStyle(fontFamily: 'Arimo',fontSize: 24,fontWeight: FontWeight.w600),),
              Text('Please provide details about your vehicle & kindly upload the Certificate.',style: TextStyle(fontFamily: 'Arimo',fontSize: 16,fontWeight: FontWeight.w400),),
              SizedBox(height: 15,),
              Divider(),
              Material(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Vehicle Make',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.w400),),
                    DropdownButton<String>(
                      value: selectedMake,
                      alignment: AlignmentDirectional.centerEnd,
                      icon: SizedBox.shrink(),
                      underline: Container(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedMake = newValue!;
                          loadModelsForMake(selectedMake);
                        });
                      },
                      items: dropdownMakes.map((make) {
                        return DropdownMenuItem<String>(
                          value: make,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(make,style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Divider(),
              Material(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Vehicle Type',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.w400),),
                    DropdownButton<String>(
                      value: selectedModel,
                      icon: SizedBox.shrink(),
                      alignment: AlignmentDirectional.centerEnd,
                      underline: Container(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedModel = newValue!;
                        });
                      },
                      items: dropdownModels.map((model) {
                        return DropdownMenuItem<String>(
                          value: model,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(model,style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Divider(),
              Material(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Vehicle Plate Number',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.w400),),
                    Container(
                      child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  surfaceTintColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              content: Container(
                              height: 180,
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Material(
                              borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(196, 196, 196, 0.2),
                                child: TextFormField(
                                  autofocus: false,
                                  controller: vehicleController,
                                  style: TextStyle(fontFamily: 'Arimo'),
                                  keyboardType: TextInputType.text,
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
                                    vehicleController.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.car_crash,
                                        color: Colors.grey,
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                      hintText: "Vehicle Number",
                                      hintStyle: TextStyle(fontFamily: 'Arimo'),
                                      border: InputBorder.none),
                                )),
                                  SizedBox(height: 20,),
                                  SizedBox(
                                    width: 150,
                                    child: Material(
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromRGBO(255, 51, 51, 1.0),
                                      child: MaterialButton(
                                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                        minWidth: MediaQuery.of(context).size.width,
                                        onPressed: () async {
                                          setState(() {
                                            vehicleNumber=vehicleController.text.toUpperCase();
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child:  Text(
                                          "Done",
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
                              );
                            },
                          );
                        },
                          child: Text(vehicleNumber,style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),)),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 5,),
              Text('Upload Certificates*',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.w400),),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5)
                ),
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(5),
                    color: Color.fromRGBO(153, 153, 153, 1),
                    strokeWidth: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                        children:[
                          (IC=='0')?
                            Icon(Icons.check_circle,color: Color.fromRGBO(153, 153, 153, 1),):Icon(Icons.check_circle,color: Color.fromRGBO(255, 51, 51, 0.9),),
                          SizedBox(width: 10,),
                          Text('Insurace Certificate',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                          ]
                          ),
                          (IC=='0')?
                          SizedBox(
                            width:100,
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(255, 51, 51, 0.9),
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  final path = await FlutterDocumentPicker.openDocument();
                                  print(path);
                                  File file = File(path!);
                                  firebase_storage.UploadTask? task = await uploadFile(file,'IC');
                                },
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.file_upload_outlined,color: Colors.white,size: 20,),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Upload",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Arimo',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ):SizedBox(
                            width:100,
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(153, 153, 153, 0.9),
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                 setState(() {
                                   IC='0';
                                 });
                                 firebase_storage.FirebaseStorage.instance
                                     .ref()
                                     .child('New Driver Requests')
                                     .child('/${widget.name}')
                                     .child('/${widget.name}-IC.pdf').delete();
                                },
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.cancel_outlined,color: Colors.white,size: 20,),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Clear",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Arimo',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)
                ),
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(5),
                    color: Color.fromRGBO(153, 153, 153, 1),
                    strokeWidth: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              children:[
                                (RC=='0')?
                                Icon(Icons.check_circle,color: Color.fromRGBO(153, 153, 153, 1),):Icon(Icons.check_circle,color: Color.fromRGBO(255, 51, 51, 0.9),),
                                SizedBox(width: 10,),
                                Text('Registration Certificate',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                              ]
                          ),
                  (RC=='0')?
                          SizedBox(
                            width:100,
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(255, 51, 51, 0.9),
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  final path = await FlutterDocumentPicker.openDocument();
                                  print(path);
                                  File file = File(path!);
                                  firebase_storage.UploadTask? task = await uploadFile(file,'RC');
                                },
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.file_upload_outlined,color: Colors.white,size: 20,),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Upload",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Arimo',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ):SizedBox(
                  width:100,
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(153, 153, 153, 0.9),
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        setState(() {
                          RC='0';
                        });
                        firebase_storage.FirebaseStorage.instance
                            .ref()
                            .child('New Driver Requests')
                            .child('/${widget.name}')
                            .child('/${widget.name}-RC.pdf').delete();
                      },
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel_outlined,color: Colors.white,size: 20,),
                          SizedBox(width: 5,),
                          Text(
                            "Clear",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Arimo',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                        ],
                      ),
                    )),
              ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)
                ),
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(5),
                    color: Color.fromRGBO(153, 153, 153, 1),
                    strokeWidth: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              children:[
                                (MC=='0')?
                                Icon(Icons.check_circle,color: Color.fromRGBO(153, 153, 153, 1),):Icon(Icons.check_circle,color: Color.fromRGBO(255, 51, 51, 0.9),),
                                SizedBox(width: 10,),
                                Text('MOT Certificate',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                              ]
                          ),
                          (MC=='0')?
                          SizedBox(
                            width:100,
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(255, 51, 51, 0.9),
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  final path = await FlutterDocumentPicker.openDocument();
                                  print(path);
                                  File file = File(path!);
                                  firebase_storage.UploadTask? task = await uploadFile(file,'MC');
                                },
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.file_upload_outlined,color: Colors.white,size: 20,),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Upload",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Arimo',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ):SizedBox(
                            width:100,
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(153, 153, 153, 0.9),
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  setState(() {
                                    MC='0';
                                  });
                                   firebase_storage.FirebaseStorage.instance
                                      .ref()
                                      .child('New Driver Requests')
                                      .child('/${widget.name}')
                                      .child('/${widget.name}-MC.pdf').delete();
                                },
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.cancel_outlined,color: Colors.white,size: 20,),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Clear",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Arimo',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
          SizedBox(height: 30,),
          Material(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(255, 51, 51, 0.9),
            child: MaterialButton(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                ref.doc(widget.uid).update({
                  'Vehicle-make':selectedMake,
                  'Vehicle-type':selectedModel,
                  'Vehicle-number':vehicleNumber,
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Terms()));
              },
              child: Text(
                "Save & Continue",
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
    );
  }
  Future<firebase_storage.UploadTask?> uploadFile(File file,String sts) async {
    // ignore: unnecessary_null_comparison
    if (file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text("Unable to upload"),
      ));
      return null;
    }

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('New Driver Requests')
          .child('/${widget.name}')
          .child('/${widget.name}-${sts}.pdf');


    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);
    setState(() {
      if(sts=='IC') {
        IC = '1';
      }
      else if(sts=='RC')
      {
        RC = '1';
      }
      else if(sts=="MC"){
        MC = "1";
      }
    });
    print("done..!");
    return Future.value(uploadTask);
  }
}
