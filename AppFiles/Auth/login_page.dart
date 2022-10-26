
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key})  :super(key:key);

  @override 
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  //controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future SignIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      );
  }



  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(45, 224, 224, 224),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Hello again 
              Text(
                'Hello again',
                style: TextStyle (
                  fontWeight: FontWeight.bold,
                  fontSize: 36,),),
              SizedBox(height: 10),

              Text(
                'Welcome back you have been misszed',
                style: TextStyle (
                  fontSize: 20,),
                  ),
                  SizedBox(height: 50),
          
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(73, 238, 238, 238),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                          ),
                      // email Text

                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border:  InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
              SizedBox(height: 20),
              // Password
              Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(73, 238, 238, 238),
                          border: Border.all(color: Color.fromARGB(83, 255, 255, 255)),
                          borderRadius: BorderRadius.circular(12),
                          ),
          
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border:  InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ),
                  ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: SignIn,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12)),
                    child:  Center(
                      child:  Text('Sign In',
                      style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              // Signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(' Sign up',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

}