// ignore: file_names
import 'package:carapp/accountPage.dart';
import 'package:carapp/SigninPage.dart';
import 'package:carapp/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authpage extends StatefulWidget {
  const Authpage({Key? key}) : super(key: key);
  
  @override
  State<Authpage> createState() => _Authpage();
}
  
  class _Authpage extends State<Authpage> {
    bool showAccountPage = true;

  void toggle() {
    setState(() {
      showAccountPage = !showAccountPage;
    });
  }

    @override
    Widget build(BuildContext context){
      if(showAccountPage){
        return SigninPage(showsignuppage: toggle);
      }
      else{
        return signup(showaccountPage: toggle);
      }
    }
  
  }    




