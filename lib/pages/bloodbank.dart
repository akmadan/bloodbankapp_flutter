import 'package:blooddrop/components/requestbubble.dart';
import 'package:blooddrop/utils/colors.dart';
import 'package:blooddrop/utils/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodBank extends StatefulWidget {
  final String name, address, contact, bg, bloodbankid;
  const BloodBank({
    Key? key,
    required this.name,
    required this.address,
    required this.contact,
    required this.bg,
    required this.bloodbankid,
  }) : super(key: key);

  @override
  _BloodBankState createState() => _BloodBankState();
}

class _BloodBankState extends State<BloodBank> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> collectionStream = FirebaseFirestore.instance
        .collection('bloodbanks')
        .doc(widget.bloodbankid)
        .collection('requests')
        .snapshots();
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ModifiedText(
                text: 'Blood Bank Details',
                color: Colors.black,
                size: 28,
                weight: FontWeight.bold),
            SizedBox(height: 14),
            ModifiedText(
                text: widget.name,
                color: Colors.black,
                size: 16,
                weight: FontWeight.bold),
            ModifiedText(
                text: widget.address,
                color: Colors.black,
                size: 16,
                weight: FontWeight.normal),
            InkWell(
              onTap: () => launch("tel://" + widget.contact),
              child: ModifiedText(
                  text: widget.contact,
                  color: AppColors.primary,
                  size: 16,
                  weight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            ModifiedText(
                text: 'Available Blood Groups',
                color: Colors.black,
                size: 28,
                weight: FontWeight.bold),

            //------------------------------------------------------
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: collectionStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return new ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;

                        return RequestBubble(
                          move: false,
                          bloodbankid: data['uid'],
                          name: data['hospitalname'],
                          address: data['hospitaladdress'],
                          contact: data['contact'],
                          bg: data['bg'],
                          lat: data['latitude'],
                          lon: data['longitude'],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
