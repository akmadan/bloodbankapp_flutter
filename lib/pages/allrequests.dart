import 'package:blooddrop/components/requestbubble.dart';
import 'package:blooddrop/utils/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class All extends StatefulWidget {
  final String useruid;

  const All({Key? key, required this.useruid}) : super(key: key);

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  String bloodgroup = 'All Requests';
  Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection('allrequests').snapshots();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade400.withOpacity(0.2),
            ),
            width: 200,
            height: 60.0,
            child: DropdownButton<String>(
              isExpanded: true,
              value: bloodgroup,
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  bloodgroup = newValue.toString();
                });
              },
              items: <String>[
                'All Requests',
                'A+',
                'A-',
                'B+',
                'B-',
                'AB+',
                'AB-',
                'O+',
                'O-'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: ModifiedText(
                      color: Colors.black,
                      weight: FontWeight.bold,
                      text: value,
                      size: 20),
                );
              }).toList(),
            )),
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
                    if (bloodgroup == 'All Requests') {
                      return RequestBubble(
                        name: data['hospitalname'],
                        address: data['hospitaladdress'],
                        contact: data['contact'],
                        bg: data['bg'],
                        lat: data['latitude'],
                        lon: data['longitude'],
                      );
                    } else {
                      if (data['bg'] == bloodgroup) {
                        return RequestBubble(
                          name: data['hospitalname'],
                          address: data['hospitaladdress'],
                          contact: data['contact'],
                          bg: data['bg'],
                          lat: data['latitude'],
                          lon: data['longitude'],
                        );
                      } else {
                        return Container();
                      }
                    }
                  }).toList(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
