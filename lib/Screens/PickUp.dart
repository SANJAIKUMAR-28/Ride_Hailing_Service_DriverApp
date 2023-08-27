import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PickUp extends StatefulWidget {
  const PickUp({super.key});

  @override
  State<PickUp> createState() => _PickUpState();
}

class _PickUpState extends State<PickUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ElevatedButton(
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context){
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children:[
Text('pickup'),
                ],
              ),
            );
          });
        }, child: Text('Bottomsheet'),
      )
    );
  }
}
