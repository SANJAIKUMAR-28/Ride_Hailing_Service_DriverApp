import 'package:flutter/material.dart';

void imagePickerModal(BuildContext context,
    {VoidCallback? onCameraTap, VoidCallback? onGalleryTap}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 220,
          child: Column(
            children: [
              GestureDetector(
                onTap: onCameraTap,
                child: Card(
                  child: SizedBox(
                    width: 300,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 51, 51, 1.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: const Text("Camera",textAlign: TextAlign.center,
                            style: TextStyle(
                                 fontSize: 18,fontFamily: 'Arimo',color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: onGalleryTap,
                child: Card(
                  child: SizedBox(
                    width: 300,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 51, 51, 1.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: const Text("Gallery",textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,fontFamily: 'Arimo',color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}