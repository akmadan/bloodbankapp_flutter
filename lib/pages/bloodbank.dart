import 'package:flutter/material.dart';

class BloodBank extends StatefulWidget {
  final String name, address, contact, bg;
  const BloodBank({
    Key? key,
    required this.name,
    required this.address,
    required this.contact,
    required this.bg,
  }) : super(key: key);

  @override
  _BloodBankState createState() => _BloodBankState();
}

class _BloodBankState extends State<BloodBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
    );
  }
}
