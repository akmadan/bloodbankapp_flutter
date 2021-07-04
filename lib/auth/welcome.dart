import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blooddrop/utils/colors.dart';
import 'package:blooddrop/utils/constants.dart';
import 'package:blooddrop/utils/text.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'otp.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _formkey = GlobalKey<FormState>();
  var phone = '';
  void trysubmit() async {
    
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState!.save();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OTPScreen(phone)));
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Container(
        height: height,
        width: width,
        child: ListView(
          children: [
            SizedBox(height: height! / 20),
            Container(
              height: width! / 1.2,
              width: width! / 1.2,
              padding: EdgeInsets.all(20),
              child: Lottie.asset('assets/doctor1.json'),
            ),
            Container(
              width: width,
              padding: EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Welcome Back!',
                          textStyle: GoogleFonts.rubik(
                              color: AppColors.darktext,
                              fontSize: 34,
                              fontWeight: FontWeight.w600),
                          speed: const Duration(milliseconds: 200),
                        ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 500),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                    SizedBox(height: 20),
                    ModifiedText(
                        weight: FontWeight.bold,
                        text: 'Easily Find Blood ',
                        color: AppColors.darktext,
                        size: 20),
                    ModifiedText(
                        weight: FontWeight.w600,
                        text: 'in Your Nearby Blood Banks!',
                        color: AppColors.darktext,
                        size: 24),
                  ]),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    //---------------- PHONE ----------------------
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade400.withOpacity(0.2),
                      ),
                      padding: EdgeInsets.all(10),
                      height: 70,
                      child: Center(
                        child: TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          cursorColor: Theme.of(context).primaryColor,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            hintText: "Enter 10 digit Contact No.",
                          ),
                          key: ValueKey('phone'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Incorrect Phone';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            phone = value.toString();
                          },
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),

                    //---------------- PHONE ----------------------
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 54,
              width: width,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary)),
                onPressed: () {
                  trysubmit();
                },
                child: ModifiedText(
                  text: 'Authenticate via OTP',
                  color: AppColors.white,
                  size: 20,
                  weight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
