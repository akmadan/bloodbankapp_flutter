import 'package:blooddrop/auth/welcome.dart';
import 'package:blooddrop/utils/colors.dart';
import 'package:blooddrop/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // appBarTheme:
          //     AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
          primaryColor: AppColors.primary,
          brightness: Brightness.light),
      home: Welcome(),
    );
  }
}
