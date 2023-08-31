import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:velocitodriver/Home/HomeScreen.dart';
import 'package:velocitodriver/Home/LocaleString.dart';
import 'package:velocitodriver/Login/LogIn.dart';
import 'package:velocitodriver/Screens/PickUp.dart';
import 'package:velocitodriver/Screens/startpage.dart';
import 'package:velocitodriver/services/Driver/VechicleDetails.dart';
import 'package:velocitodriver/services/Driver/driverdetails.dart';

import 'Login/SignUp.dart';
import 'Screens/splash.dart';
import 'Screens/terms.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocaleString(),
      locale: Locale('en','US'),
      debugShowCheckedModeBanner: false,
      title: 'Velo Drive',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Text('Something went wrong');
            }
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.data==null){
                return Login();
              }
              else{
                return HomeScreen();
              }
            }
            return Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}
