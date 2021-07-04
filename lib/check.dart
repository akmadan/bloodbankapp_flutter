import 'package:blooddrop/auth/welcome.dart';
import 'package:blooddrop/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(), 
            builder: (context, usersnapshot) {
              if (usersnapshot.hasData) {
                return Home();
              } else {
                return Welcome();
              }
            }));
  }
}
