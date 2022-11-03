import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDataComp extends StatefulWidget {
  const UserDataComp({Key? key}) : super(key: key);

  @override
  State<UserDataComp> createState() => _UserDataCompState();

}

class _UserDataCompState extends State<UserDataComp> {
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
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
          )
        ],
      ),
    );
  }
}