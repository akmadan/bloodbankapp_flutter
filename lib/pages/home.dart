import 'package:blooddrop/components/drawer.dart';
import 'package:blooddrop/utils/colors.dart';
import 'package:blooddrop/utils/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'allrequests.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String useruid = '';

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  getuserdata() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid.toString();
    setState(() {
      useruid = uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        uid: useruid,
      ),
      appBar: AppBar(
        title: ModifiedText(
            text: 'BloodDrop',
            color: AppColors.white,
            size: 18,
            weight: FontWeight.bold),
      ),
      body: All(
        useruid: useruid,
      ),
    );
  }
}
