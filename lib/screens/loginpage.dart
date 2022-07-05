import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late String _email;
  late String _password;

  Future<void> _createUser() async {
//wrap sign in anon inside try and catch to get errors
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
    print("User: $userCredential");
  } on FirebaseAuthException catch (e) {
    print("Error: $e");
  } catch (e) {
    print("Error: $e");
  }
  }

  Future<void> _login() async {
//wrap sign in anon inside try and catch to get errors
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height_variable = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text("Login Page"),
      ),
      //make column as the body, add padding for text input
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height_variable/ 3,
            margin: EdgeInsets.symmetric(vertical: 15.0),
            child: Image(
              image: AssetImage('assets/images/b.png'),
            ),
          ),
          TextField(
            //submit value inside the email variable
            onChanged: (value) {
              _email = value;
            },
          decoration: InputDecoration(
              hintText: "Enter Email...."
      ),
      ),
      TextField(
        onChanged: (value) {
          _password = value;
        },
        decoration: InputDecoration(
            hintText: "Enter password..."
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
    children: [
      MaterialButton(
        onPressed: _login,
      child: Text("Login"),
      ),
       MaterialButton(
          onPressed: _createUser,
          child: Text("Create New Account"),
        )
    ],
      )
        ],
    ),
        ),
    );
  }
}