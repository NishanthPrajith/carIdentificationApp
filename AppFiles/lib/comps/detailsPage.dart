import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'infoCard.dart';
import 'carListItem.dart';

class DetailsPage extends StatefulWidget {
  final CarListItem carInfo;

  const DetailsPage({super.key, required this.carInfo});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final Color infoColor = const Color(0xff242424);

  bool alreadySaved = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final docId = widget.carInfo.id;

      final docRef = FirebaseFirestore.instance.collection("Users").doc(userId);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          if (data['saved'].contains(docId)) {
            setState(() {
              alreadySaved = true;
            });
          } else {
            setState(() {
              alreadySaved = false;
            });
          }
          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );
    });
    super.initState();
  }
  

  void save(userId, docId) {
    FirebaseFirestore.instance.collection("Users")
    .doc(userId)
    .update({
      'saved': FieldValue.arrayUnion([docId]),
    });
  }

  void unsave(userId, docId) {
    FirebaseFirestore.instance.collection("Users")
    .doc(userId)
    .update({
      'saved': FieldValue.arrayRemove([docId]),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xfff0f0f0)),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.black,
                              size: 32,
                            ),
                          )),
                        const Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Car Information",
                              style: TextStyle(
                                  fontFamily: 'sfPro',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          )),
                      FirebaseAuth.instance.currentUser != null ? Expanded(
                        flex: 2,
                        child: alreadySaved ? IconButton(
                          onPressed: (() {
                            setState(() {
                              unsave(FirebaseAuth.instance.currentUser!.uid, widget.carInfo.id);
                              alreadySaved = !alreadySaved;
                            });
                          }),
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 32,
                          )
                        ) : 
                        IconButton(
                          onPressed: (() {
                            setState(() {
                              save(FirebaseAuth.instance.currentUser!.uid, widget.carInfo.id);
                              alreadySaved = !alreadySaved;
                            });
                          }),
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 32,
                          )
                        ),
                      ) : const Expanded(
                        flex: 2,
                        child: SizedBox()
                      ), 
                    ],
                  )),
              Expanded(
                flex: 10,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xfff0f0f0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      const SizedBox(
                        height: 60,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Image.network(
                          widget.carInfo.image,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 8, bottom: 8),
                                  child: Text(
                                    widget.carInfo.make,
                                    style: const TextStyle(
                                      color: Color(0xFF424242),
                                      fontFamily: 'sfPro',
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      widget.carInfo.model,
                                      style: const TextStyle(
                                        fontFamily: 'sfPro',
                                        fontSize: 45,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                width: double.maxFinite,
                                child: Image.network(scale: 0.5, widget.carInfo.logo),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: const [
                          Icon(
                            color: Color(0xffA0A0A0),
                            Icons.info_outline,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Information",
                            style: TextStyle(
                                fontFamily: 'sfPro',
                                color: Color(0xffA0A0A0),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.6),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InformationDetail(
                          firstCategory: "Engine Location",
                          firstValue: widget.carInfo.engineLocation,
                          secondCategory: "Engine Type",
                          secondValue: widget.carInfo.engineType),
                      const SizedBox(
                        height: 15,
                      ),
                      InformationDetail(
                          firstCategory: "Engine Max Power",
                          firstValue: widget.carInfo.engineMaxPower,
                          secondCategory: "Drive",
                          secondValue: widget.carInfo.drive),
                      const SizedBox(
                        height: 15,
                      ),
                      InformationDetail(
                          firstCategory: "Engine Fuel Type",
                          firstValue: widget.carInfo.engineFuelType,
                          secondCategory: "Fuel Capacity",
                          secondValue: widget.carInfo.fuelCapacity),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                  height: 130,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: infoColor,
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.carInfo.transmissionType,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'sfPro',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      const Text(
                                        "Transmission Type",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'sfPro',
                                            color: Color(0xffA0A0A0),
                                            fontSize: 13),
                                      ),
                                    ],
                                  )),
                            ),
                          ]),
                      const SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
