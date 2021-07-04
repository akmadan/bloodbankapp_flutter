import 'package:blooddrop/utils/colors.dart';
import 'package:blooddrop/utils/text.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '../check.dart';
import 'nolocation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _mockCheckForSession();
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    bool permission = await Geolocator.isLocationServiceEnabled();
    if (permission) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Check()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => NoLocation()));
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    // image: DecorationImage(
                    //     image: AssetImage('assets/logo.png'))
                  ),
                ),
                SizedBox(height: 15),
                ModifiedText(
                    weight: FontWeight.bold,
                    text: 'BloodDrop',
                    color: AppColors.darkgrey,
                    size: 20),
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}
