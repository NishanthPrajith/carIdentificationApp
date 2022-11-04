import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './../comps/carListItem.dart';

class UserDataComp extends StatefulWidget {
  const UserDataComp({Key? key}) : super(key: key);

  @override
  State<UserDataComp> createState() => _UserDataCompState();

}

class _UserDataCompState extends State<UserDataComp> {

  String valExists(String? value) => value ?? 'None';

  List currentSaved = [];
  bool check = false;

  @override
  void initState() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance.collection("Users").doc(userId);
    docRef.snapshots().listen(
      (event) {
        setState(() {
          currentSaved = event.data()!['saved'];
          if (currentSaved.length > 0) {
            check = true;
          }
        });
      },
      onError: (error) => print("Listen failed: $error"),
    );
    super.initState();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getResultStream() {
    // case-insensitive substring search of make or model in cloud firestore
    return FirebaseFirestore.instance
            .collection("CarData")
            .orderBy('Make')
            .snapshots();
  }


  Widget build(BuildContext context){

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * (9 / 14),
      margin: const EdgeInsets.only(top: 65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Container(
                width: 100,
                height: 100,
                child: Image.network(
                  "https://avatars.dicebear.com/v2/avataaars/:"+ (FirebaseAuth.instance.currentUser!.displayName ?? "temp") +".png?background=%23000000",
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              "${FirebaseAuth.instance.currentUser!.displayName}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 35),
          const Text(
            "Favorite Cars",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),
          check ? Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getResultStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
          
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                print(snapshot.data!.docs.length);
                print(check);
                final userId = FirebaseAuth.instance.currentUser!.uid;

                if (currentSaved.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text("No saved cars"),
                  );
                }
                return ListView(
                  children:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      if (currentSaved.contains(document.id)) {
                        return CarListItem(
                          id: document.id,
                          make: valExists(data['Make']),
                          model: valExists(data['Model']),
                          engineLocation: valExists(data['Engine Location']),
                          engineType: valExists(data['Engine Type']),
                          engineMaxPower: valExists(data['Engine Max Power']),
                          drive: valExists(data['Drive']),
                          engineFuelType: valExists(data['Engine Fuel Type']),
                          fuelCapacity: valExists(data['Fuel Capacity']),
                          transmissionType: valExists(data['Transmission Type']),
                          image: valExists(data['Image']),
                          logo: valExists(data['Logo']),
                        );
                      } else {
                        return const SizedBox(
                          height: 0,
                        );
                      }
                  }).toList(),
                );
              },
            ),
          ) : const Text("No Saved Cars"),
        ],
      ),
    );
  }
}