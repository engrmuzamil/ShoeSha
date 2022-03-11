import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellshoes/constants.dart';
import 'package:sellshoes/homepage.dart';
import 'package:sellshoes/login.dart';
import 'package:sellshoes/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text("Error: ${snapshot.error}")));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          //it return login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
              if (snapshot2.hasError) {
                return Scaffold(
                    body: Center(child: Text("Error: ${snapshot.error}")));
              }
              if (snapshot2.connectionState == ConnectionState.active) {
                print("Welcome Here....");
                User? _user = snapshot2.data;
                if (_user == null) {
                  return Signup();
                } else {
                  return HoemPage();
                }
              }
              return Scaffold(
                  body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text("Checking Authentication....",
                          style: constants2.heading1)),
                  Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  )),
                ],
              ));
            },
          );
        }
        return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
          color: Colors.black,
        )));
      },
    );
  }
}
