import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();

}

class _AccountPageState extends State<AccountPage> {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Account Page"),
            Text('Signed in as: ' + user.email!),
            MaterialButton(onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: Color.fromARGB(255, 89, 0, 253),
            child: Text('Sign out'),

            )

          ],
        )),
    );
  }
}
