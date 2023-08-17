import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({super.key});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
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
                child: MaterialButton(
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vehicle Make',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.w400),),
                      Text('Volkwagen',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                    ],
                  ),
                ),
              ),
              Divider(),
              Material(
                child: MaterialButton(
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vehicle Type',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.w400),),
                      Text('Jeta',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                    ],
                  ),
                ),
              ),
              Divider(),
              Material(
                child: MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vehicle Plate Number',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.w400),),
                      Text('TN 39 BR 1446',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                    ],
                  ),
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
                            Icon(Icons.check_circle,color: Color.fromRGBO(153, 153, 153, 1),),
                          SizedBox(width: 10,),
                          Text('Insurace Certificate',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                          ]
                          ),
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
                                Icon(Icons.check_circle,color: Color.fromRGBO(153, 153, 153, 1),),
                                SizedBox(width: 10,),
                                Text('Registration Certificate',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                              ]
                          ),
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
                                Icon(Icons.check_circle,color: Color.fromRGBO(153, 153, 153, 1),),
                                SizedBox(width: 10,),
                                Text('MOT Certificate',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey),),
                              ]
                          ),
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
}
