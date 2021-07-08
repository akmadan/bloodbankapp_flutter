import 'package:blooddrop/utils/colors.dart';
import 'package:blooddrop/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RequestBubble extends StatefulWidget {
  final String name, address, contact, bg;
  final double lat, lon;
  static String distance = '';
  const RequestBubble(
      {Key? key,
      required this.name,
      required this.address,
      required this.contact,
      required this.bg,
      required this.lat,
      required this.lon})
      : super(key: key);

  @override
  _RequestBubbleState createState() => _RequestBubbleState();
}

class _RequestBubbleState extends State<RequestBubble> {
  @override
  void initState() {
    super.initState();
    getdistance();
  }

  getdistance() async {
    Position myposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double distanceInMeters = Geolocator.distanceBetween(
            myposition.latitude, myposition.longitude, widget.lat, widget.lon) /
        1000;
    setState(() {
      RequestBubble.distance = distanceInMeters.toStringAsFixed(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (widget.ismine == false) {
        //   showAlertDialog(context);
        // }
      },
      child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ModifiedText(
                                text: widget.name,
                                color: Colors.black,
                                size: 16,
                                weight: FontWeight.bold),
                            SizedBox(
                              height: 8,
                            ),
                            ModifiedText(
                                text: widget.address,
                                color: Colors.black,
                                size: 16,
                                weight: FontWeight.w600),
                            SizedBox(
                              height: 8,
                            ),
                            ModifiedText(
                                text: widget.contact,
                                color: Colors.black,
                                size: 16,
                                weight: FontWeight.w600),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ModifiedText(
                                  color: AppColors.primary,
                                  weight: FontWeight.bold,
                                  text: RequestBubble.distance + ' km away',
                                  size: 18,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(160),
                          color: AppColors.primary.withOpacity(0.8),
                        ),
                        child: Center(
                            child: ModifiedText(
                                text: widget.bg,
                                color: AppColors.white,
                                size: 16,
                                weight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}