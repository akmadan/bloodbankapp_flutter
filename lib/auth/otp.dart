import 'package:blooddrop/pages/home.dart';
import 'package:blooddrop/utils/colors.dart';
import 'package:blooddrop/utils/constants.dart';
import 'package:blooddrop/utils/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.grey[100],
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: AppColors.darkgrey,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 50),
            Container(
              height: width! / 1.2,
              width: width! / 1.2,
              padding: EdgeInsets.all(20),
              child: Lottie.asset('assets/doctor2.json'),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Center(
                child: ModifiedText(
                  weight: FontWeight.bold,
                  text: 'OTP sent to +91' + widget.phone,
                  size: 22,
                  color: AppColors.darkgrey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
                eachFieldWidth: 40.0,
                eachFieldHeight: 55.0,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,
                pinAnimationType: PinAnimationType.fade,
                onSubmit: (pin) async {
                  try {
                    await FirebaseAuth.instance.signInWithCredential(
                        PhoneAuthProvider.credential(
                            verificationId: _verificationCode!, smsCode: pin));
                    // final uid = FirebaseAuth.instance.currentUser!.uid;
                    // await FirebaseFirestore.instance
                    //     .collection('users')
                    //     .doc(uid)
                    //     .set({
                    //   'uid': uid,
                    //   'phone': widget.phone,
                    // });
                    Navigator.pop(context);
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    _scaffoldkey.currentState!
                        .showSnackBar(SnackBar(content: Text('invalid OTP')));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
