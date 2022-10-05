import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'comps/carListItem.dart';

class CarInfo {
  CarInfo({required this.name});
  final String name;
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = "";

  final fieldText = TextEditingController();

  final Stream<QuerySnapshot> _carsStream = FirebaseFirestore.instance
      .collection('CarData')
      .orderBy('Make')
      .snapshots();

  void clearText() {
    fieldText.clear();
  }

  String valExists(String? value) => value ?? 'None';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xffcecece),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: Color(0xffa0a0a0),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (text) {
                      setState(() {
                        _searchQuery = text;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontFamily: 'sfPro',
                        decoration: TextDecoration.none,
                        color: Color(0xff464646),
                      ),
                    ),
                    controller: fieldText,
                  ),
                ),
                if (_searchQuery != "")
                  GestureDetector(
                    onTap: () {
                      clearText();
                      setState(() {
                        _searchQuery = "";
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: Color(0xffa0a0a0),
                    ),
                  ),
              ],
            ),
          ),
          const Expanded(
            flex: 2,
            child: SizedBox(
              height: 0,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: const Text('Search results',
                    style: TextStyle(
                      fontFamily: 'sfPro',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ))),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 0,
            ),
          ),
          Expanded(
              flex: 20,
              child: StreamBuilder<QuerySnapshot>(
                stream: _carsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return CarListItem(
                        make: valExists(data['Make']),
                        model: valExists(data['Model']),
                        engineLocation: valExists(data['Engine Location']),
                        engineType: valExists(data['Engine Type']),
                        engineMaxPower: valExists(data['Engine Max Power']),
                        drive: valExists(data['Drive']),
                        engineFuelType: valExists(data['Engine Fuel Type']),
                        fuelCapacity: valExists(data['Fuel Capacity']),
                        transmissionType: valExists(data['Transmission Type']),
                      );
                    }).toList(),
                  );
                },
              )),
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
