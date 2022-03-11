// ignore_for_file: deprecated_member_use

import 'package:sellshoes/homepage.dart';
import 'package:sellshoes/login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellshoes/MyAppBar.dart';
import 'package:sellshoes/signup.dart';

import 'constants.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool is_Loading = false;
  String registerEmail = "", registerPassword = "";
  FocusNode PasswordFocus = FocusNode();

  Future<void> _digBuilder(String msg) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text("Error Happends!${msg}"),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"),
              ),
            ],
          );
        });

    setState(() {
      is_Loading = false;
    });
  }

  Future<String?> createUserAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerEmail, password: registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
        return "Password is so weak. Give a Strong Password";
      else if (e.code == 'email-already-in-use')
        return "Email is already in use Try new One";
    } catch (e) {
      return "Error Message is: ${e.toString()}";
    }
    return "Unable To Execute Method";
  }

  void submitForm() async {
    String? retValue = await createUserAccount();
    setState(() {
      is_Loading = true;
    });
    if (retValue != null) {
      _digBuilder(retValue);
      setState(() {
        is_Loading = false;
      });
    }
    if (retValue == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HoemPage()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "ShoeSha | Signup",
      ),
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 50, left: 12, right: 12),
                  child: Text(
                    "Welcome User, Create Your Account",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 110, 100, 4),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 110, 100, 4), width: 2.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        registerEmail = value;
                      },
                      onSubmitted: (value) {
                        PasswordFocus.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email..",
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w200,
                          color: Color.fromARGB(255, 110, 100, 4),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w200,
                        color: Color.fromARGB(255, 110, 100, 4),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 110, 100, 4), width: 2.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        registerPassword = value;
                      },
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        submitForm();
                      },
                      focusNode: PasswordFocus,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password..",
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w200,
                          color: Color.fromARGB(255, 110, 100, 4),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w200,
                        color: Color.fromARGB(255, 110, 100, 4),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // _digBuilder();
                    print('btn');

                    submitForm();
                  },
                  child: Stack(
                    children: [
                      Visibility(
                        visible: is_Loading ? false : true,
                        child: Container(
                          child: Center(
                            child: Text("Signup",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 211, 190, 0),
                                )),
                          ),
                          height: 60,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: is_Loading,
                          child: Container(
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Color.fromARGB(255, 110, 100, 4),
                                  )),
                            )),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 200),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "Back To Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 110, 100, 4),
                        ),
                      ),
                    ),
                    height: 60,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 110, 100, 4), width: 2.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
