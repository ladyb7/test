import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/screens/loginpage.dart';
import 'package:flutter_firebase_login/screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: FirebaseOptions(
      apiKey: "AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0", // Your apiKey
      appId: "1:448618578101:ios:0b650370bb29e29cac3efc", // Your appId
      messagingSenderId: "448618578101", // Your messagingSenderId
      projectId: "react-native-firebase-testing", // Your projectId
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HAFAZ.',
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  //initialize our app
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      //get a snapshot of data
      builder: (context, snapshot) {
      //check if data has error, return Scaffold
        if(snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

          if(snapshot.connectionState == ConnectionState.done) {
            //use streambuilder firebase live to see if users are logged in and pergi dkt checking method (if user==null) etc
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  //to check if connection state is active
                  if (snapshot.connectionState == ConnectionState.active) {
                    //get user from snapshot
                    User? user = snapshot.data as User?;

                    if (user == null) {
                      return LoginPage();
                    } else {
                      return Homepage();
                    }
                  }

                  return Scaffold(
                    body: Center(
                      child: Text("Checking Authentication..."),
                    ),
                  );
                },
            );
          }

          return Scaffold(
            body: Center(
              child: Text("Connecting to the app...."),
            ),
          );
      },
    );

  }
}




